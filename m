From: Shawn Pearce <spearce@spearce.org>
Subject: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 02:36:20 -0400
Message-ID: <20060728063620.GD30783@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 28 08:36:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Lxp-00088g-9Z
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 08:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWG1GgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 02:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWG1GgZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 02:36:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37008 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751975AbWG1GgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 02:36:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6LxN-0002PB-Rf
	for git@vger.kernel.org; Fri, 28 Jul 2006 02:36:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C9DC120E433; Fri, 28 Jul 2006 02:36:20 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24369>

My Java GIT library and Eclipse GIT team provider is now at a point
where it may be partially useful to someone else who is also trying
to write something which interacts with GIT.  Or who might also
be interested in seeing a pure-Java Eclipse team provider for GIT.

So I've posted my repository (currently ~200 KB) on my website:

  http://www.spearce.org/projects/scm/egit.git


The underlying Java library is fairly functional and can read and
write a repository.  Creating a series of Ant tasks for use in an
automated build environment would probably be pretty trivial with
this library.

The Eclipse plugin can't commit.  Or do a lot of other really
useful things.  So its not end-user ready.  :-)


The code is licensed under the Apache License, version 2.0.


I would appreciate any and all input, feedback, etc. that anyone
might have on this library or plugin.  Patches are of course
certainly welcome.  :-)

For what its worth I'm trying to keep this library and Eclipse
plugin 100% pure Java and avoid calling out to the canonical C
implementation of GIT.  However I have no plans to implement the
delta packing algorithm used by git-pack-objects.  Consequently if
this code ever produces packs it will be strictly zlib deflated
objects without delta compression.

-- 
Shawn.
