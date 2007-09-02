From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Stats in Git
Date: Sun, 2 Sep 2007 22:02:18 +0200
Message-ID: <20070902200218.GA2756@steel.home>
References: <46DACD93.9000509@trolltech.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:03:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRvep-0003lQ-DY
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 22:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXIBUCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbXIBUCW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 16:02:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:50203 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbXIBUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 16:02:21 -0400
Received: from tigra.home (Fc92a.f.strato-dslnet.de [195.4.201.42])
	by post.webmailer.de (mrclete mo11) (RZmta 12.3)
	with ESMTP id 001ef8j82IowfP ; Sun, 2 Sep 2007 22:02:19 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2ABEE277BD;
	Sun,  2 Sep 2007 22:02:19 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BEAC4BEAC; Sun,  2 Sep 2007 22:02:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46DACD93.9000509@trolltech.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAFvMw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57382>

Marius Storm-Olsen, Sun, Sep 02, 2007 16:49:55 +0200:
> By applying the diff below, you can see for yourself what happens when

just use "strace -e fstat,stat,lstat,stat64,lstat64 -f git-status"
on sane platform.
