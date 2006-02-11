From: walt <wa1ter@myrealbox.com>
Subject: gitk: searching on filenames?
Date: Sat, 11 Feb 2006 07:42:32 -0800
Organization: git
Message-ID: <Pine.LNX.4.64.0602110729450.23279@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 11 16:43:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7wth-0002K6-J3
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 16:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWBKPmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 10:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWBKPmw
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 10:42:52 -0500
Received: from main.gmane.org ([80.91.229.2]:17793 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932325AbWBKPmv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 10:42:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1F7wtX-0002Hm-7V
	for git@vger.kernel.org; Sat, 11 Feb 2006 16:42:43 +0100
Received: from adsl-69-234-221-91.dsl.irvnca.pacbell.net ([69.234.221.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Feb 2006 16:42:43 +0100
Received: from wa1ter by adsl-69-234-221-91.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Feb 2006 16:42:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-221-91.dsl.irvnca.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15948>

A real example from this morning:  I noticed when pulling from
Linus that kernel/sched.c had been updated, so I wanted to look
at that particular commit.

If I do 'gitk kernel/sched.c' then it does what I expect.

But, if I just start gitk with no arguments and then attempt
to search for kernel/sched.c it eventually stops with an error
saying "can't find diffs for <SHA1> <SHA2>".

Is this the expected behavior?  (I have the 'Files' field
selected in the gitk search bar.)

Thanks!
