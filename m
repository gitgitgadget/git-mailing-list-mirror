X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 18:06:27 -0500
Message-ID: <20061203230627.GF15965@spearce.org>
References: <20061203045953.GE26668@spearce.org> <200612031455.48032.robin.rosenberg.lists@dewire.com> <ekumdo$imo$1@sea.gmane.org> <200612031653.04019.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 23:06:36 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612031653.04019.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33151>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr0Pq-0000ZB-Bb for gcvg-git@gmane.org; Mon, 04 Dec
 2006 00:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758570AbWLCXGb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758792AbWLCXGb
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 18:06:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46027 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758570AbWLCXGb
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006
 18:06:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gr0PO-0005Ou-Ha; Sun, 03 Dec 2006 18:06:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8FAD420FB7F; Sun,  3 Dec 2006 18:06:27 -0500 (EST)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndag 03 december 2006 15:19 skrev Jakub Narebski:
> > Robin Rosenberg wrote:
> > > CVS-induced brain damage, I should track the content. next versio=
n.
> > > filenames are so much handier to work with).
> >
> > Git uses <path> as _revision limiter_, not as output filter. Should=
n't
> > jgit do the same?
> It's egit, i.e. the eclipse plugin I'm referring to so it's a user in=
terface=20
> thing and it uses the path name. =20

Jakub's point is that "git log -- a" lists only the revisions
which affect path 'a'.  Once those revisions have been selected
then output begins.  The 'a' gets reapplied as an output filter to
only show changes relevant to file 'a', but its very much a revision
filter during the revision listing process.

--=20
