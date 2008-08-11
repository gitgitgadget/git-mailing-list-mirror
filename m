From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict
 resolution.
Date: Mon, 11 Aug 2008 13:32:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111328590.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org> <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080811104006.GH32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abhijit Menon-Sen <ams@toroid.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 11 13:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSVaV-0000zE-7Y
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 13:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbYHKL2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 07:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbYHKL2T
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 07:28:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:53360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752105AbYHKL2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 07:28:18 -0400
Received: (qmail invoked by alias); 11 Aug 2008 11:28:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 11 Aug 2008 13:28:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8wp0kJOf82lPyFoGwObK6Tc7jbVji0J3k9Sqxyn
	vk9BPwaQudtjyf
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080811104006.GH32184@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91933>

Hi,

On Mon, 11 Aug 2008, Petr Baudis wrote:

>   this makes revert use rerere too, right?

That would actually be a problem, no?  I am not sure that resolutions for 
reverts make sense for cherry-picks, so I am not sure if resolutions 
should be recorded for reverts.

Thanks for bringing up that point,
Dscho
