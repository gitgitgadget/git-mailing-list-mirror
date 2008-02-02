From: Adam Flott <adam@npjh.com>
Subject: man pages are littered with .ft C and others
Date: Sat, 2 Feb 2008 11:25:00 -0600 (CST)
Message-ID: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 18:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLM8B-0002XY-Cu
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 18:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbYBBRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 12:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbYBBRZc
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 12:25:32 -0500
Received: from npjh.com ([200.46.204.250]:61754 "EHLO npjh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbYBBRZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 12:25:31 -0500
Received: from localhost (unknown [200.46.204.191])
	by npjh.com (Postfix) with ESMTP id 668AC13517BD
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 17:25:30 +0000 (UTC)
Received: from npjh.com ([200.46.204.250])
 by localhost (mx1.hub.org [200.46.204.191]) (amavisd-maia, port 10024)
 with ESMTP id 97995-03 for <git@vger.kernel.org>;
 Sat,  2 Feb 2008 13:25:29 -0400 (AST)
Received: from an.sumeria (unknown [70.124.58.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by npjh.com (Postfix) with ESMTP id 9350813517AE
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 17:25:29 +0000 (UTC)
X-X-Sender: adam@an.sumeria
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72290>

I do remember at one point the man pages looking correctly (just tested
v1.5.3.8 and it shows the same problem). Therefore it is probably
some package I'm missing on my system.

And now, I see this scattered all over:

For example:

      .ft C
      $ git checkout master             \fB(1)\fR
      $ git checkout master~2 Makefile  \fB(2)\fR
      $ rm -f hello.c
      $ git checkout hello.c            \fB(3)\fR
      .ft

Seems that "------------" and <n>, and a few others aren't being
translated. Note: I'm not at all familiar with the layout of man pages
so I have no idea how to fix it or even diagnose it further.


Version info:
up to date Kubuntu 7.10

asciidoc/gutsy uptodate 8.2.1-2
docbook-dsssl/gutsy uptodate 1.79-4
docbook-utils/gutsy uptodate 0.6.14-1
docbook-xml/gutsy uptodate 4.5-4
docbook-xsl-doc-html/gutsy uptodate 1.72.0.dfsg.1-2
docbook-xsl/gutsy uptodate 1.72.0.dfsg.1-2
xmlto/gutsy uptodate 0.0.18-5.1build1


Anyone else seeing this?


Adam
