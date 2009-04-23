From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Thu, 23 Apr 2009 22:26:21 +0200
Message-ID: <200904232226.22240.robin.rosenberg@dewire.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904232119.36707.robin.rosenberg@dewire.com> <49F0CCF4.20808@pelagic.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Blewitt <alex@bandlem.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx5Wr-00089G-En
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbZDWU0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbZDWU0Z
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 16:26:25 -0400
Received: from mail.dewire.com ([83.140.172.130]:22567 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbZDWU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 16:26:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B4C0C14A8B21;
	Thu, 23 Apr 2009 22:26:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tq0c5fKrfAai; Thu, 23 Apr 2009 22:26:23 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6E17B14A8B20;
	Thu, 23 Apr 2009 22:26:23 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <49F0CCF4.20808@pelagic.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117381>

torsdag 23 april 2009 22:17:56 skrev "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>:
> while we're on the subject...
> how about also adding the reverse: when a file is ignored then add it to
> the .gitignore file for 'un-ignoring' (the '!' pattern)

I'm not convinced each and everything should have a menu entry. Advanced
use of .gitignore should have a .gitignore editor. When we have that the
option could perhaps launch the editor automatically if it recognized no-trivial ignore rules. For trivial cases it would just append to the file.

-- robin
