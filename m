From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 0/4] More tests for hand-written configure (resend)
Date: Fri, 07 Jul 2006 18:25:13 +0200
Message-ID: <20060707162513.25746.57374.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 07 18:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FytA9-0000bA-Uq
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 18:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGGQ0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 12:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWGGQ0j
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 12:26:39 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:63158 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932196AbWGGQ0i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 12:26:38 -0400
Received: from leonov.stosberg.net (p213.54.86.102.tisdip.tiscali.de [213.54.86.102])
	by ncs.stosberg.net (Postfix) with ESMTP id CABE4AEBA004
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:28 +0200 (CEST)
Received: from leonov.stosberg.net (localhost [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id 9D33D1149B7
	for <git@vger.kernel.org>; Fri,  7 Jul 2006 18:26:35 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Second version of the additional tests.  Changes relative to
yesterdays's patches:

  -  Calls to the "which" command have been replaced by a shell
     function that Timo Hirvonen has written
  -  Paths to Perl and Python binaries can be given in an
     environment variable to prevent auto-detection.
  -  NO_PYTHON is set, if no suitable python can be found
  -  Fixes to make it run on Solaris.

Tested on Linux (bash, dash), Solaris 9 (sh) and NetBSD (sh/ash).

I noticed that the autoconf-based solution has replaced Pasky's
scripts in the pu branch.  Has a final decision been made?

I must admit that I'm less convinced today that a hand-written
configuration script is better than I was yesterday when I started
to write the tests.

Regards,
Dennis
