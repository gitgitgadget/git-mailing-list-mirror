From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] consider "git" wrapper semi-Porcelain
Date: Sun, 26 Jun 2005 05:02:14 -0700
Message-ID: <7voe9ts4vt.fsf@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
	<7vy88yvsjl.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506251821050.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 13:55:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmVjc-0007bj-6A
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 13:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVFZMCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 08:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFZMCU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 08:02:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44434 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261172AbVFZMCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 08:02:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050626120215.RLAO23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Jun 2005 08:02:15 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0506251821050.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 25 Jun 2005 18:21:47 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sat, 25 Jun 2005, Junio C Hamano wrote:
>> 
>> I would propose the following, preferably before we go 1.0:

LT> Agreed on all counts.

With holy Penguin pee blessings, I would send in a "flag day"
patch sometime before July 4th weekend that:

 - renames most of the git-*-script to git-*-cmd;
 - renames git-whatchanged to git-whatchanged-cmd;
 - renames two misnamed git-*-script to git-*-helper

without any backward compatibility warts.

Unless people object and propose good transition plans, that
is.

This message is for people who uses bare GIT and who writes
Porcelain.  Please consider yourselves warned ;-).

