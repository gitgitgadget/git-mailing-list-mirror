X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-show, was Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 00:28:48 -0800
Message-ID: <7vbqm6anjz.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612140113340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612132231050.18171@xanadu.home>
	<7vy7pb9eit.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612140855400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 08:28:58 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612140855400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 14 Dec 2006 08:59:18 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34285>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GulxV-0008HG-Ef for gcvg-git@gmane.org; Thu, 14 Dec
 2006 09:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751820AbWLNI2u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 03:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWLNI2u
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 03:28:50 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57349 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751820AbWLNI2t (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 03:28:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214082849.HJGR16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 03:28:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yYU91V00B1kojtg0000000; Thu, 14 Dec 2006
 03:28:10 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 13 Dec 2006, Junio C Hamano wrote:
>
>> One minor issue we may need to decide is what to do when show is
>> given a tag object.  Personally I think the current behaviour of
>> dereferencing it to commit is fine (people who want to see the
>> tag can always do 'git-verify-tag -v').
>
> How about adding the command line option "--tag" to git-show, which makes 
> it only show that tag. I'd also vote for a "--verbose|-v" flag to show the 
> contents of the tag _before_ showing the referenced object.

Sounds sensible.  Please make it so.
