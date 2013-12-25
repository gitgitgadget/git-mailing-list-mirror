From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: german translation bug
Date: Wed, 25 Dec 2013 18:12:59 -0500
Message-ID: <CAM9Z-nkmsLfzKY+2h8r4y9LjM+6OXTo65ZzLRG7-Z4G_cCdHyw@mail.gmail.com>
References: <1573480.3a5WD62Cc4@i5>
	<1513689.dimJgKglhA@i5>
	<CAM9Z-n=MF+MibS3ziHkixX+iTNAvB+D0+naKkzS8rb5ZSvgEzw@mail.gmail.com>
	<6038171.4XUs8Nu1vH@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Thu Dec 26 00:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvxdR-00081X-5x
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 00:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab3LYXNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 18:13:00 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:60904 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3LYXNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 18:13:00 -0500
X-Greylist: delayed 706 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2013 18:13:00 EST
Received: by mail-ig0-f173.google.com with SMTP id uq10so26336032igb.0
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 15:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5AyA/iFT8sGTmZak/bmSfQu0KncVScktifEUrySjOm8=;
        b=pGOaeGAwVNcXUNoCdkriy/2AIbFQLtPE0UrDOe5sgrwMM9D9YFziU7gZnksa5wOMMV
         MMwdGWiZk9Ak0MpPYB1+EEvAhf0g7ozF9YlZN25sOGCMcyQloPIwNyKJfXcTG/6TQWJ/
         hCIeTQK5Xoaqr3wN+1VD9aT5oTp/VJV447a7FmQUGkK6gBBjpCh5cqord2POK/VTG72f
         Ibe+uEJR+2b27LBv2XYYnpHmjIaiLKTWbMz7UnXMK+6+vV6Cyw+CbZ+zFqBXJ2fxAPm6
         2EGUKMlQx/GYTU4AjWMeWu/bpX5uHiHHSSlVwPHwQ8Pnvk4yb85mfA7IuisVBa6Byp3p
         +Ozg==
X-Received: by 10.50.56.38 with SMTP id x6mr31896285igp.31.1388013179602; Wed,
 25 Dec 2013 15:12:59 -0800 (PST)
Received: by 10.43.138.9 with HTTP; Wed, 25 Dec 2013 15:12:59 -0800 (PST)
In-Reply-To: <6038171.4XUs8Nu1vH@i5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239684>

On Wed, Dec 25, 2013 at 5:28 PM, Wolfgang Rohdewald
<wolfgang@rohdewald.de> wrote:
> Am Mittwoch, 25. Dezember 2013, 17:14:31 schrieb Drew Northup:
>> Git does not use KDE's language packs.
>
> Sorry, I meant ubuntu. I believe I heard before that they tend to replace
> upstream translations but I never actually experienced a problem with that.
>
>> What does dpkg report for info about the installed git package (if you
>> are using the packaged version)?
>
> Yes, I am using the packaged version. This package does not contain
> any translations.
>
> root@s5:/var/cache/apt/archives# dpkg --info git_1%3a1.8.3.2-1_amd64.deb
>  neues Debian-Paket, Version 2.0.

>  Package: git
>  Version: 1:1.8.3.2-1
>  Architecture: amd64

Wolfgang,
My suggestion is to consider compiling Git from sources, as Ubuntu has
stopped applying non-security updates (for the most part) to
13.10--which includes most Git updates. That's the best way to ensure
you get the latest translations checked out, QA'd and submitted by
Ralf.

(I'm probably going to do that with a 13.10 that I have at home when I
get a chance--most likely next week.)

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
