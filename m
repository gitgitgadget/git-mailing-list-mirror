From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 17 Feb 2007 15:02:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070127040618.GA14205@fieldses.org>
 <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
 <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org>
 <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 15:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIQ9D-00025q-4o
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 15:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbXBQOCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 09:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbXBQOCi
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 09:02:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:50332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030193AbXBQOCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 09:02:37 -0500
Received: (qmail invoked by alias); 17 Feb 2007 14:02:36 -0000
X-Provags-ID: V01U2FsdGVkX18rjQRNC/wrUZ/NuDTGNVpfSiwAB3bGtMq8wXB1gD
	P1Fg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39988>

Hi,

On Sat, 27 Jan 2007, Johannes Schindelin wrote:

> Instead of (or, in addition to) --tags, to use only tags for naming,
> you can now use --ref-filter=<regex> to specify which refs are
> used for naming.
> 
> Example:
> 
> 	$ git name-rev --ref-filter='/v1' 33db5f4d
> 	33db5f4d tags/v1.0rc1^0~1593

Likes, dislikes?

Ciao,
Dscho
