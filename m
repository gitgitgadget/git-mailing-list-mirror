From: Junio C Hamano <junkio@cox.net>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Wed, 12 Jul 2006 21:34:15 -0700
Message-ID: <7vac7exgvs.fsf@assigned-by-dhcp.cox.net>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
	<44B37893.5090501@innova-card.com>
	<7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
	<44B4A6CA.3020206@innova-card.com>
	<Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>
	<7v1wsqzt8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607120931150.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 06:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0suS-0003qv-47
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWGMEeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGMEeT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:34:19 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39554 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932225AbWGMEeS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 00:34:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713043417.WPCW8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 00:34:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607120931150.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Jul 2006 09:37:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23807>

Linus Torvalds <torvalds@osdl.org> writes:

> So being somewhat forgiving might help, but I think another thing that 
> migth help is a flag to "git-am" to _not_ apply a patch that lacks a 
> previous sign-off.

How about having this in $GIT_DIR/hooks/applypatch-msg?

	#!/bin/sh
	grep '^Signed-off-by: ' "$1" >/dev/null
