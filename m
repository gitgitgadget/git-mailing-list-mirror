From: Jeff King <peff@peff.net>
Subject: testing vger handling of charsets (part 1)
Date: Tue, 15 May 2007 03:12:05 -0400
Message-ID: <20070515test.1@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kha@treskal.com, peff@peff.net, bfields@fieldses.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 09:12:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnrCg-0001a9-R7
	for gcvg-git@gmane.org; Tue, 15 May 2007 09:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbXEOHMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 03:12:08 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbXEOHMI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 03:12:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3083 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754566AbXEOHMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 03:12:07 -0400
Received: (qmail 26461 invoked from network); 15 May 2007 07:12:07 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 15 May 2007 07:12:07 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 May 2007 03:12:05 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47321>

This is a test message to check how vger reacts to seeing 8bit
characters (like Hasselstr=C3=B6m) in a message without the right mime
header. Previous attempts were eaten by the list because of a lack of a
message id.

If your mail server doesn't advertise the 8BITMIME extensions, I expect
this message to be corrupted to iso8859-1 during the smtp conversation
between vger and your server, because it lacks a mime version header.
