From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to set git commit timestamp
Date: Sun, 6 May 2007 18:41:36 +0200
Message-ID: <20070506164136.GB2434@steel.home>
References: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Sun May 06 18:41:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkjnq-0001BS-SO
	for gcvg-git@gmane.org; Sun, 06 May 2007 18:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbXEFQlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 12:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbXEFQlj
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 12:41:39 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:9828 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbXEFQli (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 12:41:38 -0400
Received: from tigra.home (195.4.200.47)
	by post.webmailer.de (mrclete mo48) (RZmta 5.9)
	with ESMTP id I00634j46GV7aW ; Sun, 6 May 2007 18:41:37 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D5D21277BD;
	Sun,  6 May 2007 18:41:36 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 80EBED171; Sun,  6 May 2007 18:41:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705061759210.8165@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWopCbQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46345>

Guido Ostkamp, Sun, May 06, 2007 18:03:14 +0200:
> 
> does somebody know a method to specify a timestamp for a 'git commit'?
> 

Set GIT_AUTHOR_DATE (and maybe GIT_COMMITTER_DATE) in the environment.
