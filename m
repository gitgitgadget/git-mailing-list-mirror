From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing weak references to blobs and strong references to commits
Date: Tue, 31 Mar 2015 16:25:35 -0700
Message-ID: <CAPc5daWEitgc_69Cqp0daaMpFwEwoVAi62fgeDoyJKz8wBaBrg@mail.gmail.com>
References: <20150331100756.GA13377@glandium.org> <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
 <20150331223919.GA24362@glandium.org> <20150331231449.GF22844@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5Xl-00061g-FS
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbbCaXZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:25:57 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35226 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbCaXZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:25:56 -0400
Received: by obcjt1 with SMTP id jt1so52955880obc.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bEkpE7RWF7lm9OU1Yh6/ABFhVAQ+a6ZqzrdELTVkn9M=;
        b=DfREcoWgacbrC5KIxng4z4PYlqSbds1+1kuB2Gc2Ch672Fltk4tgm6q5rOdCzoX5zP
         kcCQaXZ+sDpEu10yknD2ZhQMlTgrD8NBOvqIxvC33JThVavw0vdhBBeE4bJlU2ygGnPx
         RyFqtwyGYO5rPofien2mb6z2mJPhn61WtnZR5vnMecTD9m+YK5HlWhDWsLOwJbzIWTPu
         P/yFVq+3R6yuEZOobuCOaCJtt/ryBMy4Svlf7NicNfn8EIrpj+c8D7HQP42QL92w3IUW
         X8LJj4ywl/eeywBPj1A3RfO3EcBzmdk+7j+mfyXglxUGjOzUezFOAF/9rDwCiNkFS4QH
         hQmQ==
X-Received: by 10.182.236.196 with SMTP id uw4mr7769458obc.41.1427844355976;
 Tue, 31 Mar 2015 16:25:55 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Tue, 31 Mar 2015 16:25:35 -0700 (PDT)
In-Reply-To: <20150331231449.GF22844@google.com>
X-Google-Sender-Auth: OcMLshegNUOvF7pg-JMqn99-_og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266581>

On Tue, Mar 31, 2015 at 4:14 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Mike Hommey wrote:
>
>> Octopus merges are limited to 16 parents.
>
> The note about this in fast-import is out of date (e.g., see
> t/t7602-merge-octopus-many.sh and v1.6.0-rc0~194, 2008-06-27).  How
> about this patch?

Ahh, I thought we eradicated all mentions of that ancient limit back then.

Thanks for catching.
