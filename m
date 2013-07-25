From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git and cyrillic branches
Date: Thu, 25 Jul 2013 19:34:23 +0400
Message-ID: <20130725193423.585a5b54faeb90fb4249db45@domain007.com>
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
X-From: git-owner@vger.kernel.org Thu Jul 25 17:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2NYl-00023m-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 17:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab3GYPe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 11:34:28 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:48604 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3GYPe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 11:34:27 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6PFYOtb021200;
	Thu, 25 Jul 2013 19:34:25 +0400
In-Reply-To: <322491374763917@web5g.yandex.ru>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231140>

On Thu, 25 Jul 2013 18:51:57 +0400
=CB=D3=CF=D7=C9=D2=C1=CE <xowirun@yandex.ru> wrote:

[...]
> > I'm afraid, this might be not that simple: Git received certain
> > tweaks to work around certain problems Mac OS X has (as I
> > understand it) with handling UTF-8 on various filesystems it
> > supports; in particular, see commits
[...]
> > So... I'm not sure, but I beleive these fixes might have been
> > related to handling filenames in the work tree and the index only,
> > not branches, as having branches with non-ASCII names is a weird
> > idea to most developers, I think.
[...]
> there is nothing wrong with having branches with non-ASCII names as
> english is not the only language in the world.

Well, this my remark was just to explain why the problem with branches
which *are* files (well, unless they have become "packed refs") in the
reference Git implementation, might had good chances to escape the
scope of the tweaks being discussed.  Of course, there's nothing wrong
with non-ASCII branch names unless this impedes collaboration on a
project which uses them.

> problem is still here, i've got ubuntu on VM and same shared
> git-folder causes this problem on Mac Os and no problems on Ubuntu.
> git version on Mac is 1.8.0.1 (on Ubuntu is 1.7.10.4)

I hope someone possessing the necessary knowledge will look at it.
