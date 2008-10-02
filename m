From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] archive.c: make archiver static
Date: Thu, 02 Oct 2008 19:14:33 +0900
Message-ID: <20081002191433.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:16:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLEc-0007Bl-PY
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYJBKPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbYJBKPA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:15:00 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41930 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbYJBKO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:14:59 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 1E27EC7B30;
	Thu,  2 Oct 2008 05:14:58 -0500 (CDT)
Received: from 6138.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 2BZKEEJQM8Y7; Thu, 02 Oct 2008 05:14:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=XzuC/F2ds8S9fabNaG96uc/fnqiutjWIkNv5UlXa188luhjqATbp5eIoSOrwPxMtjpyY5EkQcLZQ5gjXzAniRbl/SVL7Pld2J1okbCGFMXyy5Qdz/TmRp6ul+8fqF8UvS/lfpPUXNHBep9PLYcWK6uwjggBbZkSW2U7ipqDOFxk=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97308>

This variable is not used anywhere outside.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 archive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index e2280df..44ab008 100644
--- a/archive.c
+++ b/archive.c
@@ -15,7 +15,7 @@ static char const * const archive_usage[] = {
 
 #define USES_ZLIB_COMPRESSION 1
 
-const struct archiver {
+static const struct archiver {
 	const char *name;
 	write_archive_fn_t write_archive;
 	unsigned int flags;
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
