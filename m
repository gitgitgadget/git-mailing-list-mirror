From: Matthias Kestenholz <lists@spinlock.ch>
Subject: (At first sight) unexpected git-diff behavior
Date: Sat, 27 Jan 2007 09:42:13 +0100
Message-ID: <1169887333.19364.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 09:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAj96-0004Fo-6A
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbXA0Imp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 03:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbXA0Imp
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:42:45 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:53365 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbXA0Imo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 03:42:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 80E7462C058
	for <git@vger.kernel.org>; Sat, 27 Jan 2007 09:42:32 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04978-01 for <git@vger.kernel.org>;
	Sat, 27 Jan 2007 09:42:30 +0100 (CET)
Received: from [192.168.1.7] (93.117.78.83.cust.bluewin.ch [83.78.117.93])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 053E862C016
	for <git@vger.kernel.org>; Sat, 27 Jan 2007 09:42:30 +0100 (CET)
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37934>

Hello,

I often specify revision ranges when I need a diff, because I find it
easier to see what is diffed against what:

git diff v1.5.0-rc0..v1.5.0-rc1

Today I tried to do the same to get a diff between linux v2.6.11 (which
is a tag for a tree object) and v2.6.12:

$ git diff v2.6.11..v2.6.12
error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a
commit
fatal: Invalid revision range v2.6.11..v2.6.12

Of course, git diff v2.6.11 v2.6.12 works as it should.

I am not sure if git diff should be able to work with tree objects in
revision ranges (which does not really make sense).

Thoughts?
