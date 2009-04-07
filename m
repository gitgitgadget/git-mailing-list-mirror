From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/5] making upstream branch information accessible
Date: Tue, 7 Apr 2009 03:02:54 -0400
Message-ID: <20090407070254.GA2870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 09:05:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5Mi-0001sr-Sy
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbZDGHDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbZDGHDG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:03:06 -0400
Received: from peff.net ([208.65.91.99]:38169 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbZDGHDF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:03:05 -0400
Received: (qmail 32686 invoked by uid 107); 7 Apr 2009 07:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:02:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:02:54 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115908>

Here are slightly more cleaned-up versions of patches I've thrown out in
the last few days. The aim is to make the information on
upstream/tracking relationships more accessible both to scripts and to
users.

  1/5: for-each-ref: refactor get_short_ref function
  2/5: for-each-ref: refactor refname handling

    Cleanup for 3/5.

  3/5: for-each-ref: add "upstream" format field

    Plumbing support.

  4/5: make get_short_ref a public function

    Clean up for 4/5. Builds on 1/5.

  5/5: branch: show upstream branch when double verbose

-Peff
