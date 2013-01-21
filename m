From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] git-for-each-ref.txt: 'raw' is a supported date format
Date: Mon, 21 Jan 2013 16:22:06 +0000
Message-ID: <20130121162206.GG7498@serenity.lan>
References: <d3a288a67867d7a60c9217a78bda42301392c3da.1358776352.git.john@keeping.me.uk>
 <50FD66AC.1080201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 17:22:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxK8t-0001Bn-3t
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab3AUQWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 11:22:18 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42613 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab3AUQWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 11:22:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id E76761FC46;
	Mon, 21 Jan 2013 16:22:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zIcv8+0D8SzR; Mon, 21 Jan 2013 16:22:16 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id C6BB722F79;
	Mon, 21 Jan 2013 16:22:13 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 95453161E575;
	Mon, 21 Jan 2013 16:22:13 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcBIaVgfQZj0; Mon, 21 Jan 2013 16:22:13 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B499D161E4FB;
	Mon, 21 Jan 2013 16:22:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <50FD66AC.1080201@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214128>

Commit 7dff9b3 (Support 'raw' date format) added a raw date format.
Update the git-for-each-ref documentation to include this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Mon, Jan 21, 2013 at 05:02:52PM +0100, Michael Haggerty wrote:
> Shouldn't "raw" be preceded with a colon like the other format specifiers?

Yes it should.  Thanks.

 Documentation/git-for-each-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index db55a4e..d3e1df7 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -117,7 +117,7 @@ returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
 the date by adding one of `:default`, `:relative`, `:short`, `:local`,
-`:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
+`:iso8601`, `:rfc2822` or `:raw` to the end of the fieldname; e.g.
 `%(taggerdate:relative)`.
 
 
-- 
1.8.1.353.gc992d5a.dirty
