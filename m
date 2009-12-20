From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git as electronic lab notebook
Date: Sat, 19 Dec 2009 22:15:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912192212400.28241@xanadu.home>
References: <loom.20091219T130946-844@post.gmane.org>
 <8e04b5820912190538v2e9ef109me3a1515040127b39@mail.gmail.com>
 <4B2D6CA5.3070304@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>,
	Thomas Johnson <thomas.j.johnson@gmail.com>,
	git@vger.kernel.org
To: Johan 't Hart <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 04:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMCGP-0004Ta-D6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 04:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbZLTDPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 22:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbZLTDPF
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 22:15:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28545 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbZLTDPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 22:15:01 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUX004BKL10GNC0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 19 Dec 2009 22:15:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B2D6CA5.3070304@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135516>

On Sun, 20 Dec 2009, Johan 't Hart wrote:

> Is git able to handle 4Gig files? I've heard git loads every file completely
> in memory before handling it...

Right.  Sowith current Git you will be able to deal with 4GB files only 
if you have a 64-bit machine and more than 4GB of RAM.


Nicolas
