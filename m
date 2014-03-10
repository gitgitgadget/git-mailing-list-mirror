From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 05/26] t1400: Add some more tests involving quoted arguments
Date: Mon, 10 Mar 2014 14:53:39 +0100
Message-ID: <CALKQrgd+Jp4WK6EV1m8RJ5atT6J27yhg=nepxneNN0QEJmjPRQ@mail.gmail.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
	<1394455603-2968-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 14:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN0eQ-00038f-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 14:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbaCJNxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 09:53:49 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:43334 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaCJNxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 09:53:48 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WN0eI-0005Bf-FW
	for git@vger.kernel.org; Mon, 10 Mar 2014 14:53:46 +0100
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WN0eI-0009NS-81
	for git@vger.kernel.org; Mon, 10 Mar 2014 14:53:46 +0100
Received: by mail-pd0-f180.google.com with SMTP id v10so7094840pde.39
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=F8sO5gR7JRRqv86p7sjZP3U+kYAoEvuhHaujxxQ8/Rc=;
        b=kXFFtwZNtimu/36joT1oI1Nc6ZAmfBzDzGHtFrPutOOQ0+mzHsMpgO9/zla+gCvZ6D
         1xsE3JCjmq3wBZC/eGqabFaU3wka7Chb08SE0TyAGwVqfmKZvPZmOeP2Z190ggzOjTvp
         p9Ua4aQec9XVKy+ltmUWQf/Dfcu3RB17ttW+l/WoTDBz9t/VdrmFTEAyN4RCV5EPP07a
         StXzNuGBOz61G4XbiKUK0es7ACVlMq9Ev2V8AVF4cykR0cWPUoWRusT1xC4VyOBf/Ift
         TG8U3yqMsE2dgTdC0ZvdvSr55PLVxgYHocb/WKHmlBSoJsV6EWTKKu0iT3E+FO4Y1u9F
         CNwg==
X-Received: by 10.68.129.5 with SMTP id ns5mr7853508pbb.147.1394459619636;
 Mon, 10 Mar 2014 06:53:39 -0700 (PDT)
Received: by 10.70.48.228 with HTTP; Mon, 10 Mar 2014 06:53:39 -0700 (PDT)
In-Reply-To: <1394455603-2968-6-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243760>

On Mon, Mar 10, 2014 at 1:46 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Previously there were no good tests of C-quoted arguments.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

FWIW, the first 5 patches seem trivially correct to me. Feel free to add:

Reviewed-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
