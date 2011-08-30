From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 21:08:18 +0200
Message-ID: <20110830190818.GB19715@rdrz.de>
References: <1314726104-sup-5174@pinkfloyd.chass.utoronto.ca>
 <4e5d2ac6.64676448.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Tue Aug 30 21:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyTff-0007MA-Kb
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab1H3TIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 15:08:23 -0400
Received: from rdrz.de ([217.160.107.209]:59295 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756125Ab1H3TIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 15:08:22 -0400
Received: (qmail 4308 invoked by uid 1009); 30 Aug 2011 19:08:19 -0000
Content-Disposition: inline
In-Reply-To: <4e5d2ac6.64676448.bm000@wupperonline.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180434>

On Tue, Aug 30, 2011 at 08:24:04PM +0200, Ingo Br=FCckl wrote:
> Ben Walton wrote on Tue, 30 Aug 2011 13:43:46 -0400:
>=20
> > Excerpts from Ingo Br=FCckl's message of Tue Aug 30 13:21:18 -0400 =
2011:
>=20
> >> The output of "stash list" is such that piping into a pager
> >> normally isn't necessary but annoying, so disable it by default.
>=20
> > If you $PAGER is less and you use the default LESS environment valu=
e
> > FRXS, this shouldn't be annoying at all.  Are you using either a
> > different pager or a different value for LESS?
>=20
> For some reason I have '-c' in LESS which must be convenient for a ca=
se
> I currently don't remember.

When you don't require the '-c' option for paging in git, please try
'core.pager =3D less -FRXS'. That forces git's default behaviour
regardless of the LESS environment variable.

Raphael
