From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 08 May 2006 18:03:32 -0700
Message-ID: <7vac9sc8m3.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:03:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGdU-0008Bs-M5
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWEIBDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWEIBDe
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:03:34 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32478 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751192AbWEIBDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 21:03:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509010333.LGDW21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 21:03:33 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
	(Bertrand Jacquin's message of "Tue, 9 May 2006 02:55:48 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19799>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> Is there a way to track merge like that?

The command line you quoted shows the relevant information for
people who want to know what happened in that merge.

Namely:

 * it always shows the header and the message

 * it shows the changes that are not trivial (i.e. merge parents
   have overlapping different versions and manual resolution
   resulted in something different from either parents).

It is not a replacement for format-patch, but I think the commit
mailing list is not for machines to receive and apply the
received patches, but for humans to inspect, so it would be more
suitable than a naive alternative of showing diff from all
parents concatenated together.
