From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 01:16:37 +0200
Organization: Dewire
Message-ID: <200606040116.38036.robin.rosenberg.lists@dewire.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com> <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Keith Packard" <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 01:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmfMN-0007Gh-B9
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 01:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWFCXQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWFCXQm
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 19:16:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25152 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751825AbWFCXQl
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 19:16:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 71E5A80264B;
	Sun,  4 Jun 2006 01:15:27 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31138-07; Sun,  4 Jun 2006 01:15:27 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 1CA60802640;
	Sun,  4 Jun 2006 01:15:25 +0200 (CEST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21231>

fredag 02 juni 2006 06:16 skrev Martin Langhoff:
> On 6/2/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > It is going to have to be native Windows to move some of the
> > developers over. They are true blue MS types that won't touch anything
> > close to Unix so cygwin is out.
That could be fixed with nice packaging since many CVS users in Windows
never use a command line anyway since TortoiseCVS is so nice. 

> As others have pointed out, you have git-cvsserver which emulates a
> CVS server on top of GIT, so it can be used with (almost any) CVS
> client. They will be 2nd class citizens however...

(Yet) Another problem is that many windows tools use CR LF as the line ending.
Almost all windows editors default to CRLF and some detect existing line 
endings. No editing with notepad anymore. Of course that is a problem 
regardless of whether a git or cvs client is used. You'll get these big 
everything-changed commits that alter between CRLF and LF.

-- robin
