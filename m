From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: german translation bug
Date: Wed, 25 Dec 2013 17:14:31 -0500
Message-ID: <CAM9Z-n=MF+MibS3ziHkixX+iTNAvB+D0+naKkzS8rb5ZSvgEzw@mail.gmail.com>
References: <1573480.3a5WD62Cc4@i5>
	<CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
	<1513689.dimJgKglhA@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Wed Dec 25 23:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vvwir-0006Je-AX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab3LYWOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 17:14:33 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38873 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3LYWOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 17:14:32 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so8141155iec.33
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gKln2HzTVeGc+pmAybNxY5GmiJZF7ju9iAlr7PQ194A=;
        b=RuPYMPyqxkKLB4csF62MSNnJhyiFdxUV5Ul9triscJEG9ZtowVeTs70bEFgLal+dR8
         qmZp4BiGOI4sy+DYxsZpIomoCxEpd/MVnjAKCPHLmdxvm57tJBUwbk4rJ8ZCjgsBuKlm
         6uTREBVSqyY6ncfehaZyjcyLe2v0CLMxMkMNXBJnK5Io+45Boetcig5Ody/tULZ6qc64
         U5bgjylVic3cfF1jTxAw2DSwdAjROMZzEvpnQ9Iax0tbjFb5NUmD/uZzF2sfqzXJfNRG
         nzOhPpQVn2SgfNUewUp7Am6eYd0k0aMONx7Nf4aal2G5twaAWUzyMy80UxtOyKdHBJc8
         RgRA==
X-Received: by 10.43.61.196 with SMTP id wx4mr1583544icb.6.1388009671727; Wed,
 25 Dec 2013 14:14:31 -0800 (PST)
Received: by 10.43.138.9 with HTTP; Wed, 25 Dec 2013 14:14:31 -0800 (PST)
In-Reply-To: <1513689.dimJgKglhA@i5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239681>

On Wed, Dec 25, 2013 at 4:53 PM, Wolfgang Rohdewald
<wolfgang@rohdewald.de> wrote:
> Am Mittwoch, 25. Dezember 2013, 21:59:10 schrieb Ralf Thielow:
>> What version of Git do you use? What distro in what version do you use?
>
> freshly installed kubuntu 13.10. The package language-pack-de mentioned
> at the end of this mail is installed.
>
> I suppose I should open a KDE bug report?

Git does not use KDE's language packs.

> i5:~ ((unknown)) git --version
> git version 1.8.3.2

> root@s5:~/kajongg/src# LANG=C dpkg --info /var/cache/apt/archives/language-pack-de-base_1%3a13.10+20131012_all.deb

What does dpkg report for info about the installed git package (if you
are using the packaged version)?

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
