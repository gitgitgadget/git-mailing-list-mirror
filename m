From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 17:57:15 -0800
Message-ID: <7vy7p22epw.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<8664c6xdgi.fsf@blue.stonehenge.com>
	<24BF45E9-DD98-4609-9D65-B01EAA30CCA8@silverinsanity.com>
	<86psaevxo3.fsf@blue.stonehenge.com>
	<7v64c63tol.fsf@assigned-by-dhcp.cox.net>
	<86hcvqvwyd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Terje Sten Bjerkseth" <terje@bjerkseth.org>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxDBT-0004If-E4
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWLUB5U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWLUB5U
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:57:20 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61506 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161133AbWLUB5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:57:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221015717.UVTJ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Dec 2006 20:57:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Dwa1W00X1kojtg0000000; Wed, 20 Dec 2006 20:56:35 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86hcvqvwyd.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 17:50:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35008>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> The patch I uploaded should be character-equivalent to Terje's.

Thanks.

> I don't know what "whitespace damage" you're referencing.

Aha, it was undamaged but rendered as if it were, because it was
of "content-type: text/plain; format=flawed".
