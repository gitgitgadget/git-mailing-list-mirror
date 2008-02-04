From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Add a BuildRequires for gettext in the spec file.
Date: Mon, 4 Feb 2008 08:13:07 -0500
Message-ID: <20080204131303.GA31656@spitfire.yyz.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 04 14:14:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM19T-0006Kb-L4
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 14:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbYBDNNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 08:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbYBDNNk
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 08:13:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbYBDNNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 08:13:40 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m14DD8GD031494;
	Mon, 4 Feb 2008 08:13:09 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m14DD86Y031933;
	Mon, 4 Feb 2008 08:13:08 -0500
Received: from spitfire (dhcp-10-15-16-111.yyz.redhat.com [10.15.16.111])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m14DD7EP011940;
	Mon, 4 Feb 2008 08:13:08 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72502>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 git.spec.in |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 659f058..3f9f888 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -8,7 +8,7 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
-BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
+BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 
 Requires:	git-core = %{version}-%{release}
@@ -181,6 +181,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/technical}
 
 %changelog
+* Sun Feb 03 2008 James Bowes <jbowes@dangerouslyinc.com>
+- Add a BuildRequires for gettext
+
 * Fri Jan 11 2008 Junio C Hamano <gitster@pobox.com>
 - Include gitk message files
 
-- 
1.5.4.1134.ge34cf
