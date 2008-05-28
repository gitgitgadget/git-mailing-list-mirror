From: =?UTF-8?Q?Nikola_Kne=C5=BEevi=C4=87?= <nikkne@gmx.ch>
Subject: Repository usage
Date: Wed, 28 May 2008 23:51:20 +0200
Message-ID: <21512C1E-EEA3-43C1-9099-78563B64DC44@gmx.ch>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 23:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1TZR-00086B-Sv
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 23:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYE1Vv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 17:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYE1Vv1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 17:51:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:51815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753046AbYE1Vv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 17:51:26 -0400
Received: (qmail invoked by alias); 28 May 2008 21:51:24 -0000
Received: from zue-tix-ull-dynip-182-253.vtx.ch (EHLO hunin.home) [144.85.182.253]
  by mail.gmx.net (mp015) with SMTP; 28 May 2008 23:51:24 +0200
X-Authenticated: #18658533
X-Provags-ID: V01U2FsdGVkX1+8iI8Qa4K8lOp+Sr0TuEQUwxKatikmj989gsm3/n
	D+yAig8fZPpKBT
X-Mailer: Apple Mail (2.919.2)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83139>

Hi all,
I have a question related on how to use VCS's, and git in particular.

So, the situation is this:
we were using project called Mace (framework for building dist.  
systems). Up until 1yr ago, it was a monolithic project, contained in  
one SVN repository. We build a lot of changes on top of original code,  
but we never synchronized with the main repository. Then, the  
developers decided to split the repository into 2 parts - public and  
private. They also switched to CMake, so it was possible to use cmake  
to build both public and private part in one invocation (although they  
were in separate directories). IHMO, their idea was quite stupid!  
Since we now need to synchronize with their code, I don't know what to  
do... Our code relies on parts of public and private, and build order  
is also important, so I can't update only one part.

Before I describe what I need, if I use /\ for set intersection, and  
\/ for union, situation is like this:
public/\private = mostly makefiles, public\/private == old mace

Since I need both parts, their complete union, and I need to update to  
latest code (a lot of performance&bug fixes is there), I thought to  
use git-svn to create one branch for public, one for private, and then  
merge both to the same branch. Both public and private contain the  
same layout, but there are different files in directories. Is this  
even possible? Is there any better solution?

Thanks, and sorry if I've missed the right mailing list...
Nikola
