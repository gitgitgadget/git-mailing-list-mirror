From: Janne Kulmala <janne.t.kulmala@tut.fi>
Subject: git-svn clone fails
Date: Tue, 06 Apr 2010 12:28:37 +0300
Message-ID: <4BBAFEC5.6030103@tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Heikki Orsila <heikki.orsila@tut.fi>,
	Santtu Pajukanta <santtu.pajukanta@tut.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 11:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz5K3-0006is-Hl
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab0DFJnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 05:43:46 -0400
Received: from mail-gw2.cc.tut.fi ([130.230.160.16]:45148 "EHLO
	mail-gw2.cc.tut.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab0DFJnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 05:43:45 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2010 05:43:44 EDT
X-AuditID: 82e6a010-b7b09ae000007566-ca-4bbafecab081
Received: from mail1.tut.fi (mail1.tut.fi [130.230.162.19])
	by mail-gw2.cc.tut.fi (Symantec Brightmail Gateway) with SMTP id AE.58.30054.ACEFABB4; Tue,  6 Apr 2010 12:28:42 +0300 (EEST)
Received: from [130.230.36.120] (unknown [130.230.36.120])
	by mail1.tut.fi (Postfix) with ESMTP id 2AE2811FCAB;
	Tue,  6 Apr 2010 12:28:42 +0300 (EEST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144123>

I'm trying to clone OpenTTD subversion repository using git-svn from 
Debian Lenny testing. Git version is 1.7.0. The clone operationg always 
fails at the same revision with same error message.

I am using the following command:

	git svn clone svn://svn.openttd.org/trunk openttd

Which gives this error message:

r1170 = 12fbf791d6e353346315756bf46cbbf75a325833 (refs/remotes/git-svn)
Use of uninitialized value in concatenation (.) or string at 
/usr/lib/perl5/SVN/Core.pm line 584.

Network connection closed unexpectedly:  at /usr/lib/git-core/git-svn 
line 5047


Is this a Debian-specific problem, or a bug in git-svn?


Janne Kulmala
