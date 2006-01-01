From: Olaf Hering <olh@suse.de>
Subject: how to find outstanding patches in non-linux-2.6 repositories?
Date: Sun, 1 Jan 2006 21:01:21 +0100
Message-ID: <20060101200121.GA20633@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-From: git-owner@vger.kernel.org Sun Jan 01 21:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Et9On-0005xQ-V9
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 21:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWAAUBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 15:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWAAUBY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 15:01:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:45493 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932251AbWAAUBX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 15:01:23 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 9DAA1E98D
	for <git@vger.kernel.org>; Sun,  1 Jan 2006 21:01:22 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14128>


How do I get a list of commits in the 'powerpc' tree, which are not part
of the 'linux-2.6' tree? The git tutorial has a section 'Working with
Others', but the examples dont work for me. Probably because
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git has
no info that it is not the "mainline tree".
All I need is a list of individual commits in that tree, which are not
(yet) in "mainline". I could get them also from the ozlabs mailing
lists, for the few patches I need. But it would be better if there is
some sort of automated way to extract a list of differences between two
trees.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
