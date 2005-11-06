From: Junio C Hamano <junkio@cox.net>
Subject: Re: git binary directory?
Date: Sun, 06 Nov 2005 00:33:32 -0800
Message-ID: <7vzmoi2n1f.fsf@assigned-by-dhcp.cox.net>
References: <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net>
	<200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
	<20051106050049.GA5910@vrfy.org>
	<7v4q6q5ock.fsf@assigned-by-dhcp.cox.net>
	<20051106082338.GN1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 09:35:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYfy5-00010G-Fq
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 09:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVKFIde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 03:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVKFIde
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 03:33:34 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:22183 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932333AbVKFIde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 03:33:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106083334.PQIW9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 03:33:34 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051106082338.GN1431@pasky.or.cz> (Petr Baudis's message of
	"Sun, 6 Nov 2005 09:23:38 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11197>

Petr Baudis <pasky@suse.cz> writes:

> At least BSDs still seem to have libexec, but they are just as likely to
> have lib, I would say, while on Linux it is going away (not that I would
> be excited about it). So we could either make this per-system, or
> default to something that is going to be present everywhere (lib),
> I think.

Yes, that should definitely be done per system.  The main
Makefile does not have it different from bindir.  In fact, the
main Makefile still installs everything in $HOME/bin by default.
