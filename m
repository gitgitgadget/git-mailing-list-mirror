From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
Date: Sat, 4 Sep 2010 23:01:52 +0100
Message-ID: <20100904220152.GB20444@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <201009042333.51419.agruen@suse.de> <20100904214527.GA20444@n2100.arm.linux.org.uk> <201009042346.11787.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bug-patch@gnu.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: linux-sh-owner@vger.kernel.org Sun Sep 05 00:03:21 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1Os0pT-0007ro-TB
	for glps-linuxsh-dev@lo.gmane.org; Sun, 05 Sep 2010 00:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab0IDWDT (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Sat, 4 Sep 2010 18:03:19 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54103 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0IDWDS (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Sat, 4 Sep 2010 18:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
	Sender; bh=8vL/ViLHpn9jtyQNdm7et/9wxmO6+RmRkgxeUi0EB/0=; b=M+1/m
	cBECBQFJHJ6YePYcB1QWaEgWPmHVhl+MLqT607jDSFF5yhrmzTVFd3HyZ5+GtqQy
	GUgz97PfCDxYh5dK4t2fp4raV0MXY+8TSXmv/Kje3DbC620UslqYkbsA+ZbvY4ay
	xm/dyNSIYfvbXGiahsaZ+VquFb7TcWouxTy2Z4=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1Os0o6-0007gL-Qf; Sat, 04 Sep 2010 23:01:55 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1Os0o5-0006NM-10; Sat, 04 Sep 2010 23:01:53 +0100
Content-Disposition: inline
In-Reply-To: <201009042346.11787.agruen@suse.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155366>

On Sat, Sep 04, 2010 at 11:46:11PM +0200, Andreas Gruenbacher wrote:
> On Saturday 04 September 2010 23:45:27 Russell King - ARM Linux wrote:
> > It also makes them incompatible with GNU patch, whether or not GNU patch
> > understands the GIT headers.
> 
> Aha?  Then why do you think GNU patch tries to understand the GIt patch 
> headers?  So that it can be incompatible with GIT?

Read what you said last time around.  "In this case, the patch itself is
broken."

So, because GNU patch doesn't understand the patch file, the patch file
must be broken?  No, the patch file is fine with GIT which can apply it
correctly, but incompatible with GNU patch because of the way GNU patch
works (as you yourself said, GNU patch doesn't keep the intermediate
states.)

I repeat - if you want maximum compatibility, want GNU patch to be able
to apply the patch with or without --dry-run, then don't use -C or -M
when generating patches with git.

Simples.
