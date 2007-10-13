From: Mike Sharov <msharov@softhome.net>
Subject: [bug] gitk can not read history if diff color is enabled
Date: Sat, 13 Oct 2007 10:18:18 -0400
Message-ID: <4710D3AA.8000502@softhome.net>
Reply-To: msharov@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 16:31:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igi17-0008Cg-3v
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbXJMOaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 10:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXJMOaq
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:30:46 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:60361 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXJMOap (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 10:30:45 -0400
X-Greylist: delayed 746 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Oct 2007 10:30:45 EDT
Received: from [192.168.1.3] (c-68-32-115-135.hsd1.md.comcast.net[68.32.115.135])
          by comcast.net (sccrmhc12) with ESMTP
          id <2007101314181801200fs0a5e>; Sat, 13 Oct 2007 14:18:18 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070907 SeaMonkey/1.1.4
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Reproduced in git version 1.5.3.4.217.gbfc1, although it's been this way
for a while. To see the bug, enable color diff with

[diff]
color

and launch gitk on any repository (like the Linux kernel tree). The
result is a dialog box "Can't parse git log output '\x1b[33mcommit" etc.
qgit can still view the history without errors, so I guess it must be
possible to somehow turn off color for a specific query.
-- 
Mike
msharov@users.sourceforge.net
