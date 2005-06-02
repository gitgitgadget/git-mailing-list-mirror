From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Wed, 01 Jun 2005 18:43:58 -0700
Message-ID: <7vhdghh6sh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
	<7vacmapo18.fsf@assigned-by-dhcp.cox.net>
	<7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
	<7vpsv6kqx0.fsf@assigned-by-dhcp.cox.net>
	<7v1x7lk8fl.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506011738080.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Daniel Barkalow <barkalow@iabervon.org> Git Mailing List" 
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 03:41:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddehp-0002c3-Rt
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 03:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVFBBoC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 21:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVFBBoC
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 21:44:02 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39382 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261559AbVFBBoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 21:44:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602014359.OZFJ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 21:43:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506011738080.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 1 Jun 2005 17:58:33 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Why not just split out the current "unpack_sha1_file()" into two stages: 
LT> "unpack_sha1_header()" and the rest.
LT> which is a lot simpler than worrying about callbacks etc.

Alright.


