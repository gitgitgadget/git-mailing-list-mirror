From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] learn to pick/revert into unborn branch
Date: Sun, 23 Dec 2012 08:01:52 +0100
Message-ID: <CAP8UFD0GsqPSk-WstydjZHXc5WSmDJimfRcx4Mn7Uyw0s3LdpA@mail.gmail.com>
References: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
	<1356117013-20613-2-git-send-email-martinvonz@gmail.com>
	<7vr4mhpi0l.fsf@alter.siamese.dyndns.org>
	<CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 08:07:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tmff1-0003c3-H8
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 08:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab2LWHBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 02:01:55 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:58975 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab2LWHBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 02:01:54 -0500
Received: by mail-bk0-f54.google.com with SMTP id je9so3006500bkc.27
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 23:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0WbTZyFj+VR/gxlSmb5v0WH2R6a3RamWWhs0KZbNWeQ=;
        b=eqFyA1xFUxHUjXHeILDbYGvktPQ/ItWwzJwzk4MHW9IbVXKnx+845rmU2b8W0XsRva
         dm8Z7ziBWsIh2c38F2jJKWXjXQEC5A3giIEjfpd3rwvDQaiG/WUUhGYjr+HJ6LBu5gyr
         K4W8HkTZX3N1uffpSRMTtBOy7TL+heYDJlVOjHOHP6pEQR4g3rl95o1WSu3jSVb9xWd/
         QAAsbt1Hgm1BJpbQVT4ikJRyBQr9VZeVVZvfaZIlDyfkX9BnpPvLcu46jwWkBpdkH4PW
         9mH/Rcee+6pkYgbHOUO5DUeJAWIwUmom7LW+2RO/C/fZhXr6S01ftNrcpG1I9xi94xBO
         Mzrw==
Received: by 10.204.149.11 with SMTP id r11mr8622088bkv.93.1356246112657; Sat,
 22 Dec 2012 23:01:52 -0800 (PST)
Received: by 10.204.129.70 with HTTP; Sat, 22 Dec 2012 23:01:52 -0800 (PST)
In-Reply-To: <CANiSa6i0-Z=FkPnSJxgT+3ABHTzgOTNNNUb=wHQpm2DKAN_UOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212082>

On Sun, Dec 23, 2012 at 7:24 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
> As for use cases, I didn't consider that much more than that it might
> be useful for implementing "git rebase --root". I haven't implemented
> that yet, so I can't say for sure that it will work out.
>
> One use case might be to rewrite history by creating an new unborn
> branch and picking the initial commit and a subset of other commits.
> Anyway, I didn't implement it because I thought it would be very
> useful, but mostly because I just thought it should work (for
> completeness).

I agree that it would be nice if it worked.

Thanks,
Christian.
