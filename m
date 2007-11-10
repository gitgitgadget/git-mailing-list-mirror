From: Nicolas Pitre <nico@cam.org>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 00:13:36 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 06:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqifJ-0006Ls-V6
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 06:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbXKJFNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 00:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbXKJFNi
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 00:13:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54709 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXKJFNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 00:13:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR900KP4YIORYT0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Nov 2007 00:13:37 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64303>

On Fri, 9 Nov 2007, bob wrote:

> When a repository is packed such as for a clone or fetch, is there just one
> pack file created that is used for the transfer?

Yes.

And modern Git is able to handle packs larger than 4GB too, assuming it 
is compiled using a toolchain with large file support.


Nicolas
