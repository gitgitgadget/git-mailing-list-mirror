From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: call external editor from git-gui?
Date: Wed, 15 Aug 2007 20:31:49 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070815183149.GD1644@informatik.uni-freiburg.de>
References: <20070810153008.GA31759@diana.vm.bytemark.co.uk> <20070814045511.GF27913@spearce.org> <20070814070000.GA12052@diana.vm.bytemark.co.uk> <20070815182228.GA3419@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:32:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILNfC-0003Tk-CQ
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 20:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbXHOScK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Aug 2007 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbXHOScJ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 14:32:09 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33783 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753225AbXHOScH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 14:32:07 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1ILNf3-00074b-Q3; Wed, 15 Aug 2007 20:32:05 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7FIW3jT002193;
	Wed, 15 Aug 2007 20:32:03 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7FIVnIc002192;
	Wed, 15 Aug 2007 20:31:49 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Jan Hudec <bulb@ucw.cz>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070815182228.GA3419@efreet.light.src>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55934>

Hello,

Jan Hudec wrote:
> On Tue, Aug 14, 2007 at 09:00:00 +0200, Karl Hasselstr=F6m wrote:
> > On 2007-08-14 00:55:11 -0400, Shawn O. Pearce wrote:
> > > Spawning the user's preferred editor would be a nice way to get s=
ome
> > > of that.
> >=20
> > Mmm. I wouldn't call it a _nice_ way: popping up an external progra=
m
> > just to get the right text editing behavior. More like the _only_ w=
ay,
> > if the user is picky enough.
>=20
> It might actually have a rather serious twist. Often the editor for
> git-commit would use the terminal git-commit runs on. But for git-gui=
 you may
> not have any terminal (running git-gui from context menu of some file
> manager) and even if you do, the user does not expect it to be used. =
So the
> user may -- and quite often will -- want different editors for runnin=
g from
> git-gui and git-commit.

Alternatively you need to find out/let the user specify if her editor
needs a terminal and then use

	xterm -e myfavoriteeditor

or simply

	myfavoriteeditor

depending on the result.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

$ dc -e "5735816763073014741799356604682P"
