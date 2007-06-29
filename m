From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git add: respect core.filemode even with unmerged
 entriesin  the index
Date: Fri, 29 Jun 2007 11:07:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706291106190.4438@racer.site>
References: <20070625064017.GA2839@mellanox.co.il>  <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
      <20070625071752.GB15343@mellanox.co.il>  <Pine.LNX.4.64.0706250846200.4059@racer.site>
     <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>   
 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com>
  <Pine.LNX.4.64.0706281506390.4438@racer.site> <4683C5D2.FDF4ED02@eudaptics.com>
  <4683CA7A.7F8070D7@eudaptics.com> <Pine.LNX.4.64.0706281653260.4438@racer.site>
 <4684AD41.9868C32F@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 12:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4DTF-0006VK-Gz
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 12:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbXF2KMz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 06:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbXF2KMz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 06:12:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:38353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755016AbXF2KMy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 06:12:54 -0400
Received: (qmail invoked by alias); 29 Jun 2007 10:12:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 29 Jun 2007 12:12:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zYE5PCEXzlL+UghhVAi0fhapBzPqVcti4dnoKhq
	1R2C3Az6A1bzne
X-X-Sender: gene099@racer.site
In-Reply-To: <4684AD41.9868C32F@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51169>

Hi,

On Fri, 29 Jun 2007, Johannes Sixt wrote:

> However, if only two stages are present, the file mode is still taken 
> from the file instead of from the index. As that easy to solve (at least 
> for the unambiguous case)?

It might be related to the bug Junio found, i.e. that I assumed stage 1 to 
be "ours".

Ciao,
Dscho
