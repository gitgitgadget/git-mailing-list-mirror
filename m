From: Jeff King <peff@peff.net>
Subject: testing vger handling of charsets (part 2)
Date: Tue, 15 May 2007 03:13:40 -0400
Message-ID: <20070515test.2@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kha@treskal.com, peff@peff.net, bfields@fieldses.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 09:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnrEh-0001tO-Ax
	for gcvg-git@gmane.org; Tue, 15 May 2007 09:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866AbXEOHNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 03:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbXEOHNn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 03:13:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3089 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866AbXEOHNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 03:13:42 -0400
Received: (qmail 26494 invoked from network); 15 May 2007 07:13:42 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 15 May 2007 07:13:42 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 May 2007 03:13:40 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47322>

This is a test message to check how vger reacts to seeing 8bit
characters (like Hasselstr=C3=B6m) in a message _with_ the right mime
header.

If your mail server doesn't advertise the 8BITMIME extensions, I expect
this message to come through OK, since vger will (hopefully) respect th=
e
existing content-type header. Karl and Bruce, can you please report?
