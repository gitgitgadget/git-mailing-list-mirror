X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 13:42:38 -0500
Message-ID: <20061121184238.GC22283@spearce.org>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx> <20061121183853.GA61605@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:46:08 +0000 (UTC)
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121183853.GA61605@dspnet.fr.eu.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32019>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmad4-00041z-OY for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031300AbWKUSpz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031301AbWKUSpz
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:45:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:30426 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031300AbWKUSpy
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:45:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmaZl-0004ON-9v; Tue, 21 Nov 2006 13:42:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D931F20FB09; Tue, 21 Nov 2006 13:42:38 -0500 (EST)
To: Olivier Galibert <galibert@pobox.com>
Sender: git-owner@vger.kernel.org

Olivier Galibert <galibert@pobox.com> wrote:
> On Tue, Nov 21, 2006 at 06:11:19PM +0100, Peter Baumann wrote:
> > And I think handling this behaviour as a config option is the right thing,
> > because most of the time if someone imports a project into git he
> > will import the whole history, especially if he is using one of the
> > cvs/svn importers. A "halfway import" as seen in the kernel repo is a
> > special case and it is unlikely seen again.
> 
> Not all projects run on a public VCS.  Hell, not all projects run on a
> VCS at all.  And in the CVS case, you don't always have enough access
> to actually download the repository, which afaik is needed for
> importing.

There is a tool floating around the 'net that will download
a CVS repository and recreate the ,v files locally for you.
cvssuck appears to be its name:

  http://freshmeat.net/projects/cvssuck/

-- 
