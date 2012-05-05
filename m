From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: how to restrict git to specific non-root superuser
Date: Fri, 04 May 2012 20:48:20 -0500
Message-ID: <jo20t5$e8n$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 03:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQU76-0003Ho-1P
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 03:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409Ab2EEBsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 21:48:36 -0400
Received: from plane.gmane.org ([80.91.229.3]:49532 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924Ab2EEBsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 21:48:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SQU6q-00038K-Qc
	for git@vger.kernel.org; Sat, 05 May 2012 03:48:32 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2012 03:48:32 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2012 03:48:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197086>

I work on systems where 'everyone' has the root password (that problem 
is somewhat out of my hands).  Is there a technique to setup git so that 
only a certain non-root superuser (ie, gittech) is allowed to run git 
commands?  I don't want people logged in as root to mess up the git repos.

I'm considering using git for deployment and some anonymous root user 
messing it up would be a very, very, bad thing.  Maybe this proposition 
is theoretically impossible.  Maybe someone has implemented this concept 
in practice.

v/r,
neal
