From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Hash tags by commit SHA1 in git-describe.
Date: Sun, 14 Jan 2007 10:51:07 -0800
Message-ID: <7vr6txh278.fsf@assigned-by-dhcp.cox.net>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
	<20070113222816.GB18011@spearce.org>
	<Pine.LNX.4.63.0701141358440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhd-0006L2-Vg
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:02 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7o-0003eK-6G
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbXANSvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 13:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbXANSvK
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 13:51:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61705 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbXANSvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 13:51:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114185107.QHUB20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jan 2007 13:51:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B6rQ1W0091kojtg0000000; Sun, 14 Jan 2007 13:51:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701141358440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 14 Jan 2007 14:01:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36816>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 13 Jan 2007, Shawn O. Pearce wrote:
>
>> If a project has a very large number of tags then git-describe
>> will spend a good part of its time looping over the tags testing
>> them one at a time to determine if it matches a given commit.
>
> Why not just use object_refs? This also obviates the need for your patch 
> 3/4, since you no longer have buckets to search binarily. Plus, it uses a 
> hash map, which already turned out to beat (in terms of performance) the 
> hell out of bucketed lists in git history.

Very good point.
