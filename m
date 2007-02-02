From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 09:55:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702020953190.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
 <200702021302.10567.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 15:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCzp6-0004UI-5f
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 15:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914AbXBBOz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 09:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbXBBOz3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 09:55:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28923 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161131AbXBBOz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 09:55:28 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCU00LGAC4E4G70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Feb 2007 09:55:26 -0500 (EST)
In-reply-to: <200702021302.10567.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38502>

On Fri, 2 Feb 2007, Andy Parkins wrote:

> On Friday 2007 February 02 11:02, Lars Hjemli wrote:
> 
> >   "HEAD@{yesterday}" = current branch, yesterday
> >   "@{yesterday}"     = detached head (no branch), yesterday
> 
> I'd vote for this too.  It's the only logically consistent view.

No it is not.

> HEAD is a symbolic reference, it's a way of referring to a real branch by 
> another name.  HEAD@{} should be the same as branch@{} to be consistent.

HEAD is _NOT_ a symbolic reference.  It _may_ happen to be a symbolic 
reference, but it _may_ happen to not be.

And please see my previous email for more arguments.


Nicolas
