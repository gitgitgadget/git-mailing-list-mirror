From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 13/13] Add Python support library for remote helpers
Date: Thu, 05 Nov 2009 08:55:01 +0100
Message-ID: <200911050855.01164.johan@herland.net>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
 <1257364098-1685-14-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xBX-0007IC-Qd
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 08:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbZKEHzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 02:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbZKEHzA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 02:55:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61113 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754610AbZKEHy7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 02:54:59 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSM0077MLZQVP40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 05 Nov 2009 08:55:02 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSM00KVVLZPVM40@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 05 Nov 2009 08:55:02 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.5.74217
User-Agent: KMail/1.12.2 (Linux/2.6.31-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <1257364098-1685-14-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132208>

On Wednesday 04 November 2009, Sverre Rabbelier wrote:
> This patch introduces parts of a Python package called
> "git_remote_helpers" containing the building blocks for
> python helper.
> The actual remote helpers itself are NOT part of this patch.
> 
> The patch includes the necessary Makefile additions to build and install
> the git_remote_cvs Python package along with the rest of Git.

There are a few typos in the above. How about:

  This patch introduces parts of a Python package called
  "git_remote_helpers" containing the building blocks for
  remote helpers written in Python.
  No actual remote helpers are part of this patch, the patch
  only includes the common basics needed to start writing such
  helpers.

> The patch includes the necessary Makefile additions to build and install
> the git_remote_cvs Python package along with the rest of Git.

s/git_remote_cvs/git_remote_helpers/

> This patch is based on Johan Herland's git_remote_cvs patch and
> has been improved by the following contributions:
> - David Aguilar: Lots of Python coding style fixes
> - David Aguilar: DESTDIR support in Makefile
> 
> Cc: David Aguilar <davvid@gmail.com>
> Cc: Johan Herland <johan@herland.net>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---

Otherwise it all looks good. Nice work!


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
