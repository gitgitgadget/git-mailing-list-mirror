From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Problems with binary patches (pull) and spaces in filenames (gitk)
Date: Thu, 10 Nov 2005 00:33:00 +0100
Message-ID: <20051109233300.GA23244@ebar091.ebar.dtu.dk>
References: <20051109213730.GA23052@ebar091.ebar.dtu.dk> <7vfyq5bhi2.fsf@assigned-by-dhcp.cox.net> <7v8xvxbg9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 10 00:49:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzgm-0000nD-Vy
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbVKIXtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbVKIXtI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:49:08 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:28348 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1751633AbVKIXtH
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:49:07 -0500
Received: (qmail 23429 invoked by uid 5842); 9 Nov 2005 23:33:00 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8xvxbg9y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11447>

On Wed, Nov 09, 2005 at 02:36:09PM -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Hmm.  Perhaps a suboption to git-apply --stat to tell it not to
> > barf is helpful?  In the meantime, could you pull with -n flag?
> 
> Would this help?
> 
> -- >8 -- cut here -- >8 --
> [PATCH] git-apply: do not barf on binary diff when not applying.

Yes, it seems to work.  With my example it now shows the diff stats and
puts a "Bin" instead of the number of line changed.  It could show the
change in the size, but as it is, it's fine with me.  Please apply.

Peter
