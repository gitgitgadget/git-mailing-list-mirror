From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 00:07:45 +0200
Message-ID: <20070506220745.GA2439@steel.home>
References: <20070506190224.GG30511@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 07 00:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkotT-0008Dw-EH
	for gcvg-git@gmane.org; Mon, 07 May 2007 00:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXEFWHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbXEFWHs
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 18:07:48 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:23045 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbXEFWHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 18:07:47 -0400
Received: from tigra.home (195.4.200.47)
	by post.webmailer.de (mrclete mo39) (RZmta 5.9)
	with ESMTP id I005d3j46K322t ; Mon, 7 May 2007 00:07:45 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 88DF0277BD;
	Mon,  7 May 2007 00:07:45 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2C72CD171; Mon,  7 May 2007 00:07:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070506190224.GG30511@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWopCbQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46380>

Martin Waitz, Sun, May 06, 2007 21:02:24 +0200:
> When merge-recursive gets to a dirlink, it starts an automatic
> submodule merge and then uses the resulting merge commit for the
> top-level tree.

merge-recursive is a mess already, you just made even more so.
Besides, you completely forgot all other merge strategies.

How about making all existing strategies just ignore submodules, and
move recursive merge in the merge driver (git-merge.sh)?
