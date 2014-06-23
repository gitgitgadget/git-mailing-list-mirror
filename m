From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pb/trim-trailing-spaces (Re: What's cooking in git.git (Jun 2014,
 #05; Fri, 20))
Date: Mon, 23 Jun 2014 16:17:28 -0700
Message-ID: <CAPc5daXpLQLaYMwzZhyAY5r5=fWB705AwJon7xSyMn8856pxcA@mail.gmail.com>
References: <xmqqr42jcj5l.fsf@gitster.dls.corp.google.com> <20140623231303.GD4445@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:17:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzDUn-0006B9-UA
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 01:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbaFWXRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 19:17:50 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36606 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaFWXRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 19:17:50 -0400
Received: by mail-lb0-f170.google.com with SMTP id 10so5576578lbg.29
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FXr8DXo55y7+iL4ujDI7aw57xdM0fVLnJ3yH5F9fQYQ=;
        b=hl8ksP7e+uBfEKqMnKWhatkA9Y9iDWYMQzYvnhoy3ARX2VuRyGxOwW42tTuOY9v/Ma
         ev5DdEJOvRUdZK/Fob3C8s/yrk1sYsXsWHTl+Loo6UpzYQ75ub8g1GavImyTi7+eBsvl
         /lFi5GZdTxZujfLtDC0+pSE/J5QCxRagAFTnlcOEqiDvmPoUwW+cn5z4dnJ2J9Ady2/F
         kPtAH4PAft3aZForgfQnzdikcgLOs6PgYyfzLlHFC5SHWIygHXdFnpP4jODRlC8hStZN
         A/CN23EWiBSJ7Fk+V/RUz9FivZwFfWngC7PosjuZbIax4UA2f70jnVTSxuWi6R2oj4Pt
         paHQ==
X-Received: by 10.112.56.233 with SMTP id d9mr4570174lbq.55.1403565468222;
 Mon, 23 Jun 2014 16:17:48 -0700 (PDT)
Received: by 10.112.172.74 with HTTP; Mon, 23 Jun 2014 16:17:28 -0700 (PDT)
In-Reply-To: <20140623231303.GD4445@google.com>
X-Google-Sender-Auth: 7nD6U7HzgIQusBHSGOhKxQtyF2w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252378>

On Mon, Jun 23, 2014 at 4:13 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>
>> * pb/trim-trailing-spaces (2014-06-13) 1 commit
>>   (merged to 'next' on 2014-06-20 at 6985153)
>>  + t0008: do not depend on 'echo' handling backslashes specially
>>
>>  Will merge to 'master'.
>
> Without this patch, 'master' doesn't pass t0008 for me with bash as
> /bin/sh.  The patch fixes it.  So fwiw I like the patch.

Yup, that is why I wrote it ;-)
