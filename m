From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/3] Improve difftool --dir-diff tests
Date: Fri, 22 Mar 2013 19:36:30 +0000
Message-ID: <cover.1363980749.git.john@keeping.me.uk>
References: <20130322115352.GI2283@serenity.lan>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 20:37:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ7mF-0002gv-9e
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 20:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143Ab3CVTgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 15:36:52 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:50051 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab3CVTgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 15:36:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3073319800E;
	Fri, 22 Mar 2013 19:36:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tk6DxA1Ff58; Fri, 22 Mar 2013 19:36:50 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id AD0AC198010;
	Fri, 22 Mar 2013 19:36:40 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.324.ga64ebd9
In-Reply-To: <20130322115352.GI2283@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218837>

How about doing this?

The first patch is a cleanup as suggested by Johannes[1], the second
fixes the test failure on Windows and the third makes the test behaviour
more explicit and would have helped to detect this issue earlier.

  [1/3] t7800: don't hide grep output
  [2/3] t7800: fix tests when difftool uses --no-symlinks
  [3/3] t7800: run --dir-diff tests with and without symlinks

 t/t7800-difftool.sh | 71 +++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

-- 
1.8.2.324.ga64ebd9
