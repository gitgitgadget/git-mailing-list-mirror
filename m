From: Nicolas Pitre <nico@cam.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 16:08:15 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702131557430.1757@xanadu.home>
References: <45CFA30C.6030202@verizon.net>
 <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <20070213204248.GA21046@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 22:08:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH4sz-0001wp-9D
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 22:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXBMVIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 16:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXBMVIR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 16:08:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32480 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbXBMVIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 16:08:17 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDF00DR66PST6D0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Feb 2007 16:08:16 -0500 (EST)
In-reply-to: <20070213204248.GA21046@uranus.ravnborg.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39585>

On Tue, 13 Feb 2007, Sam Ravnborg wrote:

> This whole auto CRLF things seems to deal with DOS issues that I personally
> have not encountered since looong time ago.

Maybe you didn't share a work environment with Windows users since 
looong time ago.

> Granted notepad in Windows does not understand UNIX files but that a bug
> in notepad and everyone knows that wordpad can be used.
> 
> I wonder what we are really trying to address here. Or in other words
> could the original poster maybe tell what Windows IDE's that does
> not handle UNIX files properly?

Windows IDE's can _create_files.  Those files will be CRLF infected.

Also some of them read UNIX files just fine but they will use CRLF to 
end new added lines despite the rest of the file using only LF.

> core git today should not care about CRLF as opposed to LF end-of-line
> as long as the end-of-line is consistent - correct?

Consistency won't come alone if not enforced in some way.

> So defaulting to autoCRLF in Windows/DOS environments was maybe
> sane 10 years ago but today that seems to be the wrong thing to do.
> For certain project the option could be useful if the tool-set in
> the project *requires* CRLF, but if the toolset like all modern toolset
> supports both CRLF and LF then git better avoid changing end-of-line marker.

Rather git better enforce consistency otherwise it'll be only a mix of 
possible combination as soon as Windows and UNIX users work on the same 
project.


Nicolas
