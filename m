X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 08 Dec 2006 12:29:14 -0600
Message-ID: <1165602554.19135.309.camel@cashmere.sps.mot.com>
References: <20061130170625.GH18810@admingilde.org>
	 <200612010902.51264.andyparkins@gmail.com>
	 <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de>
	 <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de>
	 <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se>
	 <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se>
	 <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se>
	 <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>
	 <457061A7.2000102@b-i-t.de>
	 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 18:31:32 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, Git List <git@vger.kernel.org>,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33717>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GskVL-0001LW-Pk for gcvg-git@gmane.org; Fri, 08 Dec
 2006 19:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760817AbWLHSbX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760823AbWLHSbX
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 13:31:23 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:40402 "EHLO
 az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760817AbWLHSbW (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 13:31:22 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200]) by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
 kB8IUpkM027163; Fri, 8 Dec 2006 11:30:55 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id kB8IUoYL010039; Fri, 8
 Dec 2006 12:30:50 -0600 (CST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Fri, 2006-12-01 at 14:13, Linus Torvalds wrote:

> So this is why it's really important that the submodule really is a git 
> repository in its own right, and why committing stuff in the supermodule 
> NEVER affect the submodule itself directly (it might _cause_ you to also 
> do a commit in the submodule indirectly, but the submodule commit MUST be 
> totally independent, and stand on its own).

An implication of this is that the entire administrative
responsibility for having some super-sub module interaction
lies entirely with the supermodule.

Why not have a "glue" object at the "stub"-interface of
the supermodule tree that provides policy mappings to
the sub-modules.  Perhaps indicating git URL location,
mappings of branch names between super- and sub- modules,
special commit SHA1s, user policy or config choices at
the boundary, and things like that.

Is that the sort of direction we are headed?

jdl

