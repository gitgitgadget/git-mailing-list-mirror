X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-count-packs, like git-count-objects.
Date: Fri, 27 Oct 2006 21:11:17 -0700
Message-ID: <7v8xj1axlm.fsf@assigned-by-dhcp.cox.net>
References: <20061028040056.GA14191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 04:11:42 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061028040056.GA14191@spearce.org> (Shawn Pearce's message of
	"Sat, 28 Oct 2006 00:00:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30362>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdfXW-0000Cv-Ej for gcvg-git@gmane.org; Sat, 28 Oct
 2006 06:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751726AbWJ1ELT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 00:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWJ1ELT
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 00:11:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20889 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1751725AbWJ1ELS
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 00:11:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028041118.TAYW22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Sat, 28
 Oct 2006 00:11:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fgAz1V00c1kojtg0000000 Sat, 28 Oct 2006
 00:11:00 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Now that we are starting to save packs rather than unpacking into
> loose objects its nice to have a way to list the number of current
> packs and their total size.  This can help the user in deciding
> when its time to run `git repack -a -d`.

Why not just do "ls -lh $GIT_OBJECT_DIR/pack/pack-*.pack"???
