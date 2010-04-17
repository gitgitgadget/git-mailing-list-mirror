From: david@lang.hm
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 04:48:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1004170439170.16996@asgard.lang.hm>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>  <4BC9364D.7020204@gmail.com>  <alpine.DEB.2.01.1004162120490.16996@asgard.lang.hm> <t2g3e2876431004170415r71d5f834z3bfdedfaec076c6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Miguel Ramos <mail@miguel.ramos.name>
X-From: git-owner@vger.kernel.org Sat Apr 17 13:49:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O36WC-0003T6-Pc
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab0DQLsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:48:50 -0400
Received: from mail.lang.hm ([64.81.33.126]:46396 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137Ab0DQLst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:48:49 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id o3HBmcE4004404;
	Sat, 17 Apr 2010 04:48:43 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <t2g3e2876431004170415r71d5f834z3bfdedfaec076c6c@mail.gmail.com>
User-Agent: Alpine 2.01 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145138>

On Sat, 17 Apr 2010, Miguel Ramos wrote:

> Well, David, you certainly made a good case defending using a VCS for
> filesystems.
> However, a versioned filesystem should be more adequate for that.

a versioned filesystem will not let you easily clone or backup your 
system. a versioned filesystem could be a nice UI to access a DVCS that 
would give you this sort of ability

> Why would one want diffs, patches, branches, merges for the entire filesystem?

these all seem like very useful things to me

diffs to find out what changed when a system gets broken, or after 
something new is installed.

patches could be a way to either install software, or to propogate updates 
between systems.

branches could easily be different systems

merges are for when you have two systems each doing one job and you want 
to combine them onto one piece of hardware (could could do it with 
virtualization, if you are willing to pay the overhead). you wouldn't want 
to merge the binary files, but you would want to merge the branches that 
contain binary files.

there are many reasons why you don't just use your linux distro tools to 
manage large numbers of machines and configurations.

David Lang
