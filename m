From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 15:07:04 -0800
Message-ID: <7vk6aoiulj.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vu09um3ae.fsf@assigned-by-dhcp.cox.net>
	<m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<20060320151833.GN18185@pasky.or.cz>
	<7vk6aokd7m.fsf@assigned-by-dhcp.cox.net>
	<20060320224123.GP18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 00:07:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLTSy-0000s8-6u
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 00:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWCTXHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 18:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWCTXHI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 18:07:08 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:51652 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932194AbWCTXHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 18:07:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320230501.OZML20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 18:05:01 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060320224123.GP18185@pasky.or.cz> (Petr Baudis's message of
	"Mon, 20 Mar 2006 23:41:23 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17770>

Petr Baudis <pasky@suse.cz> writes:

> Then you can make a simple change that if a refname matches a directory
> in refs/remotes/, you rewrite it as refs/remotes/<refname>/master. This
> makes 'origin' work seamlessly in a natural way and a lot more elegantly
> than if you make up an artifical rule like "if the remote's branch is
> master, save it as origin, but save all the other branches verbatim".

The "origin" rename applies only to the traditional one.
Separate remote stuff stores master in remotes/master.

At least that is the way I remember I designed it to work.
