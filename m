From: Steven Grimm <koreth@midwinter.com>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 11:36:44 -0700
Message-ID: <4609643C.9050803@midwinter.com>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:37:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWGXK-0005Ys-4a
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 20:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934141AbXC0Sgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934167AbXC0Sgq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 14:36:46 -0400
Received: from tater.midwinter.com ([216.32.86.90]:37091 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934163AbXC0Sgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 14:36:45 -0400
Received: (qmail 939 invoked from network); 27 Mar 2007 18:36:43 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.131?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 27 Mar 2007 18:36:43 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43294>

Daniel Barkalow wrote:
> Somebody working on gcc for *BSD would presumably want to get all of gcc 
> and a shallow clone of the other 1000 submodules, right? Or they'd just 
> clone the submodule and ignore the superproject. At least, they'd need 
> shallow clones of a bunch of the submodules, because it's not interesting 
> to have the superproject otherwise.
>   

The obvious use case for "I want the superproject and just one 
submodule" is when the superproject has build tools, header files, or 
other pieces of data that are shared by some/all of the submodules. 
Maybe not the case in BSD per se, but having a top-level file full of 
settings, paths to tools, etc. that gets included by the individual 
Makefiles in subdirectories isn't all that uncommon in complex 
multi-part projects.

-Steve
