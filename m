From: Jack Moore <jhmoore719@verizon.net>
Subject: Building documentation on an isolated network
Date: Sat, 08 May 2010 01:24:16 -0700
Message-ID: <393FB43C-317F-4CCB-980F-F56D1126C50F@verizon.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jack Moore <jhmoore719@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 10:24:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAfKr-0000UE-Tu
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 10:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab0EHIY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 04:24:28 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:46676 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0EHIY1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 04:24:27 -0400
Received: from [192.168.1.102] ([unknown] [173.58.219.82])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L23004LOE0G5C80@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 08 May 2010 03:24:17 -0500 (CDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146649>

I'm trying to setup a git repository on an isolated (not connected to the internet) network.  The repository is to be accessed by several developers on their own workstations (all running RHEL 5).  I have got git to build and install the executable with no problem, but when I try to build the documentation is runs into problems with ASCIIDOC.  I found an ASCIIDOC rpm for version 8.x.  I think ASCIIDOC is looking for some standard DTDs.  Does anyone have suggestions?