X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 04 Dec 2006 17:08:25 -0800
Message-ID: <7v8xhnm9o6.fsf@assigned-by-dhcp.cox.net>
References: <87odqm2ppv.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
	<4571DB40.6020800@vilain.net>
	<Pine.LNX.4.64.0612022246310.2630@xanadu.home>
	<7vd570q888.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:08:35 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Carl Worth <cworth@cworth.org>, Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33274>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOnP-00058B-1f for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967942AbWLEBI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967945AbWLEBI1
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:08:27 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64504 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967942AbWLEBI1 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:08:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205010827.OEUG97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Mon, 4 Dec
 2006 20:08:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id up8c1V00B1kojtg0000000; Mon, 04 Dec 2006
 20:08:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> If it doesn't match HEAD, we can't get it back as easily, so maybe that's 
> the case when we want to have "git rm -f filename".

Hmph.  Wouldn't this lossage the same as the lossage we are
removing the "safety valve" for, when "commit --only" jumps the
index?
