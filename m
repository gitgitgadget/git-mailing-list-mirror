From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sun, 10 Jun 2007 15:19:00 -0700
Message-ID: <7vzm375u7f.fsf@assigned-by-dhcp.cox.net>
References: <11813427591137-git-send-email-krh@redhat.com>
	<7v7iqdf0gn.fsf@assigned-by-dhcp.cox.net>
	<20070610221306.GF27340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVkY-00047r-Ns
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102AbXFJWTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758760AbXFJWTE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:19:04 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34754 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758102AbXFJWTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:19:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610221902.YBDZ18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 18:19:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9yK01X00R1kojtg0000000; Sun, 10 Jun 2007 18:19:01 -0400
In-Reply-To: <20070610221306.GF27340@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 10 Jun 2007 18:13:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49781>

Jeff King <peff@peff.net> writes:

> This is the same git-send-email bug that we fixed recently (missing
> MIME-Version header). Just look for the vger "we munged your message"
> headers in the version you received.

Ahh.  You are right.  The message does have these:

        X-Warning: Original message contained 8-bit characters, however during
                   the SMTP transport session the receiving system did not announce
                   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
                   message does not have MIME headers (RFC 2045-2049) to enable
                   encoding change, we had very little choice.
        X-Warning: We ASSUME it is less harmful to add the MIME headers, and
                   convert the text to Quoted-Printable, than not to do so,
                   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
        X-Warning: We don't know what character set the user used, thus we had to
                   write these MIME-headers with our local system default value.
