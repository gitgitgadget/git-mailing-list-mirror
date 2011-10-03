From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 20:12:44 +1100
Message-ID: <CACsJy8C7RXec_Zq8SAdyW2mYh44GBQsJ7sdwR8nHBcwVieV5mg@mail.gmail.com>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111001022544.GA31036@LK-Perkele-VI.localdomain> <20111001052910.GA6502@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAeaO-0004VF-8l
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248Ab1JCJNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 05:13:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33763 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab1JCJNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 05:13:15 -0400
Received: by bkbzt4 with SMTP id zt4so5053953bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GkEhOhkin29gvswYq9VjHxHMVimV4K3Xu7IWASs/PDk=;
        b=iu4NYQ8Fi+YP7R/3BJbII1dJDfX/eUS0nzXWm2TymGYfsZBG9HPtEjhseNdVgb7/yd
         dEKyyzc0pa9U/QZ3qALU8F4PzrhfTJIKA/NvuY4Vm6C4uXzEUSqhmk+Cio7WOKebJQaa
         WNbqnLTZkr1kbCHpo21Wpqh6kkhowJPhjtNNI=
Received: by 10.204.133.92 with SMTP id e28mr9038908bkt.407.1317633194157;
 Mon, 03 Oct 2011 02:13:14 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Mon, 3 Oct 2011 02:12:44 -0700 (PDT)
In-Reply-To: <20111001052910.GA6502@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182641>

2011/10/1 Jonathan Nieder <jrnieder@gmail.com>:
> Ilari Liusvaara wrote:
>
>> What about sticking code to return an error to git daemon instead of this?
>
> The code has even been written:
> http://thread.gmane.org/gmane.comp.version-control.git/145456/focus=145573
>
> Testing and other improvements would be very welcome.

Tests aside, are there any problems with the patch? I don't see any
followup discussions. Personally I don't see much value in adding the
description though.
-- 
Duy
