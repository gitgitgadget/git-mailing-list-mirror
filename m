From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: Using git with Eclipse
Date: Tue, 11 Dec 2007 10:14:49 -0500
Message-ID: <20071211101449.uqnyht2e8kcc00ww@intranet.digizenstudio.com>
References: <475DC0CE.9070109@saville.com>
	<20071211024442.GJ14735@spearce.org> <475E265D.5090106@saville.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26pL-00055K-Sj
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXLKPOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbXLKPOx
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:14:53 -0500
Received: from k2smtpout04-02.prod.mesa1.secureserver.net ([64.202.189.173]:50392
	"HELO k2smtpout04-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753890AbXLKPOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 10:14:51 -0500
Received: (qmail 1118 invoked from network); 11 Dec 2007 15:14:50 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-02.prod.mesa1.secureserver.net (64.202.189.173) with ESMTP; 11 Dec 2007 15:14:50 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id B4FBF100A37;
	Tue, 11 Dec 2007 15:14:50 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 089uyH52G5rO; Tue, 11 Dec 2007 10:14:50 -0500 (EST)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 01FFD100B4A; Tue, 11 Dec 2007 10:14:50 -0500 (EST)
Received: from mailrelay2.private.geico.com (mailrelay2.private.geico.com
	[205.143.204.198]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Tue, 11 Dec 2007 10:14:49 -0500
In-Reply-To: <475E265D.5090106@saville.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67870>


Quoting Wink Saville <wink@saville.com>:

> Shawn,
> I added .metadata to exclude then used git rm to remove
> .metadata from the repository. I then cloned that
> repository to see how Eclipse would work. (As part of  my
> workflow I use git as a backup so I wanted to see what would
> happen when I "restored".)

One way to deal with this might be (after excluding it from the  
workspace repository) creating a sub-repository under .metadata, and  
use that one for your local backup.

> As I'm sure you know with the metadata gone my existing projects
> in the Ui were gone and they have to be recreated as well as
> some Eclipse and plugin specific configuration.
> I understand you and others are working on an Eclipse plugin
> for git, will it also ignore . metadata?
>
> Do you need any testing done or is it too early? I'd be glad to
> test if you feel its solid enough that I won't lose data or if it
> uses a separate different repo then I could use both.

Egit is an Eclipse plugin, so you can always test it in an isolated  
"sandbox" workspace.

Cheers.
-- 
Jing Xue
