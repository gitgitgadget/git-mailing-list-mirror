From: Pierre Habouzit <madcoder@debian.org>
Subject: Use strbufs in commit.c (pretty printing)
Date: Sat,  8 Sep 2007 13:53:16 +0200
Message-ID: <11892523992761-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 13:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITysU-0006v1-Fb
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 13:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbXIHLxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 07:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXIHLxW
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 07:53:22 -0400
Received: from pan.madism.org ([88.191.52.104]:57491 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXIHLxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 07:53:20 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E27D01E6A1
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 27133101FD3; Sat,  8 Sep 2007 13:53:19 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <20070902224213.GB431@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58122>

  Here is a 3 patch series to use strbufs for the pretty printing
functions in commit.c.

  * The first one adds a needed useful function to strbufs (rtrim).
  * The second one changes the semantics of interpolate (as the third
    will need that) and fixes the rest of the code accordingly.
  * Do the change.

  Testsuite passes after step 2 and 3.
