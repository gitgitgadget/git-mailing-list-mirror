X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 19:45:53 -0800
Message-ID: <7vk60nmdqm.fsf@assigned-by-dhcp.cox.net>
References: <7vpsafmh89.fsf@assigned-by-dhcp.cox.net>
	<655753.13323.qm@web31812.mail.mud.yahoo.com>
	<20061220024317.GA27918@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 03:46:01 +0000 (UTC)
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061220024317.GA27918@spearce.org> (Shawn Pearce's message of
	"Tue, 19 Dec 2006 21:43:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34907>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwsP0-0000vH-8K for gcvg-git@gmane.org; Wed, 20 Dec
 2006 04:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964845AbWLTDpz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 22:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWLTDpz
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 22:45:55 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:40819 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964845AbWLTDpy (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 22:45:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220034554.COTC29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 22:45:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0rlC1W00M1kojtg0000000; Tue, 19 Dec 2006
 22:45:13 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> I completely fail to see how this patch would cause a segfault
> downstream in xdl_merge.  All this controls is do we mmap data from
> the working directory or decompress it from the ODB.  Either way we
> should have loaded the file size or content into the diff_filespec.

Me neither.  Quite puzzled...

