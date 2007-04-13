From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] Teach 'diff' about 'nodiff' attribute.
Date: Fri, 13 Apr 2007 10:09:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704131007140.28181@xanadu.home>
References: <7vodlsd4wc.fsf@assigned-by-dhcp.cox.net>
 <200704131230.41594.andyparkins@gmail.com> <461F6D74.63EF2769@eudaptics.com>
 <200704131354.57056.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 16:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcMTC-0003HN-UH
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 16:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbXDMOJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbXDMOJl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 10:09:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9715 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbXDMOJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 10:09:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGF001VAWO3DAG0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Apr 2007 10:09:39 -0400 (EDT)
In-reply-to: <200704131354.57056.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44406>

On Fri, 13 Apr 2007, Andy Parkins wrote:

> If I've understood the attributes system correctly, it's worth bearing 
> in mind that "!diff" is not the same as "nodiff".  The not in "!diff" 
> means "supress the attribute diff", not as you would traditionally 
> imagine "not-diff".  In this case it doesn't matter because there are 
> only two possibilities for the diff engine - show the diff or don't.  
> However, more attributes might get added that aren't so simple.
> 
> Junio - This makes me think that perhaps "!" is not the right symbol for 
> this - that's going to get read by programmers everywhere as NOT, 
> rather than suppress.  Perhaps it doesn't matter, I might be 
> over-thinking this.

Maybe "-" then?  That better convey the notion of suppression while "!" 
is more about negation.


Nicolas
