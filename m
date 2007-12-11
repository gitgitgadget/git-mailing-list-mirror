From: Jeff King <peff@peff.net>
Subject: [RFH] leading dots in manpages
Date: Tue, 11 Dec 2007 07:42:21 -0500
Message-ID: <20071211124220.GA17929@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 13:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24S0-0006Ok-VC
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXLKMmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXLKMmZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:42:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3750 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbXLKMmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:42:23 -0500
Received: (qmail 13755 invoked by uid 111); 11 Dec 2007 12:42:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Dec 2007 07:42:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 07:42:21 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67846>

The git-shortlog manpage has a "files" section that mentions ".mailmap".
Asciidoc correctly renders this in the HTML version, but in the manpage,
the line that should say ".mailmap" is omitted. This seems to be caused
by the line

.mailmap::

being misinterpreted somewhere (though the .xml file looks reasonable).

It looks like the same problem as 7c8b5eaf, but we just dodged the
problem there. Is there an actual fix?

-Peff
