From: Cornelius <c.r1@gmx.de>
Subject: Bug report - git show <tagname> together with --pretty=format
Date: Wed, 08 Apr 2009 14:56:39 +0200
Message-ID: <49DC9F07.4090105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 14:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrXMF-0008NH-BZ
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 14:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764079AbZDHM4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 08:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761953AbZDHM4n
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 08:56:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:59796 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756919AbZDHM4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 08:56:42 -0400
Received: (qmail invoked by alias); 08 Apr 2009 12:56:40 -0000
Received: from p54A4DDCF.dip.t-dialin.net (EHLO [192.168.2.29]) [84.164.221.207]
  by mail.gmx.net (mp024) with SMTP; 08 Apr 2009 14:56:40 +0200
X-Authenticated: #26239675
X-Provags-ID: V01U2FsdGVkX1+yU0g5h3iyi1ThbEVjWOOC23xuOD1HavdH6aSkdw
	C0K9tvbZdPSuOm
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116081>

Hi,
I've a problem with git 1.6.2.2 (self compiled) and git show. I use it's 
output for parsing the git data, so this is more than a minor issue for 
me. When you normally do a git show on a tag name it's output resembles 
the following:
tag <tagname>
Tagger: Cornelius <c.r1@gmx.de>
Date:   Wed Apr 8 14:39:17 2009 +0200


tagmessage
commit 77e312e0527f87604e4c70ebf6040e79bb55d2ed
<snip>

Now when you do a git show <tagname> 
--pretty=format:"ENDOFGITTAGOUTPUTMESAGEHERE%n%H" --
the Date: line is missing. Git 1.6.0.5 (which is avaible in my distro's 
repos) doesn't have this issue. Please CC me, I'm not subcribed here.
Cornelius
