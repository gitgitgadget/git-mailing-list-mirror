From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Fri, 25 Sep 2009 23:21:15 +0200
Message-ID: <200909252321.16600.robin.rosenberg.lists@dewire.com>
References: <891180.68852.qm@web27805.mail.ukl.yahoo.com> <4ABCE640.6060102@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Struberg <struberg@yahoo.de>,
	Douglas Campos <douglas@theros.info>,
	Shawn Spearce <spearce@spearce.org>, git@vger.kernel.org
To: Michael Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:21:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIEH-0002db-64
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbZIYVVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbZIYVVP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:21:15 -0400
Received: from mail.dewire.com ([83.140.172.130]:15840 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbZIYVVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 17:21:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 32D15147DB2B;
	Fri, 25 Sep 2009 23:21:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sAOt3nCX-5QL; Fri, 25 Sep 2009 23:21:17 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 69CA3139D880;
	Fri, 25 Sep 2009 23:21:17 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4ABCE640.6060102@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129116>

fredag 25 september 2009 17:48:16 skrev Michael Gaffney <mr.gaffo@gmail.com>:
> My only real item is that I'd like to have the .* eclipse projects added 
> to gitignore so I'm not having to constantly stash mine off to the side 
> if I make changes.

Is that so hard? Without Git it's a problem since other tools don't have stash. If you
constantly have your own settings you risk making your changes incompatible
with the official settings in various ways, like different formatting, compiler settings
and so on. If you still want different settings --assume-unchanged may help
somewhat.

-- robin
