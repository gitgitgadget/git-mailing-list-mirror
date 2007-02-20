From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Use git-update-ref to update a ref during commit in
 git-cvsserver
Date: Tue, 20 Feb 2007 16:57:18 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702201654310.31945@xanadu.home>
References: <200702200857.02779.andyparkins@gmail.com>
 <200702202010.02128.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 22:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJczE-0007qV-25
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 22:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbXBTV5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 16:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbXBTV5V
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 16:57:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41421 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030470AbXBTV5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 16:57:20 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDS00A307NJ4V90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Feb 2007 16:57:19 -0500 (EST)
In-reply-to: <200702202010.02128.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40264>

On Tue, 20 Feb 2007, Andy Parkins wrote:

> Nicholas Pitre mentioned that updating a reference should be done with
> git-update-ref.
> 
> This patch does that and includes the -m option to have the reflog
> updated as a bonus.
> 
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> As promised...

What if git-update-ref fails?  This may occur if the server repo was 
updated and the client needs to "cvs up" again before commit.


Nicolas
