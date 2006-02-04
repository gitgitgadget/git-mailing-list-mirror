From: Paul Mackerras <paulus@samba.org>
Subject: Re: The merge from hell...
Date: Sat, 4 Feb 2006 21:46:21 +1100
Message-ID: <17380.34301.584514.520465@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 11:46:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5KwC-00020o-T5
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 11:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946102AbWBDKq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 05:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWBDKq3
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 05:46:29 -0500
Received: from ozlabs.org ([203.10.76.45]:19427 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751240AbWBDKq3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 05:46:29 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E0BC268A53; Sat,  4 Feb 2006 21:46:27 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15585>

Junio C Hamano writes:

> Linus Torvalds <torvalds@osdl.org> writes:
> > That octopus commit has got _twelve_ parents.

Making it a dodecapus, or something? :)

> But this is still interesting:
> 
> @@@@@@@@@@@@@ +308,35 @@@@@@@@@@@@@
>             			goto end;
>             		}
>             	}
>   --        	cx->usage++;
>   --        
>             
>      +++    #ifdef CONFIG_HOTPLUG_CPU
>      +++    	/*

Why is that interesting?  It seems to me that two independent changes
were made that just happened to be within a couple of lines of each
other, but didn't interact.  The reason that one change appears in two
branches, and the other in 3, is I think just related to where the
branches start from.  So IMHO this hunk isn't interesting.

Paul.
