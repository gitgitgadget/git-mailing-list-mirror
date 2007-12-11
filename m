From: Nicolas Pitre <nico@cam.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:06:15 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111403080.555@xanadu.home>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ARA-0004Od-Q0
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbXLKTGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbXLKTGR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:06:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29482 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbXLKTGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:06:16 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW00LDZFQESTE0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 14:06:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67906>

On Tue, 11 Dec 2007, Linus Torvalds wrote:

> That said, I'll see if I can speed up "git blame" on the gcc repository. 
> It _is_ a fundamentally much more expensive operation than it is for 
> systems that do single-file things.

It has no excuse for eating up to 1.6GB or RAM though.  That's plainly 
wrong.


Nicolas
