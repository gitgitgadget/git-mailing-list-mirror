From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git and cyrillic branches
Date: Thu, 25 Jul 2013 20:07:51 +0400
Message-ID: <20130725200751.fbce144058b72752a079b545@domain007.com>
References: <922031374754788@web29h.yandex.ru>
	<20130725164522.f8841abf18742cc5f6e0fdbe@domain007.com>
	<992731374757601@web29h.yandex.ru>
	<20130725182851.c17d3ed662434d1d91838949@domain007.com>
	<322491374763917@web5g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	=?KOI8-R?Q?=CB=D3=CF=D7?= =?KOI8-R?Q?=C9=D2=C1=CE?= 
	<xowirun@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 25 18:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2OBR-0001Tl-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 18:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513Ab3GYQOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 12:14:24 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:48892 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab3GYQOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 12:14:21 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2013 12:14:21 EDT
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6PG7qiX022499;
	Thu, 25 Jul 2013 20:07:53 +0400
In-Reply-To: <322491374763917@web5g.yandex.ru>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231142>

On Thu, 25 Jul 2013 18:51:57 +0400
=CB=D3=CF=D7=C9=D2=C1=CE <xowirun@yandex.ru> wrote:

[...]
> > I'm afraid, this might be not that simple: Git received certain
> > tweaks to work around certain problems Mac OS X has (as I
> > understand it) with handling UTF-8 on various filesystems it
> > supports; in particular, see commits
> > 76759c7dff53e8c84e975b88cb8245587c14c7ba [1] and
> > b856ad623e4f686815986c0b9341dd1bfd791e71 [2] which were released as
> > part of v1.7.12.
[...]

And while we're at it, commit message of 76759c7 tells that in order
for the fixes to work, the core.precomposedunicode configuration
variable has to be set to 'true'.  Did you do that?  Did that help?
