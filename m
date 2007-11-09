From: Brian Dessent <brian@dessent.net>
Subject: Re: linux-2.6 clone with CygWin git
Date: Fri, 09 Nov 2007 13:24:53 -0800
Organization: My own little world...
Message-ID: <4734D025.B08B725B@dessent.net>
References: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Medve Emilian <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 22:25:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqbLn-0005OT-Lw
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 22:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbXKIVY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbXKIVY6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 16:24:58 -0500
Received: from dessent.net ([69.60.119.225]:60285 "EHLO dessent.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbXKIVY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 16:24:58 -0500
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1IqbLR-00073U-Re; Fri, 09 Nov 2007 21:24:53 +0000
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64261>


[ Please note, it's spelled "Cygwin" not "CygWin". ]

Medve Emilian wrote:

> Can somebody please double-check this scenario for me just to validate
> that this happens only due to some particular factors combination on my
> box?

As others have pointed out, this is not a git issue -- you'd have run
into the same problem with a simple tarball of the kernel source because
of the filesystem case insensitivity.  Cygwin provides managed mounts to
work around this Win32 limitation, at the cost of non-Cygwin apps seeing
uglified filenames and a decreased effective maximum path length due to
the mangling.

Brian
