From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 14:17:59 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051417090.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
 <alpine.LFD.2.00.0911042039200.10340@xanadu.home>
 <16cee31f0911050045t7a7301cdm39114997edfbfa60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:18:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N67qc-0001cI-PD
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 20:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758057AbZKETSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 14:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbZKETSG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:18:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62003 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbZKETSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 14:18:06 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSN005WPHLZCUT0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Nov 2009 14:17:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911050045t7a7301cdm39114997edfbfa60@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132235>

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> > However, my pthread_cond_init man page says:
> 
> And that is weird, because mine man page says:
> [[[
> pthread_cond_init, pthread_cond_signal, pthread_cond_broadcast, and
> pthread_cond_wait never return an error code.
> ]]]

Maybe that's for a particular implementation.


Nicolas
