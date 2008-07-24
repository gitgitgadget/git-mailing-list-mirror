From: Petr Baudis <pasky@suse.cz>
Subject: Re: git newbie - cloning / check out help
Date: Fri, 25 Jul 2008 01:15:31 +0200
Message-ID: <20080724231531.GS32184@machine.or.cz>
References: <loom.20080724T211609-298@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Donald Brady <dbrady010@me.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 01:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMA30-0006Ma-M7
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbYGXXPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbYGXXPe
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:15:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49741 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbYGXXPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:15:33 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3110A393A2DF; Fri, 25 Jul 2008 01:15:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080724T211609-298@post.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89968>

  Hi,

On Thu, Jul 24, 2008 at 09:24:34PM +0000, Donald Brady wrote:
> I am just ramping up on git and have the following scenario / issue:
> 
>   I have a git repository on server A.
> 
>   I clone it onto my machine B.
> 
>   In my local copy/repository on machine B I clone a repository on some 
> third party server C.
> 
>   I commit my changes into B and push them to A.
> 
>   Now if I clone my repository from Server A onto my local machine
>  in a different location I see all the source as normal but only the top
>  level directory of C. Any source under that is not present. 
> 
> What is the magic git incantation to make sure that I check out 
> not only the code from my repository but  any repositories that
> are cloned into it (recursive clone?)

  we call this functionality "submodules" and the quickstart howto is:

	You have git repository on A

	You clone it onto your machine B

	git submodule add url directoryC

	You commit your changes into B and push them to A

	You do another clone of A and then within the clone

	git submodule update --init

For further details, see git-submodule(1).

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
