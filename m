From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 05:24:38 +0100
Message-ID: <20070320042438.GA31795@hermes.lan.home.vilz.de>
References: <1174361424.3143.42.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:51:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTWK3-0005b4-8x
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933083AbXCTEvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933993AbXCTEvo
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:51:44 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:3198 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933083AbXCTEvn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2007 00:51:43 -0400
X-Greylist: delayed 1633 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Mar 2007 00:51:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 877DB3E82;
	Tue, 20 Mar 2007 05:24:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1R6zifr8WL0l; Tue, 20 Mar 2007 05:24:27 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id A135E3E5C;
	Tue, 20 Mar 2007 05:24:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1174361424.3143.42.camel@dv>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42706>

On Mon, Mar 19, 2007 at 11:30:24PM -0400, Pavel Roskin wrote:
> Hello!
> 
> I don't know where this problem appeared, but it present in the current
> git (1.5.1-rc1).  Empty files become invalid objects in the repository:
> 
> $ touch file 
> $ git-init
> Initialized empty Git repository in .git/
> $ git-add file
> $ git-commit -m "first commit"
> Created initial commit 16a476808d3cb0a4758997ba58193a9dcfad0fd8
> error: garbage at end of loose object
> 'e69de29bb2d1d6434b8b29ae775ad8c2e48c5391'
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file
> $

I get the following after the last command:

Created initial commit a0e02efbe85ee1c1f4b8ba703ccae2f4e64e6ed0
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file

I use git version 1.5.1.rc1.595.gd1206 on a current gentoo system
(Portage 2.1.2.2 (default-linux/amd64/2006.1/desktop, gcc-4.1.2,
glibc-2.5-r1, 2.6.20-gentoo-r3 x86_64)) with a not so current portage 
tree (Timestamp of tree: Sat, 17 Mar 2007 12:00:01 +0000).

in a few hours, i can test that on ppc32 arch, too, if you like.

Regards,
Nicolas Vilz
