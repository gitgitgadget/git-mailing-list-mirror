From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Sun, 8 May 2011 14:28:39 +1000
Message-ID: <BANLkTimdS7vs71vEVTxutvyp3rC4KxPjMA@mail.gmail.com>
References: <4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506141719.GA2991@elie>
	<BANLkTikW2u2W=Hpw2G4VJf_h88x4_7x_=Q@mail.gmail.com>
	<20110506145036.GB2991@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 06:28:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIvbq-0007qh-Dl
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 06:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795Ab1EHE2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 00:28:41 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46588 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1EHE2k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 00:28:40 -0400
Received: by vxi39 with SMTP id 39so4700040vxi.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h79deTnCypXTngMvfb+/F+Uc4Fcm4lkwNHDrp2fXJ8I=;
        b=sBUuxOCRfnsuwVLZb1oQt16xebNdgpaDey0XvYtyfDy8c73jnGpO3UPtB6+mGqsV3D
         BL25l6xfgZMfg9BcRbtNruUOP7FExcRjsgvWmpCFC310u3GvgUO8GD/zDLJa/7XKRK5g
         11rb4X8RNm4uPwPo0TU7yTXT4RLW2Ss1jGrnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ChzDlBixlLuUuiF64R9PUCL+UgG+uGVZLNsGryfp9DqKWTmZeyR1cAd5OT8Q9ygACl
         A6bY0A8J+4zKUupzXyOJJuF6YXy5EJ5AHhcttSF1GfBNrlBic1/fVxd9g5plx6DUSrEV
         uXyqB6/kLJLuV/z/qGeviyp1A4/ii0g0mFA6M=
Received: by 10.52.110.133 with SMTP id ia5mr6474108vdb.239.1304828919764;
 Sat, 07 May 2011 21:28:39 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sat, 7 May 2011 21:28:39 -0700 (PDT)
In-Reply-To: <20110506145036.GB2991@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173072>

On Sat, May 7, 2011 at 12:50 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jon Seymour wrote:
>
>> Partly because that is second guessing &/or reverse engineering the
>> distribution's decisions and
>
> Well, no --- that's what /usr/local is _for_:
> http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLOCALLOCALHIERARCHY
>

Sorry, what I really meant to say is that /usr/local/bin is not always
in a user's path *** . Whether it is or not depends in part on which
distribution manager you use on MAC OSX [ brew does user /usr/local,
but MAC Ports uses /opt/local ].

*** I may be wrong about this - /usr/local/bin is actually in my MAC's
path, but I think I had to edit /etc/profile to get it there.

That said, once git is installed, there is usually a directory like
/usr/local or /opt/local that could be used as the default prefix to
target the installation of a plugin.

Perhaps there is a case for a git --prefix to provide that hint?

>> it won't work for a Windows install where there is no /usr/local
>
> That's true. =C2=A0I believe command-line users on Windows who instal=
l by
> unzipping to a directory are used to having to set a PATH for
> themselves. =C2=A0Perhaps it would be convenient for git to learn to =
add a
> specific standard directory to its private PATH as a Windows-specific
> extension, though.
>
> If your goal is to make installing new commands for git easier than
> installing native apps --- why? =C2=A0It seems backwards. =C2=A0Consi=
der that
> the end result ought to be easy not only for the app developer but fo=
r
> the end user, and if every program with the ability to call other
> programs sets up its own better replacement for standard operating
> system facilities, that will make for a complicated system to
> administer indeed. =C2=A0So with that in mind, it might be simpler to=
 take
> advantage of existing project that simplifies installation of native
> apps, like <http://zero-install.sourceforge.net/>.
>

I will have a look at zero-install, though quick inspection seems to
indicate that it is best for running standalone apps and not
necessarily great for the task at hand here.

The idea isn't to replace standard operating system facilities for
application installation. The idea is to provide a uniform interface
for accomplishing the rather limited task of extending git that can
work the same way, irrespective of platform, irrespective of file
system layouts, irrespective of assumptions about which directories
are already in the user's paths.

One answer is for each extension author to invent their own way to
produce packages that can be installed in a cross-platform way across
multiple platforms but this seems like an unnecessary duplication of
effort compared to a possible alternative.

If at the end of the day, we say make and install are the way to do
it, then fine. However, this makes the dependencies for a successful
install strictly greater than the existence of git and a POSIX shell
which we can assume if git is already installed.

jon.
