From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
	unknown command
Date: Sat, 7 Jun 2008 19:51:03 +0200
Message-ID: <20080607175103.GA5822@steel.home>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080607072721.GA3347@steel.home> <alpine.DEB.1.00.0806071603470.1783@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 19:52:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K52aA-0003d7-L5
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 19:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbYFGRvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 13:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761122AbYFGRvJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 13:51:09 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:43182 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbYFGRvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 13:51:08 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarHHwhMGIA==
Received: from tigra.home (Fadd9.f.strato-dslnet.de [195.4.173.217])
	by post.webmailer.de (mrclete mo47) (RZmta 16.42)
	with ESMTP id K04c9ck57DFM0q ; Sat, 7 Jun 2008 19:51:04 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 51C7C277BD;
	Sat,  7 Jun 2008 19:51:04 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 192D956D28; Sat,  7 Jun 2008 19:51:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806071603470.1783@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84221>

Johannes Schindelin, Sat, Jun 07, 2008 17:04:14 +0200:
> -	for (i = 0; i < main_cmds.cnt; i++) {
> +	for (i = 0; i < main_cmds.cnt && i < 5; i++) {

I accidentally considered "i" just the index in the global command
table. Of course it is better :)
