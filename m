From: Nicolas Pitre <nico@cam.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 14:59:49 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161454280.18328@xanadu.home>
References: <20070316042406.7e750ed0@home.brethil>
 <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
 <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com>
 <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSHeb-00028q-Tj
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965871AbXCPS7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965880AbXCPS7v
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:59:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32424 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965871AbXCPS7u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:59:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF000DPVFFPEAC0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 14:59:49 -0400 (EDT)
In-reply-to: <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42394>

On Fri, 16 Mar 2007, Marco Costalba wrote:

> On 3/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > 
> > *The most important thing for a libgit to be used by qgit is reentrancy*
> > 
> 
> Another crtitical feature is that this call to git-rev-list-like
> function MUST be non-blocking.

I'm not sure I agree.

The non-blockingness can be (and probably should be) handled at a higher 
level with your own threading facility of choice.  Making GIT 
restartable has the potential for making the core code much too complex.


Nicolas
