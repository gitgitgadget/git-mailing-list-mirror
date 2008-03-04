From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-log segfault on 00 graft
Date: Tue, 4 Mar 2008 19:09:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041908210.22527@racer.site>
References: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWcXC-0004mV-H3
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 20:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbYCDTKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 14:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756153AbYCDTKE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 14:10:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:60229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbYCDTKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 14:10:03 -0500
Received: (qmail invoked by alias); 04 Mar 2008 19:10:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 04 Mar 2008 20:10:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185fKpgBx451MvEQ8aLGfsGslKTUrmpLB1t1JOCs9
	MjXc36w9AkcFQm
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0803041954320.7660@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76129>

Hi,

On Tue, 4 Mar 2008, Jan Engelhardt wrote:

> I was playing a bit with grafts, and actually did this:
> 
>   echo '839affa3313011da783b5b8074a5c9805ee8503a 
> 0000000000000000000000000000000000000000' >.git/info/grafts
> 
> running `git log --topo-order` causes a segfault. Yes, I probably 
> "should not be doing that", but I think it at least should not
> segfault.

Well, I agree with the first, but not the latter.  grafts are a really 
core and plumbing thing, and if you set it to something nonsensical, I 
think you should expect something like a segmentation fault.

Ciao,
Dscho

