From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: git over rsync+ssh
Date: Wed, 09 Jul 2008 16:01:18 +0200
Message-ID: <g52gbg$si9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 16:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGaFZ-00051Q-08
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 16:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYGIOBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 10:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbYGIOBa
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 10:01:30 -0400
Received: from main.gmane.org ([80.91.229.2]:49025 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbYGIOB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 10:01:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGaEa-00085r-II
	for git@vger.kernel.org; Wed, 09 Jul 2008 14:01:28 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 14:01:28 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 14:01:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87885>

I want to put a git repo on a server where I have ssh access but failed 
to compile git (AIX 5.1, has libz.a but no .so nor headers; compiling 
prerequisite zlib failed, probably due to a botched build environment).

As far as I can see my only option for a private repo is using rsync 
over ssh.

Alas, the rsync:// transport of git seems to imply an rsync daemon 
connection.

How can I specify rsync over ssh as the git transport?

Alternatively, can I maybe compile the bits that git over ssh needs on 
the server side without zlib?

Michael
