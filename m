From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a
 certain blob
Date: Sun, 18 Feb 2007 16:41:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702181639480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3bj248.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 16:41:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIoAM-0005UN-VL
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 16:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbXBRPlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXBRPlU
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 10:41:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:38736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751322AbXBRPlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 10:41:19 -0500
Received: (qmail invoked by alias); 18 Feb 2007 15:41:18 -0000
X-Provags-ID: V01U2FsdGVkX18bsnQple4bcgNQwa3ga29+5uNTFx4YPqTRFeZykK
	yyRA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz3bj248.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40076>

Hi,

On Sun, 18 Feb 2007, Junio C Hamano wrote:

> It's more like he learns the contents _and_ the path from an end-user 
> who is having trouble with a tarball of unknown vintage, and wants to 
> identify which snapshot had that contents at that path [*1*].

Ah! Then it would make more sense to make it a new revision-walk filter?

Ciao,
Dscho
