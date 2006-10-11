From: Pazu <pazu@pazu.com.br>
Subject: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Wed, 11 Oct 2006 18:13:59 -0300
Message-ID: <egjmri$atp$1@sea.gmane.org>
References: <20061011172553.GA1147@linux-mips.org> <egjang$nmh$1@sea.gmane.org> <egjllu$6k8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 23:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXlYD-00027d-Jy
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161503AbWJKVUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbWJKVUN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:20:13 -0400
Received: from main.gmane.org ([80.91.229.2]:11695 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161495AbWJKVUG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 17:20:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXlUH-00010S-54
	for git@vger.kernel.org; Wed, 11 Oct 2006 23:19:37 +0200
Received: from 201.37.98.50 ([201.37.98.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 23:19:36 +0200
Received: from pazu by 201.37.98.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 23:19:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 201.37.98.50
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <egjllu$6k8$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28749>

The XML declaration forces IE6 into quirks mode, breaking our
nice standards compliant stylesheet.
Signed-off-by: Marcus Brito <pazu@pazu.com.br>
---
  gitweb/gitweb.perl |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0ec1eef..ecb3b66 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1357,7 +1357,6 @@ sub git_header_html {
     print $cgi->header(-type=>$content_type, -charset => 'utf-8',
                        -status=> $status, -expires => $expires);
     print <<EOF;
-<?xml version="1.0" encoding="utf-8"?>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
  <!-- git web interface version $version, (C) 2005-2006, Kay Sievers 
<kay.sievers\@vrfy.org>, Christian Gierke -->
-- 
1.4.2.3
