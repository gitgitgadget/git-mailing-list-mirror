From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run, rejected without (Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Sat, 4 Sep 2010 23:33:51 +0200
Organization: SUSE Labs
Message-ID: <201009042333.51419.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <20100903193309.GC29821@pengutronix.de> <20100904000348.GA7498@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	"Uwe =?iso-8859-1?q?Kleine-K=F6nig?=" 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Jean-Christophe PLAGNIOL-VILLARD" <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
To: bug-patch@gnu.org
X-From: git-owner@vger.kernel.org Sat Sep 04 23:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0Sf-0000rw-5H
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 23:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0IDVjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 17:39:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58256 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab0IDVjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 17:39:41 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 94A0F79727;
	Sat,  4 Sep 2010 23:39:40 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.31.12-0.2-desktop; KDE/4.3.5; i686; ; )
In-Reply-To: <20100904000348.GA7498@n2100.arm.linux.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155362>

On Saturday 04 September 2010 02:03:48 Russell King - ARM Linux wrote:
> As I say, it's because GNU patch doesn't (currently) understand GIT
> patches.  I wouldn't call that a bug in GNU patch.

GNU patch in the version used does understand GIT patch headers and does 
support things like renames.

The --dry-run option often will not work when the same file is modified more 
than once in the same patch, though.  This is because GNU patch doesn't 
remember the intermediary states of files.

In this case, the patch itself is broken.

Andreas
