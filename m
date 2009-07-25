From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: (unknown)
Date: Sat, 25 Jul 2009 09:28:50 +0900
Message-ID: <20090725092850.6117@nanako3.lavabit.com>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net>
	<1248470504-16326-2-git-send-email-alex@chmrr.net>
	<1248470504-16326-3-git-send-email-alex@chmrr.net>
	<20090725071105.6117@nanako3.lavabit.com>
	<7v1vo5647j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alex Vandiver <alex@chmrr.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUV8K-0004gB-Nz
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbZGYA24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 20:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbZGYA24
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:28:56 -0400
Received: from karen.lavabit.com ([72.249.41.33]:32864 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbZGYA2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:28:55 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 78BD011B7E0;
	Fri, 24 Jul 2009 19:28:55 -0500 (CDT)
Received: from 6848.lavabit.com (190-14-246-42.ip.mediacommerce.com.co [190.14.246.42])
	by lavabit.com with ESMTP id NRLQCZBUF3H3; Fri, 24 Jul 2009 19:28:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ri3ecWUVYThREXeqQMGjIc3hUT8lcYr9MftzVABCD0JXikldsdYa4MUqNQQ4Xq/OAxnO7/ytjS3u5dblTbx85hD0vhzSOTvWwzdWGIwVGPaxb2jWvQ58/nw/ZdeNu1VpfIifLkdHXJScQWiqyZRkXPkY2FvN1fnVWImsc5iXqeY=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Subject: 
In-Reply-To: <7v1vo5647j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123984>

Subject: [PATCH] Documentation/config.txt: a variable can be defined on the section header line

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 Quoting Junio C Hamano <gitster@pobox.com>:

 > Nanako Shiraishi <nanako3@lavabit.com> writes:
 >
 >> Isn't this a syntax error?
 >>
 >> Documentation/config.txt says this.
 >
 > Even if it were, I think it would be nice to allow it.  I'll have to
 > re-read Alex's patch, but I thought it was sane.  Perhaps we can update
 > the documentation, mildly hinting that it is allowed without encouraging
 > it too strongly, as I think it is a good style to have these on separate
 > lines.
 
 How about this small update to the documentation, then?

 Documentation/config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6857d2f..c6f09f8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -49,7 +49,8 @@ There is also a case insensitive alternative `[section.subsection]` syntax.
 In this syntax, subsection names follow the same restrictions as for section
 names.
 
-All the other lines are recognized as setting variables, in the form
+All the other lines (and the remainder of the line after the section
+header) are recognized as setting variables, in the form
 'name = value'.  If there is no equal sign on the line, the entire line
 is taken as 'name' and the variable is recognized as boolean "true".
 The variable names are case-insensitive and only alphanumeric

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
