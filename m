X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: doc bug?
Date: Fri, 08 Dec 2006 18:07:43 +0100
Message-ID: <elc64k$t4i$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 17:08:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33707>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsjCy-00052T-KS for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425948AbWLHRID (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 12:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425923AbWLHRIB
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:08:01 -0500
Received: from main.gmane.org ([80.91.229.2]:59948 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426022AbWLHRH7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 12:07:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GsjCP-0007nI-At for git@vger.kernel.org; Fri, 08 Dec 2006 18:07:49 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 08 Dec 2006 18:07:49 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006 18:07:49
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hi,

while messing with GIT's build system, I got

**
asciidoc -b docbook -d manpage -f ../Documentation/asciidoc.conf ../Documentation/git-tools.txt
ERROR: git-tools.txt: line 2: malformed manpage title
ERROR: git-tools.txt: line 6: first section must be named NAME
ERROR: git-tools.txt: line 9: malformed NAME section body
FAILED: /home/lilydev/vc/git/Documentation/git-tools.txt: line 9: unexpected error:
------------------------------------------------------------
Traceback (most recent call last):
  File "/usr/bin/asciidoc", line 3639, in asciidoc
    document.translate()
  File "/usr/bin/asciidoc", line 966, in translate
    Header.translate()
  File "/usr/bin/asciidoc", line 1123, in translate
    attrs['manname'] = string.strip(mo.group('manname'))
AttributeError: 'NoneType' object has no attribute 'group'
------------------------------------------------------------
**

is this a new problem?  I'm on FC6, with  asciidoc 7.0.2


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
