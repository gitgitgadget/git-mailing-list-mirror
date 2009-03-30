From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] Documentation: update graph api example.
Date: Mon, 30 Mar 2009 10:13:45 -0400
Message-ID: <20090330141344.GA6265@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 16:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoIGs-0001lB-N0
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 16:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbZC3ONx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 10:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbZC3ONx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 10:13:53 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:46732 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbZC3ONw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 10:13:52 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2594787wff.4
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=QYOVWSY7RkXNB8iyEEn3nuH0sqsund4+l4CsRJdTM+c=;
        b=bX0D6kUEgsdjtFWMz+75/Kv8d8RvHh8EPJCzXfQtbMPtxSzmopqD7g+BngVSt6rd/0
         vY0KmOafzqxk/hElaUFnhz04cJ0GC1XPsl7CRz8xK74SWVrXAtiGfoBT9B7sFrVhm7Se
         fbn7YpFlEkJHSb9nv+ZAHVaAH2htndn5T3fgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=QtF1DKVPY8Ecx0iX+HGngiI8yf9r6lUhsqa7OaUnVOT+m1uw/h48gX6a0RorhMwpPS
         l8qPnkt63gjs4BNRyF4GMbRbmmzy7CV6oo9GcxUEcmd6EduluK577pvqNuEcrJ9tzNYj
         H+trG/8JRvEpKhdg3FDX+3+DiEfwhwOA/7HtA=
Received: by 10.142.230.11 with SMTP id c11mr2142160wfh.219.1238422430674;
        Mon, 30 Mar 2009 07:13:50 -0700 (PDT)
Received: from linux.vnet (n2-55-108.dhcp.drexel.edu [144.118.55.108])
        by mx.google.com with ESMTPS id 20sm8684375wfi.32.2009.03.30.07.13.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 07:13:49 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115153>

As of commit 03300c0 the graph API uses '*' for all nodes including merges.
This updates the example in the documentation to match.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 Documentation/technical/api-history-graph.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index e955979..d66e61b 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -148,22 +148,22 @@ outputting that information, if desired.
 ------------
 *
 *
-M
+*
 |\
 * |
 | | *
 | \ \
 |  \ \
-M-. \ \
+*-. \ \
 |\ \ \ \
 | | * | |
 | | | | | *
 | | | | | *
-| | | | | M
+| | | | | *
 | | | | | |\
 | | | | | | *
 | * | | | | |
-| | | | | M  \
+| | | | | *  \
 | | | | | |\  |
 | | | | * | | |
 | | | | * | | |
-- 
1.5.4.3
