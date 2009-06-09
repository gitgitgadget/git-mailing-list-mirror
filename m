From: Nicolas Pitre <nico@cam.org>
Subject: Re: git clone failing over slow links?
Date: Tue, 09 Jun 2009 14:55:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906091443050.31536@xanadu.home>
References: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 09 20:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6UL-0007km-5e
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZFISzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbZFISzs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:55:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64115 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZFISzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:55:47 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKZ004G2J8HVG50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jun 2009 14:55:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121205>

On Tue, 9 Jun 2009, skillzero@gmail.com wrote:

> People with slower connections are having problems cloning my
> repository. The server seems to just drop the connection. This
> repository is about 300 MB. The server is using git 1.6.1. This is
> using an ssh URL. They've tried many times and it usually dies at
> different places in the clone (5%, 80%, etc., with one successful
> clone so far for them).

Do you clearly have a set of people for whom the clone works and another 
set with issues?

> remote: Counting objects: 121290, done.
> remote: Compressing objects: 100% (82778/82778), done.
> fatal: The remote end hung up unexpectedly62.14 MiB | 147 KiB/s

147 KiB/s is not particularly slow either.  What is fast enough for the 
clone to usually succeed?

Also, since this is through an ssh connection, do you have anything in 
your syslog from sshd (usually in /var/log/secure) about anything 
unusual for the connection to go down?

> Are there any known issues with git 1.6.1 that might cause this? I can
> try to get the server updated to 1.6.2.3, but I was curious if anyone
> knew of any specific issues like this. The server is running Mac OS X,
> if that matters.

Maybe it does.  Major sites using git often use Linux and we would have 
heard from them if anything like your problem was seen there.


Nicolas
