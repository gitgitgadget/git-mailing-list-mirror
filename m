From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] log: grep author/committer using mailmap
Date: Fri, 28 Dec 2012 21:37:42 +0100
Message-ID: <CALWbr2xm1CR-dCCV8WjfHVRCrqehRLT=PdpgK4pQG505d8pNmw@mail.gmail.com>
References: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
	<1356622318-19523-1-git-send-email-apelisse@gmail.com>
	<7v1uebmizx.fsf@alter.siamese.dyndns.org>
	<7vwqw3l49z.fsf@alter.siamese.dyndns.org>
	<CALWbr2y63L0-ykdUNGqUOb0LhG=vpXGRcb1KkvssEZmKFJEGeQ@mail.gmail.com>
	<7va9syj9v1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Togh9-0000FO-HB
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab2L1Uht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:37:49 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:34823 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab2L1Uhn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:37:43 -0500
Received: by mail-ea0-f169.google.com with SMTP id a12so4554810eaa.28
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6Fo8omO2yQmi/ly82nJkux/gmGZ2z4y5PaW+12f4GYk=;
        b=w0vC35OajdatqDv4/dm1YesLIaCEQjTgLg9iZCUMGeCPef1EjfhnOpLGS5c4XKdttB
         F/l3swKoWRmlDn9EkyxtHMMEwhQd9cnI9NsQCIhsWyoZa/Dfwpt/f+uDFe9cf9DNiRLZ
         tk/OEMWGRL3Y0Fn5w6USz9mrjVExtghQGcl9aRYwua0CQ9llLUyVy1Ycf9zh1dE4dnOV
         x/KQRbSYSU0/FtcG9aubGMnDKTr9mPvtQmj73su6lv7kW1iWwbfLY877CLziwmJKEBlE
         ZHFiwgEoyDwdMM4waNyq9/v9i5M9t3HAHkeLGhLhK+SbXicoAluATL5dGenZTRJ1AWNU
         9R5A==
Received: by 10.14.1.195 with SMTP id 43mr89043798eed.31.1356727062412; Fri,
 28 Dec 2012 12:37:42 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 28 Dec 2012 12:37:42 -0800 (PST)
In-Reply-To: <7va9syj9v1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212259>

> This is about your rewritten implementation that hasn't escaped to
> the general public but sitting in 'next', right?
>
> Two things that immediately come to mind are:
>
>  - initialization of lowermail can use strbuf_init() instead;
>  - downcasing can be done in place, i.e. "lowermail.buf[i] = ...".

Yep,
I don't think it's merged to 'next', I will squash those changes appropriately.
