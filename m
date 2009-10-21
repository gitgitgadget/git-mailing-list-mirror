From: Nasser Grainawi <nasser@codeaurora.org>
Subject: [PATCH] Document the delta attribute
Date: Wed, 21 Oct 2009 11:11:42 -0600
Organization: Code Aurora Forum
Message-ID: <4ADF40CE.2060007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0eix-0002ag-SE
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZJURLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbZJURLj
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:11:39 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:33009 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbZJURLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:11:38 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5778"; a="25764950"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 21 Oct 2009 10:11:43 -0700
Received: from [129.46.10.111] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E180210004C8
	for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:15:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130939>

After spending a bit of time searching through the pack-objects source
I figured a small blurb of text documenting the existence of this attribute
would be useful.

Feel free to enhance/improve/correct the text.

Nasser

Signed-off-by: Nasser Grainawi <nasser@codeaurora.org>
---
  Documentation/gitattributes.txt |   10 ++++++++++
  1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1195e83..132e7b3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -577,6 +577,16 @@ If this attribute is not set or has an invalid value, the 
value of the
  (See linkgit:git-config[1]).


+Packing objects
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`delta`
+^^^^^^^^^^
+
+Delta compression will not be attempted for files and directories with
+the attribute `delta` unset.
+
+
  USING ATTRIBUTE MACROS
  ----------------------

-- 
1.6.5
