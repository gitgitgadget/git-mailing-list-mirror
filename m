From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Applicatioin of contribution for Git Chinese version
Date: Sat, 16 Apr 2011 17:33:10 -0500
Message-ID: <20110416223310.GA5149@elie>
References: <559debc.6920e.12f5f0bdfc0.Coremail.cyrus_evans@163.com>
 <BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Cyrus.Evans" <cyrus_evans@163.com>, git <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 00:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBE3c-0007Bk-4n
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 00:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759219Ab1DPWde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 18:33:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203Ab1DPWdX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 18:33:23 -0400
Received: by iyb14 with SMTP id 14so2976858iyb.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+ZCVJHEDfREo/9scYrx/uiV+dtxLxPNhsloFsNiyaIY=;
        b=g6PZqkev6ZU8CmLo+OYu9t0MzsD1mxYHN3u7I9O+bZta72ngIt3E6IHcNTr94+WCIx
         Q9jM95r7HEVpJj+oM5q1hyOWEpfZqmsKcvpJIk2uP7xkvwcGN0uepaXRderHAbVTji6/
         acp7C4pJWWulTiXeY8i/5szuMlxz36e4ntfhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C9Nq7czSLxwdyORfeaDUS2PHc71MoHgePwjnZcrHCM6SVRnudqY1WJ4lQQ9GGsAhnV
         8FcTyPb2PDgY9O73rNymVK99DPaf9Dc+3aAMlGR6m15MtwcLDqRknaNERmAKqfEDCd75
         KkMR6J5jq/GUO+7TySeN2bWVLm8q9o7z+tQdI=
Received: by 10.42.117.131 with SMTP id t3mr4223520icq.501.1302993202867;
        Sat, 16 Apr 2011 15:33:22 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.ameritech.net [69.209.51.5])
        by mx.google.com with ESMTPS id g16sm2198937ibb.37.2011.04.16.15.33.19
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 15:33:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171700>

Hi Cyrus,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It's great that you want to translate Git into chinese. Currently Git
> is in a state where we're preparing to accept translations, but
> there's no reason why you can't start now.
>
> What you can do to start now is:
>
>     git clone git://git.kernel.org/pub/scm/git/git.git
>     cd git
>     make pot
>     cd po
>     msginit --locale=3Dzh

=46rom talking on irc, it looks like you're on Windows and the bandwidt=
h
when talking to servers like git.kernel.org is not so great, and that
you want to be keeping the translation up to date day-to-day as git
is developed.  So here are some hints to start out.

As =C3=86var mentioned, we were just starting to get our act together t=
o
accept translations.  So you are a pioneer and we will be working out
some of this as we go (thank you!).

1. The first step, which you have already done, is to install msysgit
   (which includes a C compiler and some other useful tools).  With it
   you can easily test your changes.

   Start MsysGit, as described here:
   https://git.wiki.kernel.org/index.php/MSysGit:InstallMSysGit
   under "How to restart msysGit".

   If you installed using the fullinstaller, initialize it by running

	/share/msysGit/initialize.sh

2. Msysgit does not include a pre-compiled copy of gettext yet, but
   Erik Faye-Lund has done the necessary work.  Make use of it like
   so:

	cd /
	git checkout devel
	cd /src/gettext
	sh release.sh

   Now "gettext --help" should work.

3. Build a translation template:

	cd /git
	git checkout -t origin/master
	make pot
	cd po
	msginit --locale=3Dzh_CN

4. Start translating, at last.
  =20
> That'l generate a template zh.po that you can translate. You can
> translate the text with any PO editor, e.g. Poedit:
> http://www.poedit.net/

That's the end of chapter 1.  I am leaving how to test and publish
your translation and how to update when messages in git change for a
later mail.

> Please let me know if you have any questions, or if there's anything
> that can be improved in this process.

Yes.

Thanks, and hope that helps.
Jonathan
