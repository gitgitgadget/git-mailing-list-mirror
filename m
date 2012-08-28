From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 0/4] GSOC: prepare svndump for branch detection
Date: Tue, 28 Aug 2012 11:15:00 +0200
Message-ID: <1346145304-27149-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 11:15:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HtT-0002xi-Kf
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 11:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab2H1JPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 05:15:19 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34395 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2H1JPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 05:15:18 -0400
Received: by bkwj10 with SMTP id j10so1542990bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0aPwmhhIQNrbnLisdXbUmhy8zK+vumHNrOU3ymLXbsY=;
        b=AJ7kJJa07U82nVNxVW3IZklZcg6bYFit6k3CiuBRIbAfhDrVlsgmy1Foy752TDPrve
         9sglgbGcwqVSA9bRdYMwuSbRFT3GEq4meawMMQArU/kcLnfFA9YOWP2wl5MuTPZt6lWR
         BrPu2nL7R5FhOP4128vTwnrhje1Fja26IYsuYhmk/4saeQAoa8QwPxqq29q7b9Yi6G/y
         pYdQtpBF5AK4jLbkgZ3VzDg4/o+G5OBqs7DXK8LPgAeYqMEn+icXP2BLmUAoRmHxkizX
         Mkqdj8vo7rxYCtvxDEwWdiqh5o2B3ZZyKlZXFAobV2fF223ndv1GYkxEnZHm16JHQGG+
         AkNw==
Received: by 10.204.133.193 with SMTP id g1mr4557537bkt.2.1346145317258;
        Tue, 28 Aug 2012 02:15:17 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id c18sm12120186bkv.8.2012.08.28.02.15.14
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 02:15:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204419>

Includes a small fixup by Ramsey:
Improves integer type compatibility on different platforms.
svndump.c:
- replace %lu by PRIuMAX in printf format string.
- cast lhs of cast operator to uintmax_t

[RFC v2 1/4] svndump: move struct definitions to .h
[RFC v2 2/4] vcs-svn/svndump: restructure node_ctx, rev_ctx handling
[RFC v2 3/4] vcs-svn/svndump: rewrite handle_node(),
[RFC v2 4/4] vcs-svn: remove repo_tree
