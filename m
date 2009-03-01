From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jgit and ignore
Date: Sun, 1 Mar 2009 21:47:25 +0100
Message-ID: <200903012147.26590.robin.rosenberg.lists@dewire.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com> <49AA9A05.6010404@gmail.com> <9e4733910903010631p51f9d4a7xddf9d823ff848bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>,
	"Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdtEm-0005VA-Qw
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754652AbZCAV2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbZCAV2t
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:28:49 -0500
Received: from mail.dewire.com ([83.140.172.130]:22662 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbZCAV2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:28:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 61E23147EAB2;
	Sun,  1 Mar 2009 22:28:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jg6dkx1gD2S1; Sun,  1 Mar 2009 22:28:45 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 31632147EA1A;
	Sun,  1 Mar 2009 22:28:45 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <9e4733910903010631p51f9d4a7xddf9d823ff848bde@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111877>

Jon Smirl writes:
> My .git got created in my workspace root. Is there ever a case where
> you would want .git in your workspace root? If not, remove this choice
> when the parent directory is the workspace root.

Sure there is. If you create your projects in the workspace, and in particular,
directly beneath the workspace root, having the .git directory there is a logical 
choice. I generally try to create the projects outside the workspace, but Eclipse
seems keen on creating projects in the workspace, but that is just my personal
preferences and partly for historical reasons.

-- robin
