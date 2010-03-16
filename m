From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 00/15] Portability Patches v3
Date: Tue, 16 Mar 2010 05:42:20 +0000
Message-ID: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiV-0002vN-LP
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935302Ab0CPFxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:05 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64505 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab0CPFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:55 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 23EAF5CC7
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:18 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 23EAF5CC7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 156B1DE5;
	Tue, 16 Mar 2010 05:42:56 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id E7D7111D4D5; Tue, 16 Mar 2010 05:42:55 +0000 (UTC)
User-Agent: quilt/0.46-1
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142308>

Here are the portability patches we needed at TWW to enable
git-1.7.0.2 to compile and run on all of the wide range of Unix
machines we support.  These patches apply to the git-1.7.0.2 release,
and address all of the feedback from the previous two times I posted
them to this list, most particularly splitting everything into many
small self-contained chunks.

Note that I have not invested the time to figure out why the testsuite
is mostly useless on everything but Linux and Solaris 8+, because I'm
reasonably satisfied that the build itself is working properly.  Most
likely, it is merely GNUisms in the way the test cases call external
tools.  But maybe I'm missing something, but even the 3 new patches to
address test errors when diff does not support the -u option don't
improve the testsuite situation on HPUX, AIX, OSF1 and Solaris 7 and
older.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
