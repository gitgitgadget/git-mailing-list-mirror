From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0
Date: Mon, 06 Jun 2005 00:05:29 -0700
Message-ID: <7vekbgufra.fsf@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
	<20050606054356.GB3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
	<20050606064456.GC3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 09:02:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBcf-00005r-1P
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 09:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFFHFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 03:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFFHFi
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 03:05:38 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29835 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261152AbVFFHFb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 03:05:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606070529.ZNTE19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Jun 2005 03:05:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 23:57:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Not exactly. It updates the index directly, without necessarily updating 
LT> the working directory. For example:

LT> 	"$1.." | "$1.$1" | "$1$1.")
LT> 	        echo "Removing $4"
LT> 	        exec git-update-cache --force-remove "$4" ;;

LT> it _says_ "removing $4", but it never actually does so, so the working 
LT> directory still has the file ;)

Yes, this was done from your explicit request not to touch the
working directory while it works AFAICR.  At least back then,
not touching the working tree was the _requirement_.

So is "the new merge world order" you mentioned in the log
message now require (and assume) the work tree more-or-less
matches the first head being merged?

