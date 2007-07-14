From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Exporting a tree from a repository
Date: Sat, 14 Jul 2007 22:46:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707142237190.13310@beast.quantumfyre.co.uk>
References: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 23:46:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9pRV-0000o1-7J
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 23:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762559AbXGNVqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 17:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761771AbXGNVqO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 17:46:14 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:60591 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761276AbXGNVqN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2007 17:46:13 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5206BC6104
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 22:46:12 +0100 (BST)
Received: (qmail 26191 invoked by uid 103); 14 Jul 2007 22:46:11 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3665. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.033254 secs); 14 Jul 2007 21:46:11 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 Jul 2007 22:46:11 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52510>

On Sat, 14 Jul 2007, Ciprian Dorin Craciun wrote:

>   Hello all!
>
>   I am a new GIT user, I like it, so I started playing with it for
> different projects I work on.
>
>   Currently I am playing with "Linux from Scratch", and I have
> written some scripts to automatize the build process -- kind of
> install scripts...
>
>   For this I use GIT to store all the source packages -- each inside
> it's own branch :).
>
>   My question is the following: How can I export an entire tree
> without using a working directory, or cloning the repository. (Because
> from what I have seen so far there is no way to use the same
> repository with many working directories...)

You can have as many working directories as you want from one repository 
using the git-new-workdir script from contrib/workdir.  You do need to be 
careful when updating references though (you basically want to avoid 
updating a reference that you are using in another working directory).

You should also be able to use this to get an "export" - simply create the 
new workdir and then remove the .git (being careful not to accidentally do 
this in your actual repository).  However I expect there is a better way 
to do this ...

-- 
Julian

  ---
Quark!  Quark!  Beware the quantum duck!
