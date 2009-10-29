From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/7] Refactor git_remote_cvs to a more generic
 git_remote_helpers
Date: Thu, 29 Oct 2009 13:05:26 +0100
Message-ID: <200910291305.26523.johan@herland.net>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>
 <1256798426-21816-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 13:05:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3TlA-0004VT-67
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 13:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZJ2MFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 08:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbZJ2MFY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 08:05:24 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44842 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752839AbZJ2MFY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 08:05:24 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KS900D89YX3EW30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 29 Oct 2009 13:05:27 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KS900HR8YX3IB30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 29 Oct 2009 13:05:27 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.29.115425
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <1256798426-21816-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131585>

On Thursday 29 October 2009, Sverre Rabbelier wrote:
> This in an effort to allow future remote helpers written in python to
> re-use the non-cvs-specific code.
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> CC: Johan Herland <johan@herland.net>
> ---
> 
> 	As discussed with Johan Herland, refactored git_remote_cvs into a
> 	more reusable git_remote_helpers module.

It's hard to review this patch for a couple of reasons:

1. It's over 200K large, which causes it to be blocked by the Git mailing 
list (100K limit, I believe).

2. The patch renames some files, but instead of simply stating the rename, 
the patch lists the entire file twice (deletion + creation)

Fortunately, you can easily solve both problems by rerolling the patch with 
the -M flag to git-format-patch.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
