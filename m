From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Thu, 17 Jul 2008 23:31:17 +0200
Message-ID: <200807172331.18059.robin.rosenberg.lists@dewire.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <20080712030104.GB15838@spearce.org> <20080712034206.GA16101@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:37:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJbAN-000122-Ph
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 23:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760598AbYGQVgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 17:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760668AbYGQVgg
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 17:36:36 -0400
Received: from av11-2-sn2.hy.skanova.net ([81.228.8.184]:35244 "EHLO
	av11-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034AbYGQVgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 17:36:35 -0400
Received: by av11-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 66C6B37F2A; Thu, 17 Jul 2008 23:36:33 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av11-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 6F6E737EFE; Thu, 17 Jul 2008 23:36:31 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 177B237E47;
	Thu, 17 Jul 2008 23:36:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080712034206.GA16101@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88924>

l=C3=B6rdagen den 12 juli 2008 05.42.06 skrev Shawn O. Pearce:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Mike Ralphson <mike.ralphson@gmail.com> wrote:
> >=20
> > > > I think we are at the point where we need to either write a
> > > > #@!*(!@(! command line option parser, import one, or stop writi=
ng
> > > > command line programs.  I would certainly appreciate any opinio=
n
> > > > you might have on the matter.
> > >=20
> > > a) is a distraction, c) is a backwards step, so maybe b) wins.
> >=20
> > So I looked at GNU getopt and its at least smaller than Apache
> > Commons,
>=20
> Probably the state-of-the-arg is args4j:
>=20
>   https://args4j.dev.java.net/
>=20
> It uses Java 5 annotations to setup the argument parsing:

But it doesn't use GNU getOpt's long/short style parsing which is a BIG=
 loss. Maybe
we could contribute it? Or at least not design options incompatible wit=
h such an option
parser.

-- robin
