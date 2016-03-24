From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] api-parse-options.txt: document OPT_CMDMODE()
Date: Thu, 24 Mar 2016 09:07:01 +0000
Message-ID: <01020153a7e08100-cf66fc9f-7293-4d8c-98c6-f322721c741f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 10:07:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj1ET-0001AI-AA
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 10:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbcCXJHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 05:07:04 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:42777
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbcCXJHD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 05:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458810421;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=7dt6UwE+1PBSvlNTLSrVcO7kz4gaMPhn6kCp3y0atUE=;
	b=Iil4QbhS1xE3QWx/ZG+cEU179rsSxcueYErOyyEcznqdatgzbaIB+tE/boZoVTCG
	vHgJurG46fol+FPBqmwroZCl7NcPvXSSolw5jPBqGsaPgkyOzOjc6XN2VIsgqRI85P2
	E2KrlkIBVgNBoP5VYzXWxBpUA9JF4gA+9NUac2fY=
X-SES-Outgoing: 2016.03.24-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289726>

OPT_CMDMODE() was introduced in the release of 1.8.5 which makes the use
of subcommands in the form of arguments a lot cleaner and easier.
---
 Documentation/technical/api-parse-options.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5f0757d..8130d26 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -231,6 +231,12 @@ There are some macros to easily define options:
 	pass the command-line option, which can be specified multiple times,
 	to another command.
 
+`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
+	Introduce an option for subcommands. It is useful when you want to use
+	the command with a particular sub command only and ignore other sub
+	commands it has. It will set `int_var` to enum_val if the argument is
+	invoked.
+
 
 The last element of the array must be `OPT_END()`.
 

--
https://github.com/git/git/pull/219
