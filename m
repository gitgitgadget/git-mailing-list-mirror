From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: msysGit and SCons: broken?
Date: Mon, 03 Aug 2009 20:19:47 +0200
Message-ID: <4A772A43.8070503@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY2kb-00048F-CQ
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbZHCS7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbZHCS7E
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:59:04 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:51113 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbZHCS7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:59:04 -0400
X-Greylist: delayed 2353 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2009 14:59:03 EDT
Received: from [84.176.70.72] (helo=[192.168.2.100])
	by smtprelay08.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MY28T-0004mz-1u
	for git@vger.kernel.org; Mon, 03 Aug 2009 20:19:49 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124717>

Hello,

I'm using Git for Windows (1.6.3.2.1299.gee46c) and *used to use* SCons
as a build tool. Since my last Git-update (from 1.6.1.9.g97c34 to
1.6.3.2.1299.gee46c) SCons doesn't work an longer. I'm not exactly sure
that the Git upgrade made things worse, but I didn't upgrade neither
SCons (0.98) nor Python (ActivePython 2.4) and now they cease to work.

When running in git-bash, SCons tells me "TypeError: listdir() argument
1 must be (buffer overflow), not str:" and some stack trace.

When running in native Windows' cmd.exe it works fine.

Is it somehow possible that the Git upgrade broke python scripts? By
setting certain ENV vars or something? I don't want to blame someone for
this, really, I'm just trying to track down my problem.


Dirk
