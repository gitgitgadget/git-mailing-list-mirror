From: Len Brown <len.brown@intel.com>
Subject: fatal: git-write-tree: not able to write tree
Date: Fri, 28 Apr 2006 04:30:33 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200604280430.33100.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 28 10:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZOLl-00040O-Gd
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 10:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWD1I3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 04:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWD1I3O
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 04:29:14 -0400
Received: from fmr18.intel.com ([134.134.136.17]:9404 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030356AbWD1I3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 04:29:14 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3S8TDHe018275
	for <git@vger.kernel.org>; Fri, 28 Apr 2006 08:29:13 GMT
Received: from orsmsxvs040.amr.corp.intel.com ([192.168.65.206])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k3S8TD17002120
	for <git@vger.kernel.org>; Fri, 28 Apr 2006 08:29:13 GMT
Received: from toshiba.site ([10.127.52.196])
 by orsmsxvs040.amr.corp.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006042801291103930
 for <git@vger.kernel.org>; Fri, 28 Apr 2006 01:29:12 -0700
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.52 on 10.7.209.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19269>

I'm trying to  use git-am to apply a patch series in a mailbox.

The first patch has a conflict, which I edit to fix, and and then invoke
git am --3way --interactive --signoff --utf8 --resolved

but it bails out with this:

drivers/acpi/thermal.c: unmerged (4829f067a3e7acfbeed8b230caac00b1ed4b8554)
drivers/acpi/thermal.c: unmerged (528d198c28512af1627cce481575f37a599c0fe8)
drivers/acpi/thermal.c: unmerged (db3bef1a3e51801128e7553f3e546c8272cc9ee1)
fatal: git-write-tree: not able to write tree

I've tried various incantations of git reset on the theory that there is some 
old state hanging around someplace, but have not been able to check in this 
file.

clues?

thanks,
-Len
