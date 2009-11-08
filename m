From: Kate Ebneter <kate@ning.com>
Subject: Strange behavior (possible bug) using bash command subsitution
 with "git branch"
Date: Sun, 08 Nov 2009 14:11:56 -0800
Message-ID: <C71C822C.22429%kate@ning.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 08 23:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GIn-0003M7-1e
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 23:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbZKHWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 17:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755587AbZKHWby
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 17:31:54 -0500
Received: from server107c.exghost.com ([207.97.244.178]:1152 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584AbZKHWbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 17:31:53 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2009 17:31:53 EST
X-Policy: GLOBAL - ning.com
X-Primary: kate@ning.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: kate@ning.com ALLOWED
X-Virus-Scan: V-
X-Note: Spam Tests Failed: 
X-Country-Path: UNITED STATES->UNITED STATES->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 207.97.230.106
X-Note-Reverse-DNS: fe08.exg3.exghost.com
X-Note-WHTLIST: kate@ning.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 120 121 122 123 127 128 139 225 
X-Note: Mail Class: ALLOWEDSENDER
X-Note: Headers Injected
Received: from [207.97.230.106] (HELO FE08.exg3.exghost.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 192547584 for git@vger.kernel.org; Sun, 08 Nov 2009 17:12:05 -0500
Received: from be32.exg3.exghost.com ([207.97.230.171]) by FE08.exg3.exghost.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 8 Nov 2009 17:11:58 -0500
Received: from 207.97.202.210 ([207.97.202.210]) by be32.exg3.exghost.com ([207.97.230.171]) via Exchange Front-End Server exg3.exghost.com ([207.97.230.162]) with Microsoft Exchange Server HTTP-DAV ;
 Sun,  8 Nov 2009 22:11:57 +0000
User-Agent: Microsoft-Entourage/11.4.0.080122
Thread-Topic: Strange behavior (possible bug) using bash command
 subsitution with "git branch"
Thread-Index: AcpgwHvFumg19syzEd6LBwAX8g2h+g==
X-OriginalArrivalTime: 08 Nov 2009 22:11:58.0254 (UTC) FILETIME=[7D1D4CE0:01CA60C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132423>

Hi, folks,

I ran into a weird situation while working on a script, which is best
described with a little snippet from my gitosis-admin repository:

    $ git branch
    * master
    $ branch=$(git branch)
    $ echo $branch
    gitosis.conf keydir master


That is, if you run 'git branch' inside $() or ``, it lists the directories,
too. I can't imagine that this is intended behavior, but perhaps I'm wrong.

I can reproduce this on CentOS, Ubuntu, Solaris, and Mac OS X using git
1.6.2.3, 1.6.3.2, 1.6.3.3, 1.6.4.2, and 1.6.5.2.

(In the end, I figured out a better way to write my script anyway, but this
is just too weird not to ask about.)

Thanks,
Kate Ebneter
Somewhat befuddled build engineer
