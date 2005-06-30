From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:45:17 -0400
Message-ID: <20050630184517.GB28841@delft.aura.cs.cmu.edu>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:38:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do3vP-0003kZ-KU
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 20:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVF3Spa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 14:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVF3Spa
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 14:45:30 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:719 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262848AbVF3SpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 14:45:22 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1Do42H-0007ZY-00; Thu, 30 Jun 2005 14:45:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 10:54:48AM -0700, Linus Torvalds wrote:
> Anyway, please do give it a test. I think I'll use this to sync up to
> kernel.org, except I _really_ would want to solve that ssh issue some 
> other way than hardcoding the /home/torvalds/bin/ path in my local 
> copies.. If somebody knows a good solution, pls holler.

I've got a couple of 'export FOO=bar' lines in ~/.bashrc on the
"remote-side" and it looks like they are set correctly when
I do something like "ssh remote.host env".

Jan
