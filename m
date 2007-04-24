From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Ignore all man sections.
Date: Mon, 23 Apr 2007 20:02:34 -0400
Message-ID: <20070424000234.GA833@Hermes.local>
References: <462D4733.3000901@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 02:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8Xm-00005b-6f
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbXDXAEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030840AbXDXACm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:02:42 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43554 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030881AbXDXACg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:02:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 3AFEE1FFC023
	for <git@vger.kernel.org>; Tue, 24 Apr 2007 00:02:36 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <462D4733.3000901@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45386>

We added gitattributes(5), which should now be ignored.
While we're at it, ignore all man sections 1-8.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

On Apr 23, 2007, at 7:54 PM, H. Peter Anvin wrote:

> Brian Gernhardt wrote:
>> We now have a gitattributes(5) file, so let git ignore that just like
>> all the other man pages.
>> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
>
> We can't just add *.[1-8] to the list?
> 
> 	-hpa

Indeed we can.  But that would make sense.

 Documentation/.gitignore |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index b98d21e..a37b215 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -1,7 +1,6 @@
 *.xml
 *.html
-*.1
-*.7
+*.[1-8]
 *.made
 howto-index.txt
 doc.dep
-- 
1.5.2.rc0.1.g2cc31
