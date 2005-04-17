From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 21:58:55 +0100
Message-ID: <20050417215854.H13233@flint.arm.linux.org.uk>
References: <20050417195935.GI1461@pasky.ji.cz> <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Paul Jackson <pj@sgi.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 22:55:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGnn-0002QB-54
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDQU7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVDQU7T
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:59:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59914 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261457AbVDQU7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 16:59:05 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNGr2-0008U0-Ey; Sun, 17 Apr 2005 21:58:56 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNGr1-0007Mg-7Z; Sun, 17 Apr 2005 21:58:55 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>; from barkalow@iabervon.org on Sun, Apr 17, 2005 at 04:03:46PM -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 04:03:46PM -0400, Daniel Barkalow wrote:
> Actually, the documentation I've got says:
> 
> "F_OK requests checking whether merely testing for the existence of the
>  file would be allowed (this depends on the permissions of the directories
>  in the path to the file, as given in path-name.)"
> 
> So it shouldn't complain about a filename which you're allowed to try to
> stat, even if there's nothing there. And it would depend on the privs of
> the wrong user in looking at the path.

Isn't it the case that with selinux, various objects may be hidden
depending on their accessibility?  I wonder if this has an effect
here.

(or what about any other security model?)

-- 
Russell King

