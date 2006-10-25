X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-merge-subordinate
Date: Wed, 25 Oct 2006 12:27:58 -0400
Message-ID: <20061025162758.GC9312@spearce.org>
References: <20061025155009.GD5591@parisc-linux.org> <eho29l$1td$1@sea.gmane.org> <Pine.LNX.4.63.0610251819080.3286@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 16:28:45 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610251819080.3286@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30074>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gclc7-0008UI-1M for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423103AbWJYQ2F convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423122AbWJYQ2E
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:28:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41660 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1423103AbWJYQ2B
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006
 12:28:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gclbd-0000bh-BV; Wed, 25 Oct 2006 12:27:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 41AB321269E; Wed, 25 Oct 2006 12:27:58 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>=20
> On Wed, 25 Oct 2006, Jakub Narebski wrote:
>=20
> > Matthew Wilcox wrote:
> >=20
> > > Linus doesn't like seeing unnecessary merges in his tree. =A0I'm =
not a huge
> > > fan of them either. =A0Wouldn't it be nice if we had a merge meth=
od that
> > > did a merge without creating a merge? =A0I call it git-merge-subo=
rdinate
> > > (since my tree is subordinate to the tree I'm pulling from). =A0I=
 suppose
> > > you could call it 'slave' if you want to be more pithy. =A0Anyway=
, this
> > > is a first attempt, and it's totally cargo-cult programming; I ma=
ke no
> > > claim that I understand what I'm doing. =A0But it does seem to wo=
rk.
> >=20
> > Hmmm... the --squash option to git-merge/git-pull isn't enough?
>=20
> What subordinate does is not _merge_, but _rebase_ on top of the fetc=
hed=20
> commit. So yes, --squash isn't enough ;-)


And I would suggest calling it 'git-merge-rebase', as the strategy
really is rebase...  :-)

--=20
