From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support output ISO 8601 format dates
Date: Sun, 15 Jul 2007 15:14:51 -0700
Message-ID: <7vveclco10.fsf@assigned-by-dhcp.cox.net>
References: <20070713202258.14107.18196.stgit@lathund.dewire.com>
	<20070715212359.GB18293@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, junkio@cox.net,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jul 16 00:15:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IACMr-0004No-HS
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 00:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbXGOWOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbXGOWOx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 18:14:53 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43652 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbXGOWOx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 18:14:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715221452.WHRV1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 18:14:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PyEr1X00K1kojtg0000000; Sun, 15 Jul 2007 18:14:52 -0400
In-Reply-To: <20070715212359.GB18293@efreet.light.src> (Jan Hudec's message of
	"Sun, 15 Jul 2007 23:23:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52592>

Jan Hudec <bulb@ucw.cz> writes:

> I apologise for nitpicking, but ISO 8601 (and RFC 3339) says separator between
> date and time is 'T' and there is no separator between time and timezone. So
> this should be
> ...
> ISO 8601 makes separators optional, so simple 4-digit timezone is OK.

My reading of 8601 was that it is allowed to drop [T] as long as
it is clear from the context by agreement between the parties
involved, although I admit the only copy I have handy is JIS
X0301 (2002), which is matching Japanese industrial standard
that consists of translation of ISO 8601 (2000) plus Japanese
"emperor's era" extensions.
