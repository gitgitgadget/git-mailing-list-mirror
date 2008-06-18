From: injoin <injoin.injoin@gmail.com>
Subject: [git-p4] log problem
Date: Wed, 18 Jun 2008 06:07:32 +0000 (UTC)
Message-ID: <loom.20080618T054324-772@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 08:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8qss-0006IJ-DJ
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 08:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847AbYFRGKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 02:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758889AbYFRGKI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 02:10:08 -0400
Received: from main.gmane.org ([80.91.229.2]:53947 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941AbYFRGKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 02:10:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K8qrq-0007nc-4O
	for git@vger.kernel.org; Wed, 18 Jun 2008 06:10:03 +0000
Received: from hcfw.mstarsemi.com ([59.120.57.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 06:10:02 +0000
Received: from injoin.injoin by hcfw.mstarsemi.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 06:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 59.120.57.250 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/2.0.0.8;MEGAUPLOAD 1.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85363>

`p4 describes 114996' shows something like this:

Change 114996 by puma@injoin.injoin on 2008/06/18 12:11:24

	fix buffer overflow.

Affected files ...


//puma/Trunk/lib/string/map.c#47 edit


But `git log' shows
Author: puma <puma@p4_server>
Date:   Wed Jun 18 12:11:24 2008 +0800

    fix buffer overflow.

    [git-p4: depot-paths = "//puma/Trunk/": change = 114996]

The Author field in all logs shows puma <puma@p4_server>
All of the programmers use the perforce username 'puma' but use a different
clientspec. How can I configure git-p4 to use puma@injoin.injoin as the Author
rather than puma?

Thank you.
