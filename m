From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 14:27:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002021424550.1681@xanadu.home>
References: <4B68249F.6070004@web.de>
 <alpine.LFD.2.00.1002021324290.1681@xanadu.home> <4B6873AC.4030303@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcOPP-0006y4-AA
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990Ab0BBT1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:27:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8966 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab0BBT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:27:30 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX8001E0BDSE630@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Feb 2010 14:27:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B6873AC.4030303@web.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138742>

On Tue, 2 Feb 2010, Markus Elfring wrote:

> 
> > What is the likelihood for those function calls to actually fail?
> 
> Do you know the probability for failed memory allocations?
> 
> Would you like to care for error codes from all Pthread function calls?

Not necessarily.  At least on Linux, most of those functions simply 
cannot fail.  There is just no dynamic memory allocation involved.  All 
other errors are normally due to bad code.


Nicolas
