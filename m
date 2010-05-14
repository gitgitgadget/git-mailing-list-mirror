From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 00/18] Portability patches for git-1.7.1
Date: Fri, 14 May 2010 09:31:31 +0000
Message-ID: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:37:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrKe-0001PH-VC
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682Ab0ENJhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:37:22 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64438 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab0ENJhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:37:21 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 3430D5C0C
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:54:13 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 3430D5C0C
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id EBE78CD2;
	Fri, 14 May 2010 09:37:20 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id C9D0211D4D1; Fri, 14 May 2010 09:37:20 +0000 (UTC)
User-Agent: quilt/0.46-1
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147058>

Momentum appears to have stalled on this portability patch set, but
I received a lot of great feed back on restructuring and tweaking, the
results of which follow. If there's anything else I can do to help the
adoption of some or all of these patches into upstream please don't
hesitate to ask.  There are no new changes in this v5 patchset, and
the additional 2 patches in the series over the last submission is
purely an artifact of the restructuring based on feedback.

So, as I said before: Here are the portability patches we needed at
TWW to enable git-1.7.1 to compile and run on all of the wide range of
Unix machines we support.  These patches apply to the git-1.7.1
release,  and address all of the feedback from the previous four
times I posted them to this list.

With the exception of a hand-full of test failures outside of Linux
and Solaris8+, git now compiles and passes all tests on the following
architectures:

        Solaris 2.6/SPARC
        Solaris 7/SPARC
        Solaris 8/SPARC
        Solaris 9/SPARC
        Solaris 10/SPARC
        Solaris 10/Intel
        HP-UX 10.20/PA
        HP-UX 11.00/PA
        HP-UX 11.11/PA
        HP-UX 11.23/PA
        HP-UX 11.23/IA
        HP-UX 11.31/PA
        HP-UX 11.31/IA
        AIX 5.1
        AIX 5.2
        AIX 5.3
        AIX 6.1
        Tru64 UNIX 5.1
        IRIX 6.5
        RHEL 3/x86
        RHEL 3/amd64
        RHEL 4/x86
        RHEL 4/amd64
        RHEL 5/x86
        RHEL 5/amd64
        SLES 10/x86
        SLES 10/amd64

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
