From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: german translation bug
Date: Thu, 26 Dec 2013 17:52:02 +0100
Message-ID: <CAN0XMOLAGQbxLXR16+37WFeCUWnNze8CwoV4+-9-FU0Mz5LZkw@mail.gmail.com>
References: <1573480.3a5WD62Cc4@i5>
	<CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
	<1513689.dimJgKglhA@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Thu Dec 26 17:56:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwEAO-0007qy-MX
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab3LZQwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:52:07 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:53100 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab3LZQwG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Dec 2013 11:52:06 -0500
Received: by mail-wi0-f180.google.com with SMTP id hm19so8824432wib.13
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1Zeb58D8tRIBJGON7+RxtNjU7Yzc/IsU7pzt1nypAQk=;
        b=wMnyIT1AzUvsTpYPHeS+tmk29wZJfvHEz4KFh2MraojajMXYF3RCsJPYmz3FFlpHJk
         nzwH4DysIQ0DMehVi2nMVEpWJSeoEvZOKN+FWZYeg88rMOZjZCxIBS/lvMWG6v2kz6U7
         QQjBgv1CZ9SRnI2lJsFnhR/n0GWs1STtcUn1I8e/i52Lb3wNhaTa0VFvARZhASLeBjU4
         pkqyoNniXbF+JEwU21S9kHUoiOVGnQajGLyA4vwsGstTltnEXyLkJsie5jvL9n9PIEtj
         F8j4ogdGPdDwG/xw6PBJYQM3zA1FkWwpkhbjzE0feuDitwFL3uTgMbulEe4NQ8YBp48V
         BMwA==
X-Received: by 10.194.90.144 with SMTP id bw16mr30159019wjb.1.1388076722568;
 Thu, 26 Dec 2013 08:52:02 -0800 (PST)
Received: by 10.194.165.163 with HTTP; Thu, 26 Dec 2013 08:52:02 -0800 (PST)
In-Reply-To: <1513689.dimJgKglhA@i5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239701>

On Wed, Dec 25, 2013 at 10:53 PM, Wolfgang Rohdewald
<wolfgang@rohdewald.de> wrote:
> Am Mittwoch, 25. Dezember 2013, 21:59:10 schrieb Ralf Thielow:
>> What version of Git do you use? What distro in what version do you use?
>
> freshly installed kubuntu 13.10. The package language-pack-de mentioned
> at the end of this mail is installed.
>
> I suppose I should open a KDE bug report?
>

The Ubuntu translators have already updated the
German Git translation for 13.10. So the issue should be
fixed in the next language pack update [1].

AFAIK Ubuntu ships the translations aside software packages
that they're able to update l10n without updating the software
itself.
They also maintain the translations for themselves. Issues that's
been reported to them also getting fixed by them. However, those
fixes do not necessarily find their way to upstream Git translations.
The benefit of reporting issues to Git ML is that they can be fixed
in both upstream Git and Ubuntu. I'll try to keep an eye to launchpad
and fix bugs in German translation reported on the ML on both places
in the future.

Thanks for reporting the issue.

[1]
https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/git/de/+translate?batch=10&show=all&search=nothing+to+commit%2C+working+directory+clean

> i5:~ ((unknown)) git --version
> git version 1.8.3.2
>
> wr@s5:~/kajongg/src$ grep -a 'Nichts zum Einreichen' /usr/share/locale-langpack/de/LC_MESSAGES/git.mo
> Nichts zum Einreichen
> Nichts zum Einreichen, Arbeitsverzeichnis leer
>
> root@s5:~/kajongg/src# apt-file search /de/ | grep /git.mo
> language-pack-de-base: /usr/share/locale-langpack/de/LC_MESSAGES/git.mo
>
> root@s5:~/kajongg/src# LANG=C dpkg --info /var/cache/apt/archives/language-pack-de-base_1%3a13.10+20131012_all.deb
>  new debian package, version 2.0.
>  size 3346634 bytes: control archive=7323 bytes.
>      955 bytes,    19 lines      control
>    20278 bytes,   231 lines      md5sums
>      125 bytes,     9 lines   *  postinst             #!/bin/sh
>      121 bytes,     9 lines   *  postrm               #!/bin/sh
>  Package: language-pack-de-base
>  Version: 1:13.10+20131012
>  Architecture: all
>  Maintainer: Language pack maintainers <language-packs@ubuntu.com>
>  Installed-Size: 11247
>  Pre-Depends: dpkg (>= 1.10.27ubuntu1)
>  Depends: locales (>= 2.3.6), language-pack-de (>= 1:13.10+20131012)
>  Recommends: firefox-locale-de
>  Conflicts: language-pack-de (<< 1:13.10+20131012)
>  Replaces: language-pack-de (<< 1:13.10+20131012), language-pack-de-base (<< 1:13.10+20131012), language-pack-gnome-de (<< 1:13.10+20131012), language-pack-gnome-de-base (<< 1:13.10+20131012), language-pack-kde-de (<< 1:13.10+20131012), language-pack-kde-de-base (<< 1:13.10+20131012)
>  Section: translations
>  Priority: optional
>  Description: translations for language German
>   Translation data for all supported packages for:
>   German
>   .
>   This package provides the bulk of translation data and is updated
>   only seldom. language-pack-de provides frequent
>   translation updates, so you should install this as well.
>
> --
> Wolfgang
