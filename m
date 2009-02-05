From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu, 5 Feb 2009 23:09:10 +0100
Message-ID: <200902052309.10333.robin.rosenberg.lists@dewire.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <200902051932.24600.robin.rosenberg.lists@dewire.com> <498B31EC.2020006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 23:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVCQj-00042w-E8
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 23:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbZBEWJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 17:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbZBEWJO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 17:09:14 -0500
Received: from mail.dewire.com ([83.140.172.130]:3277 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbZBEWJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 17:09:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AD7EC147E88B;
	Thu,  5 Feb 2009 23:09:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4PvJ-YU1zgTH; Thu,  5 Feb 2009 23:09:11 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 23822147E888;
	Thu,  5 Feb 2009 23:09:11 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <498B31EC.2020006@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108629>

torsdag 05 februari 2009 19:37:32 skrev Tor Arne Vestb=F8:
> Robin Rosenberg wrote:
> > It's our choice here. Generally, I think we should shift behavior h=
ere
> > depending on layout. Java packages are not hierarchical in nature.
> >=20
> > Currently it may look like this with flat package layout:
> >=20
> > 	>org.spearce.jgit.treewalk
> > 		CanonicalTreeParserTest.java
> > 		EmptyTreeIteratorTest.java
> > 		FileTreeIteratorTest.java
> > 		NameConflictTreeWalkTest.java
> > 		PostOrderTreeWalkTest.java
> > 		TreeWalkBasicDiffTest.java
> >=20
> > 	>org.spearce.jgit.treewalk.filter
> > 		AlwaysCloneTreeFilter.java
> > 		>NotTreeFilterTest.java
> > 		TreeFilterTest.java
> >=20
> >=20
> > Which is odd when looking at org.spearce.jgit.treewalk, because
> > no files in that package have been changed.
>=20
> Agreed. But, as the CVS plugin seems to handle this gracefully, witho=
ut
> any JDT specific code (from my brief investigations), it seems that t=
his
> is something we can get for free from the team plugins. I will look i=
nto
> it as soon as this series is done cooking.

My guess is it has to do with traversal according to the structure layo=
ut, so
JDT only does the layout and the CVS decorator follows that one.

-- robin
