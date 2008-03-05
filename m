From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] shortlog: take the first populated line of the description
Date: Wed, 05 Mar 2008 13:47:22 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803051346200.2947@xanadu.home>
References: <1204727050.0@pinky>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:48:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWyep-0001lS-0D
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 19:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbYCESrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 13:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYCESrY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 13:47:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27169 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYCESrY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 13:47:24 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX9006VJTIZ5GD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Mar 2008 13:47:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1204727050.0@pinky>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76248>

On Wed, 5 Mar 2008, Andy Whitcroft wrote:

> 
> Way back the perl version of shortlog would take the first populated line
> of the commit body.  The builtin version mearly takes the first line.
> This leads to empty shortlog entries when there is some viable text in
> the commit.
> 
> Reinstate this behaviour igoring all lines with nothing but whitespace.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> ---
> 
> 	This seems to be an improvement, returning to the original
> 	behaviour.  I cannot think of any good reason not to take the first
> 	populated line for a shortlog.	The alternative less agressive
> 	compromise might be to skip only completly empty lines at the
> 	start, but I am not sure that adds any value.
> 
> 	I seem to get a lot of these in converted SVN commits.
> 
> 	Comments?

Maybe it is the SVN conversion that needs fixing?


Nicolas
