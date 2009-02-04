From: Adam Thorsen <adam.thorsen@gmail.com>
Subject: Re: segfault during clone via http
Date: Wed, 4 Feb 2009 18:35:39 +0000 (UTC)
Message-ID: <loom.20090204T183407-350@post.gmane.org>
References: <loom.20090204T160827-822@post.gmane.org> <76718490902041000x3cda2390t25254e8372c9af50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 19:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmcf-00040i-Ej
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbZBDSfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbZBDSfv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:35:51 -0500
Received: from main.gmane.org ([80.91.229.2]:59333 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469AbZBDSfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:35:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LUmbE-0006RG-9g
	for git@vger.kernel.org; Wed, 04 Feb 2009 18:35:49 +0000
Received: from c-71-204-175-47.hsd1.ca.comcast.net ([71.204.175.47])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 18:35:48 +0000
Received: from adam.thorsen by c-71-204-175-47.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 18:35:48 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.204.175.47 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.6) Gecko/2009011912 Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108407>


Here is the stack trace:

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_INVALID_ADDRESS at address: 0x00494000
0x0015bb04 in multi_runsingle ()
(gdb) bt
#0  0x0015bb04 in multi_runsingle ()
#1  0x0015d5af in curl_multi_perform ()
#2  0x000b8782 in step_active_slots () at http.c:450
#3  0x000b881c in run_active_slot (slot=0x50a450) at http.c:474
#4  0x000bac5c in fetch (walker=0x5008d0, 
sha1=0x4a791c "?u^?9l?\003?5??#??X\"?XL") at http-walker.c:846
