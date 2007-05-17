From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 11:01:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705171054450.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site> <vpq8xbnlmdv.fsf@bauges.imag.fr>
 <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com>
 <Pine.LNX.4.64.0705171445100.6410@racer.site>
 <46a038f90705170709j7eb23d4fy6811fc2985dd888d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 17:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HohTh-0003Fb-Fy
	for gcvg-git@gmane.org; Thu, 17 May 2007 17:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbXEQPBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbXEQPBL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 11:01:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13300 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbXEQPBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 11:01:09 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI600IJWXPQQYI0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 11:01:02 -0400 (EDT)
In-reply-to: <46a038f90705170709j7eb23d4fy6811fc2985dd888d@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47530>

On Fri, 18 May 2007, Martin Langhoff wrote:

> On 5/18/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > If you have a solution for that problem, please enlighten me: I don't.
> 
> Ok - worst case scenario - have a minimal hints file that tells me the
> ranges to fetch all commits and all trees. To reduce that Add to the
> hints file data to name the hashes (or even better - offsets) for the
> delta chains that contain commits+trees relevant to all the heads -
> minus 10, 20, 30, 40 commits and 1,2,4,8 and 16 days.

NO !

This is unreliable, unnecessary, and actually kills the beauty of 
the solution's simplicity.

You get updates for every branches the remote has, period.

No server side extra files, no guesses, no arbitrary ranges, no backward 
compatibility issues, no crap!


Nicolas
