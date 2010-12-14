From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Referring to other repositories
Date: Tue, 14 Dec 2010 08:58:25 +0300
Message-ID: <20101214055825.GJ3264@localhost.localdomain>
References: <loom.20101214T011043-268@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Tue Dec 14 06:58:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSNuK-0003Zl-Qf
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 06:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291Ab0LNF6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 00:58:35 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:57339 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0LNF6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 00:58:34 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBE5wQuA021958;
	Tue, 14 Dec 2010 08:58:27 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 1E76EB2009A; Tue, 14 Dec 2010 08:58:26 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <loom.20101214T011043-268@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163629>

On Tue, Dec 14, 2010 at 01:03:20AM +0000, Maaartin wrote:

> I'm using multiple repositories corresponding to different projects. Currently, 
> all the projects reside in different subdirectories of the same directory, like
> work/A
> work/B
> work/C
> There are some dependencies like B and C depending on A.
[...]
> I know about git submodule, however IIUIC it needs the other project to become 
> a subdirectory of the master, but I can hardly make A to subdirectory of both B 
> and C (I'm a poor Windows user, so no symlinks).
[...]
> So it looks like using submodules is no option, but I hope you tell me that I'm 
> wrong.
Windows supports directory-only symlinks on NTFS >= 3.0 (starting with
Windows 2000, that is), see [1], and it seems that since Vista there are
true symlinks (did not have a chance to use them yet).
I'm not sure if msysgit will play nicely with them, but at least you
could try.

[...]

1. http://en.wikipedia.org/wiki/NTFS_junction_point
