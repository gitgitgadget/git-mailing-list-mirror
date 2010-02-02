From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Completion of error handling
Date: Tue, 02 Feb 2010 13:26:27 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002021324290.1681@xanadu.home>
References: <4B68249F.6070004@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:26:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcNSL-0005NK-Kj
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 19:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623Ab0BBS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 13:26:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37432 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab0BBS02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 13:26:28 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX800EM58K3SVW0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 02 Feb 2010 13:26:27 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B68249F.6070004@web.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138737>

On Tue, 2 Feb 2010, Markus Elfring wrote:

> Hello,
> 
> I would like to point out that some checks for return codes are missing in the source files.
> 
> Examples:
> Would you like to add more error handling for return values from "pthread_mutex_init" like in the function "start_threads" and from "fprintf" in the function "output_header_lines"?

What is the likelihood for those function calls to actually fail?


Nicolas
