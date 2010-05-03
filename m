From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 2/2] git-svn: Don't allow missing commit parent to
	stop git-svn
Date: Mon, 3 May 2010 14:19:42 -0700
Message-ID: <20100503211942.GA1380@dcvr.yhbt.net>
References: <j2wc8b3bef91004201430ie371be83kee0e3e4c35ab9c9e@mail.gmail.com> <1271880470.20208.47.camel@denix> <m2sc8b3bef91004211417n1f3368a7ica94a1c2a7656622@mail.gmail.com> <4BCF8E07.9080507@vilain.net> <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Mon May 03 23:19:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O933N-0004ig-1B
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 23:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab0ECVTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 17:19:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51448 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221Ab0ECVTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 17:19:43 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0461F744;
	Mon,  3 May 2010 21:19:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <r2jc8b3bef91004280851i865a911ei47b1be606dd560d9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146260>

Michael Olson <mwolson@gnu.org> wrote:
> On Wed, Apr 21, 2010 at 4:45 PM, Sam Vilain <sam@vilain.net> wrote:
> > Michael Olson wrote:
> >> Interestingly, I see people reporting the same problem in the thre=
ad
> >> "git svn clone of subversion's own code failing". =A0So it's not j=
ust
> >> related to patch 1/2 of this series. =A0At least that thread has a
> >> public-facing repo so the problem should be easier to reproduce fo=
r
> >> a real fix.
> >
> > Oh, right ... I remember that issue now. I'm currently testing the
> > below change to see if it breaks the test suite; any issues and I'l=
l
> > post an update.
> >
> > Subject: [PATCH] git-svn: deal with svn cherry-picks with non-linea=
r history
>=20
> This change works great on my private repos, so it should supersede m=
y
> version which only did an eval.

Have either of you had a chance to look into the test suite breakage
from this patch?  Thanks.

--=20
Eric Wong
