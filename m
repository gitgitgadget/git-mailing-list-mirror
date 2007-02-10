From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 10:54:27 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	GIT list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 10 16:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFuYq-0000fj-Mw
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 16:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbXBJPyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 10:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbXBJPyb
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 10:54:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39940 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692AbXBJPy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 10:54:28 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD900H0V86R3WC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Feb 2007 10:54:27 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39232>

On Sat, 10 Feb 2007, Johannes Schindelin wrote:

> So, what is the big problem about accepting that patching git-status for 
> one obscure use is wrong, wrong, wrong, when git-diff already does what is 
> needed???

Because git-status itself is conceptually a read-only operation, and 
having it barf on a read-only file system is justifiably a bug.

But I agree that attempting to fix it now is probably just too risky not 
to compromize the 1.5.0 release.  Better leave it as a known issue for 
v1.5.0 and fix it later... especially if there is a possible workaround 
in the mean time.


Nicolas
