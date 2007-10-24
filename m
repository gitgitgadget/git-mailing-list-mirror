From: Pierre Habouzit <madcoder@debian.org>
Subject: Small enhancements of the test-lib.sh
Date: Wed, 24 Oct 2007 22:03:37 +0200
Message-ID: <1193256219-24222-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 24 22:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkmSJ-00020N-Gc
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbXJXUDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbXJXUDp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:03:45 -0400
Received: from pan.madism.org ([88.191.52.104]:44521 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbXJXUDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:03:44 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EFE4A26BA0;
	Wed, 24 Oct 2007 22:03:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7240631B2C9; Wed, 24 Oct 2007 22:03:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.1343.gf9b40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62231>

  Here is a 2-patch series to enhance the test-suite so that the flood
is easier to follow to the eye.

  The first patch is a rework of the previous one I sent, and implements
suggestions that were made to me.

  The second add a --quiet option that basically stops the flood about
all the test that just pass, and only let the name of the master
t####foo.sh script be printed, and the summary of its test (and the
occasional spurious outputs the testsuite does).

  This "series" is available as ph/testlib on my
git://git.madism.org/git.git

Cheers,
