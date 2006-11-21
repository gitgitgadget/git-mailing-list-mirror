X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 11:47:17 -0500
Message-ID: <20061121164717.GB22006@spearce.org>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 16:47:58 +0000 (UTC)
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYmY-0003A7-7g for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031213AbWKUQr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031212AbWKUQr2
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:47:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:27330 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031213AbWKUQr0
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:47:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmYm9-0000fk-LA; Tue, 21 Nov 2006 11:47:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0935D20FB09; Tue, 21 Nov 2006 11:47:17 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> So having a config option would solve the problem, but what annoys me 
> right now about the config options is that we really should have a 
> graphical front-end to setting those things or something, because while 
> _I_ don't have any issues with editing a ".git/config" file, I think we're 
> getting to the point where a lot of our problems are really about "you can 
> do it, but you have to know a lot about git to even know you can do it".

Funny; I recently thought about rewriting Documentation/config.txt
into a format that was not only easily read by asciidoc but which
also had enough annotation data to render a Tk based UI from.

That way we could always have the configuration option editor match
the current set of configuration options, and also offer good help
for them.  E.g. use a checkbox for booleans, a tk_optionMenu for
choice lists, and offer up the asciidoc text as "help" on the option.

Its sort of in the back of my mind as something I'd like to do
in git-gui, but right now branch management (creating, deleting,
merging) is more important.


Right now git-gui does have a GUI editor for its own configuration
data that it keeps in "gui" sections of .git/config and
~/.gitconfig, and lets the user view and edit both.

-- 
