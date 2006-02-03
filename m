From: Jason Harrison <jharrison@linuxbs.org>
Subject: git-svnimport
Date: Fri, 3 Feb 2006 14:29:07 -0500
Organization: Linux Bahamas
Message-ID: <200602031429.07894.jharrison@linuxbs.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Feb 03 20:29:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F56cm-0008Gd-Kt
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 20:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914AbWBCT32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 14:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbWBCT32
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 14:29:28 -0500
Received: from mail1.securehost.com ([24.244.140.102]:58638 "EHLO
	mail1.securehost.com") by vger.kernel.org with ESMTP
	id S1945914AbWBCT30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 14:29:26 -0500
Received: from [172.16.60.242] (a24-244-140-15.maxil.com [24.244.140.15])
	by mail1.securehost.com (8.10.2/8.10.2) with ESMTP id k13JTAc14799
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 14:29:10 -0500
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15541>

Greetings,

I am trying to import from an svn repository into a git repository using 
git-svnimport.  So far my attempts have failed.  Here is what I have done so 
far.

git-svnimport svn://svn.debian.org/demi/

### Snippet ###
73: Unrecognized path: /demi.sql
73: Unrecognized path: /lib/dsa.py
74: Unrecognized path: /bin/add-demi-machine
cp: cannot stat `/home/jharrison/svn/demi.git/.git/refs/heads/origin': No such 
file or directory
fatal: master: not a valid SHA1
usage: git-read-tree (<sha> | -m [-u | -i] <sha1> [<sha2> [<sha3>]])
checkout failed: 256

git-svnimport -T demi svn://svn.debian.org/demi/

### Snippet ###
73: Unrecognized path: /web/machine.py
73: Unrecognized path: /lib/demi.py
73: Unrecognized path: /lib/dsa.py
74: Unrecognized path: /bin/add-demi-machine

Thanks for your time.

Regards,
Jason
