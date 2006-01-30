From: Jiri Netolicky <netolicky@epos.cd.cz>
Subject: Sync repository between NTB and WKS
Date: Mon, 30 Jan 2006 17:13:31 +0100
Message-ID: <43DE3B2B.2080303@epos.cd.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 30 17:14:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3bf4-0006r0-51
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 17:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWA3QNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 11:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWA3QNg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 11:13:36 -0500
Received: from ns.dmz.cd.cz ([81.19.46.20]:54168 "EHLO ns.dmz.cd.cz")
	by vger.kernel.org with ESMTP id S932358AbWA3QNe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 11:13:34 -0500
Received: from cd00000phant000.cd.cz ([81.19.46.66]) by ns.dmz.cd.cz with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 30 Jan 2006 17:13:33 +0100
Received: from cd00000phant000.cd.cz ([10.4.10.10]) by cd00000phant000.cd.cz with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 30 Jan 2006 17:13:32 +0100
Received: From epos.cd.cz ([10.28.12.43]) by cd00000phant000.cd.cz (WebShield SMTP v4.5 MR1a P0803.345);
	id 1138637612512; Mon, 30 Jan 2006 17:13:32 +0100
Received: (qmail 13817 invoked by uid 504); 30 Jan 2006 16:13:32 -0000
Received: from netolicky@epos.cd.cz by FQDN by uid 99 with qmail-scanner-1.20 
 ( Clear:RC:0(127.0.0.1):. 
 Processed in 0.030182 secs); 30 Jan 2006 16:13:32 -0000
Received: from localhost (HELO ?10.28.21.126?) (netolicky@127.0.0.1)
  by localhost with SMTP; 30 Jan 2006 16:13:31 -0000
User-Agent: Mail/News 1.5 (X11/20060113)
To: git@vger.kernel.org
X-OriginalArrivalTime: 30 Jan 2006 16:13:32.0918 (UTC) FILETIME=[1DB3F160:01C625B8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15280>

Have a nice day.

Can you advise me what is the best way
to synchronize repositories between
workstation and notebook? Now before I left office,
I synchronize repository between workstation
and notebook(blue-nb) as any other files by rsync:

rsync -avr . blue-nb:work/source/portal

and when I coming into the office
by the same way sync from NTB to WKS. It works
fine but I have not to forget syncing even
if I work on different sources.

Today I try on WKS repository

git-pull ssh://blue-nb/~netolish/work/source/portal

but the new branch I create on NTB during weekend
(and which is actual on NTB) is merged into
actual master branch. I hope that the new branch
will be created on WKS repository. What I am doing
wrong?.
This is my first experiments with git, so sorry for
beginners questions.

Jiri Netolicky aka Netolish
