From: Brian Dessent <brian@dessent.net>
Subject: Re: shared lib+symlinks patch for cygwin
Date: Sun, 22 Jun 2008 01:10:31 -0700
Organization: My own little world...
Message-ID: <485E08F7.ADE2290C@dessent.net>
References: <6910a60806220056i1dda7f4elb4e5c69cdeea3cf9@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Reini Urban <rurban@x-ray.at>
X-From: git-owner@vger.kernel.org Sun Jun 22 10:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAKeM-0005GP-RY
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 10:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbYFVIIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 04:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbYFVIIi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 04:08:38 -0400
Received: from dessent.net ([69.60.119.225]:45451 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbYFVIIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 04:08:37 -0400
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1KAKch-00040y-LS; Sun, 22 Jun 2008 08:08:31 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85753>

Reini Urban wrote:

> esp. on cygwin where file hardlinks do not work as on linux.
> old bindir 5.8MB, new 2.7MB

Hard links work just fine on Cygwin, assuming the underlying volume is
NTFS.  What you probably mean to say is that the Cygwin setup.exe
program won't create hardlinks from the tarball when installing binary
packages.  But this could be worked around by creating the links with
'ln' in a postinstall script.  Then NTFS users would get the space
savings and FAT users would get copies.

Brian
