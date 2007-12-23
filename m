From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Sun, 23 Dec 2007 21:14:03 +0100
Message-ID: <476EC18B.6080808@s5r6.in-berlin.de>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org> <alpine.LFD.0.9999.0712230701520.14863@localhost.localdomain> <476E50DC.1040701@garzik.org> <alpine.LFD.0.9999.0712230715490.15596@localhost.localdomain> <476E5CFC.5070301@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
	Jeff Garzik <jeff@garzik.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Dieter Ries <clip3@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 23 21:14:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6XDm-0007gn-Vx
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 21:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbXLWUO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 15:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbXLWUO0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 15:14:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:44220 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbXLWUOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 15:14:25 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] (k5.avc-online.de [83.221.230.29])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id lBNKE4OV024412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 23 Dec 2007 21:14:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071216 SeaMonkey/1.1.7
In-Reply-To: <476E5CFC.5070301@gmx.de>
X-Enigmail-Version: 0.95.3
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69197>

Dieter Ries wrote:
> Robert P. J. Day schrieb:
>> when i got started with git, what i really wanted
>> was a list of what i (as a simple, non-developer user) could do once i
>> cloned a repository.
>>
>> to that end, i put together my own little reference list of git
>> commands.  for example, i collected ways to examine my repository --
>> git commands like branch, tag, log/shortlog, what-changed, show, grep,
>> blame, that sort of thing.  exactly the kind of stuff a new user might
>> want to know about, even without the ability to change anything.
> 
> Could you perhaps publish your reference list as kind of a christmas
> gift to all basic users like me?

Here are three out of four things which I do frequently with git repos:
I look at

  - commits and blobs in other people's trees with gitweb,

  - commits in a local tree with gitk,

  - specific changes to source code with qgit, using it as "git blame"
    GUI.

(The fourth thing is feeding a driver subsystem git tree at kernel.org
using a minimum number of git commands.  Everything else which I do with
git I do so infrequently that I have to reread manuals all the time.)
-- 
Stefan Richter
-=====-=-=== ==-- =-===
http://arcgraph.de/sr/
