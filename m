From: fork0@t-online.de (Alex Riesen)
Subject: Re: RFH: refactor read-tree
Date: Sun, 9 Jul 2006 14:43:24 +0200
Message-ID: <20060709124324.GE5919@steel.home>
References: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 14:43:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzYdM-0004sh-4L
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 14:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWGIMnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 08:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWGIMnd
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 08:43:33 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:459 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030477AbWGIMnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 08:43:32 -0400
Received: from fwd34.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1FzYdD-0007uP-06; Sun, 09 Jul 2006 14:43:27 +0200
Received: from tigra.home (r4+CKcZerePrABSpvMWq-HRd0SWQN7GUDPSi19V3+KYLYIjYSn64QX@[84.160.119.250]) by fwd34.sul.t-online.de
	with esmtp id 1FzYdB-1e65qa0; Sun, 9 Jul 2006 14:43:25 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B7313277AF;
	Sun,  9 Jul 2006 14:43:24 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FzYdA-0002Ct-FY; Sun, 09 Jul 2006 14:43:24 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: r4+CKcZerePrABSpvMWq-HRd0SWQN7GUDPSi19V3+KYLYIjYSn64QX
X-TOI-MSGID: dd7c5b05-6002-4bb6-a1a1-c587b49acffd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23548>

Linus Torvalds, Sun, Jul 09, 2006 05:15:41 +0200:
> The basic idea is that "branch1" should be your current branch, and it 
> obviously is also expected to match (more or less) the current index. So 
> you can do a merge by
> 
>  - reading in "branch1" into the index:
> 
> 	GIT_INDEX_FILE=.git/tmp-index git-read-tree -m branch1

what is "-m" here for?
