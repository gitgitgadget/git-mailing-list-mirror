From: Pierre Habouzit <madcoder@debian.org>
Subject: quote/strbuf series, take 3
Date: Thu, 20 Sep 2007 00:42:09 +0200
Message-ID: <1190241736-30449-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 20 00:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY8FW-00046y-1z
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 00:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbXISWmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbXISWmU
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 18:42:20 -0400
Received: from pan.madism.org ([88.191.52.104]:49151 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbXISWmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 18:42:18 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E1C491BF2E;
	Thu, 20 Sep 2007 00:42:16 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1AF244B14; Thu, 20 Sep 2007 00:42:16 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.2.1036.gccf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58740>

  Here is the take 3. wrt last time: the need for strbuf_addvf has been
avoided. It was not really needed for many places, and I chose ad-hoc
solutions for each. It has been done in a new patch (inserted at slot
2).

  Note that this patch 2/7 looks curious, especially the:

  write_fd_or_whine(..., "\n", 1, ...)

  it is rewritten in a following patch in the series, it's just to have
an intermediate working state. Don't really mind the bad look of it,
please :).


  As a consequence, strbuf_addvf is no longer added nor used in the
series.

  I just rebased it on the last next (with the new git-fetch).
