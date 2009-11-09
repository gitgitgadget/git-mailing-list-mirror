From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/24] diff --no-index: make the usage string less scary
Date: Mon,  9 Nov 2009 09:05:04 -0600
Message-ID: <1257779104-23884-24-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfG-0002nn-4H
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbZKIOz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756037AbZKIOz5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:57 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbZKIOzx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:53 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pygPdbJIlhoT9IybD9naB1ZFYMXr+Lalv2HV2dMerNU=;
        b=Nk4rINRo2OGYCBFswpPapgNu9c+DRc+n+/Jul2ShZ3oZpdJc9T2rDRrbvTZagIbebV
         /OTAH8ELDuON13KG4pEwAckVnpTSkhHZH9XagerSiw7qk+MRf9dHq8W6JHqM9GK/IvZ7
         1FBYyq9gObMriJtuTd5P9FO2AIcHMMfskst7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hxFB81NIK9kwr5DXjqf0hBVK0VW1qzRP/zUo1p1rRm/2nR1e2uxMwTO8wN37+UA6on
         +ykpj+pYKeyEgoNCf+zv3+aHP5htNRm/9CAEJV2xIKKCRjabNnZKC4gH3PyErMkV50ja
         RKH8knYxFZai/c+Jceg0jtXC/MghiHXSbFeao=
Received: by 10.216.85.69 with SMTP id t47mr2572752wee.107.1257778558488;
        Mon, 09 Nov 2009 06:55:58 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:57 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132477>

Start the diff --no-index usage string with "usage:" instead of
"fatal:".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff-no-index.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 4ebc1db..a1f6fdf 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -201,7 +201,7 @@ void diff_no_index(struct rev_info *revs,
 			return;
 	}
 	if (argc != i + 2)
-		die("git diff %s takes two paths",
+		usage("git diff %s <path> <path>",
 		    no_index ? "--no-index" : "[--no-index]");
 
 	diff_setup(&revs->diffopt);
-- 
1.6.5.2
