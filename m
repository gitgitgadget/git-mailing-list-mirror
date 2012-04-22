From: Robert Quattlebaum <darco@deepdarc.com>
Subject: Re: git-archive and submodules
Date: Sun, 22 Apr 2012 14:47:29 -0400
Message-ID: <49D85565-3932-4B03-9568-E5CB75F39B9E@deepdarc.com>
References: <CALKBF2gwVr0rPn0y8=cvwqOsUb7eQPH7EdK5U+gfZMzh=RpiKw@mail.gmail.com> <4F911A2C.4070306@web.de> <CALKBF2jzL5-mHaVi1erA=EiF_DALF1Rvwv7yB5CfdEdQa2ZhBg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?Q?Andr=C3=A9_Caron?= <andre.l.caron@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 22:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM2zV-0005gX-GI
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 22:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2DVUCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Apr 2012 16:02:31 -0400
Received: from spider.nocdirect.com ([69.73.181.158]:37822 "EHLO
	spider.nocdirect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2DVUCa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2012 16:02:30 -0400
X-Greylist: delayed 4499 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Apr 2012 16:02:30 EDT
Received: from mobile-166-147-109-141.mycingular.net ([166.147.109.141]:53503 helo=[10.15.63.128])
	by spider.nocdirect.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.77)
	(envelope-from <darco@deepdarc.com>)
	id 1SM1oo-00014k-47; Sun, 22 Apr 2012 14:47:30 -0400
In-Reply-To: <CALKBF2jzL5-mHaVi1erA=EiF_DALF1Rvwv7yB5CfdEdQa2ZhBg@mail.gmail.com>
X-Mailer: iPad Mail (9B176)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - spider.nocdirect.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - deepdarc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196089>

I got too busy to continue working to get it included. Please feel free=
 to pick up where I left off.=20

Sent from my iPad

On Apr 20, 2012, at 2:32 PM, Andr=C3=A9 Caron <andre.l.caron@gmail.com>=
 wrote:

> Hi Robert,
>=20
> I've recently raised the same submodule issue with git-archive you an=
d
> Lars have in the past.
>=20
> What's the status on your application of the git-archive submodule
> patch?  Have you applied the changes suggested by Lens Lehmann[1]?
> Your Git fork on GitHub[2] seems to have only applied Lars' patch and
> an unrelated SVN glob fix...
>=20
> Since you've touched this only last year, I'd like to know where you
> were at and I can see if I can pick up where you left off (unless you
> want to finish yourself).
>=20
> Thanks,
> Andr=C3=A9
>=20
> [1]: http://comments.gmane.org/gmane.comp.version-control.git/172851
> [2]: https://github.com/darconeous/git
>=20
>=20
> ---------- Forwarded message ----------
> From: Jens Lehmann <Jens.Lehmann@web.de>
> Date: Fri, Apr 20, 2012 at 4:11 AM
> Subject: Re: git-archive and submodules
> To: Andr=C3=A9 Caron <andre.l.caron@gmail.com>
> Cc: git@vger.kernel.org
>=20
>=20
> Am 19.04.2012 22:10, schrieb Andr=C3=A9 Caron:
>> Hi,
>>=20
>> I've recently needed to create a source code archive as part of a
>> custom build target.  This repository uses submodules and I need to
>> include the submodlule's source code in the archives too.  However,
>> git-archive does not have any option to do so.
>>=20
>> I've taken a quick look at the GMANE mailing list archives and it
>> seems this provoked quite a discussion in 2009 and that Lars Hjemli
>> even wrote a patch (in several flavors) for archive.c to include
>> submodule-aware processing.  The lastest source code at
>> `git.kernel.org` does not contain any traces of this patch (or
>> submodule aware logic for that matter).  The mailing list archives a=
re
>> not very convenient to browse and I can't figure out what the status
>> on this submodule-aware git-archive idea is.  Has this idea been
>> completely rejected, or is it still work in progress?
>=20
> The idea is not rejected, this would be a worthwhile addition. It has
> been brought up again last May, but as far as I know it is stalled
> since then:
> http://comments.gmane.org/gmane.comp.version-control.git/172851
>=20
