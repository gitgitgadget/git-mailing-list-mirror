From: Petr Sebor <petr@scssoft.com>
Subject: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 14:10:42 +0200
Organization: SCS Software
Message-ID: <44E5AE42.6090506@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 18 14:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE3C5-0006Ih-43
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 14:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWHRMKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 08:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWHRMKk
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 08:10:40 -0400
Received: from opteron.scssoft.com ([85.207.19.51]:63643 "EHLO
	opteron.scssoft.com") by vger.kernel.org with ESMTP
	id S1030308AbWHRMKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 08:10:39 -0400
Received: from [IPv6:2001:6f8:12f6:1:211:9ff:fec1:49c7] (donkey.scssoft.com [IPv6:2001:6f8:12f6:1:211:9ff:fec1:49c7])
	by opteron.scssoft.com (Postfix) with ESMTP id CA1055566DA
	for <git@vger.kernel.org>; Fri, 18 Aug 2006 14:10:37 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25653>

Hello,

has anyone noticed that the 'git diff' output somehow lacks the newline 
after the @@ tag?

The linux-kernel list is full of diffs whose hunks begin like:

@@ -1475,6 +1475,7 @@ int do_coredump(long signr, int exit_cod

@@ -1516,22 +1517,34 @@ int do_coredump(long signr, int exit_cod

@@ -1428,7 +1442,7 @@ static int elf_core_dump(long signr, str

instead of:

@@ -1475,6 +1475,7 @@
 int do_coredump(long signr, int exit_cod

@@ -1516,22 +1517,34 @@
 int do_coredump(long signr, int exit_cod

@@ -1428,7 +1442,7 @@
 static int elf_core_dump(long signr, str


It is not only a problem of the linux-kernel, my local git installation 
suffers from this as well...

Regards
Petr
