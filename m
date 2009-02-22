From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Add "compare with index" action.
Date: Sun, 22 Feb 2009 17:38:39 +0100
Message-ID: <200902221738.40753.robin.rosenberg.lists@dewire.com>
References: <499E67CD.9020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:04:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHks-0000K3-6I
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZBVRDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 12:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbZBVRDI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:03:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:25552 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbZBVRDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 12:03:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F22EB147E871;
	Sun, 22 Feb 2009 18:02:59 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OyUIGODpZ2Zi; Sun, 22 Feb 2009 18:02:59 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 552AAA149A4;
	Sun, 22 Feb 2009 18:02:59 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <499E67CD.9020501@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111021>

fredag 20 februari 2009 09:20:29 skrev Yann Simon <yann.simon.fr@gmail.com>:
> In the Compare With... menu, the "compare with index" action opens
> a diff editor that compares the workspace version of a file and its
> index version.

The appearance in the menu is a bit odd. "Compare with" is already in the menu 
context as that is the name of the menu that hold the Compare with index. So the 
menu name should be really be just "Git Index".

> The local file can be modified and saved.
>
> The staged version can be modified and saved. This updates the index.
> For this, add methods into GitIndex to allow to specify a content
> different from the file.

One would expect this feature to work at any level of the project, not just files. That
won't be a showstopper though.

-- robin
