From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 20:26:16 -0800
Message-ID: <7vbr0ir387.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>
	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>
	<7vfypur5jb.fsf@assigned-by-dhcp.cox.net> <437D4F57.9070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 05:32:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcxpN-0006lM-JT
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVKRE0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVKRE0T
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:26:19 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12991 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932507AbVKRE0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 23:26:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118042547.LAZH20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 23:25:47 -0500
To: git@vger.kernel.org
In-Reply-To: <437D4F57.9070303@gmail.com> (A. Large Angry's message of "Thu,
	17 Nov 2005 19:49:43 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12193>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Files /dev/null and b/file3 differ
> diff --git a/file4 b/file4
> index 
> edc575dec543a684da5007b43886ee32ecb381ae..adb07b7ad3fa2c63251b06d1d39cb90a85b860b4 
> 100644
> Files a/file4 and b/file4 differ

Thanks.  I've seen enough.  I expected diff (GNU diffutils 2.8.1
is what I have handy) output which says "Binary files a/foo and
b/foo differ".

Hmph.  Now I'd need to find a way to catch at least these two
cases...
