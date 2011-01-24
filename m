From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: cannot fetch arm git tree
Date: Mon, 24 Jan 2011 10:53:28 +0000
Message-ID: <20110124105328.GG16202@n2100.arm.linux.org.uk>
References: <20110116092315.GA27542@n2100.arm.linux.org.uk> <20110116110819.GG6917@pengutronix.de> <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com> <20110116134248.GD27542@n2100.arm.linux.org.uk> <4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de> <20110121135725.GR13235@n2100.arm.linux.org.uk> <4D3997FE.5030109@vollmann.ch> <20110121145025.GS13235@n2100.arm.linux.org.uk> <4D3D2865.4020408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jello huang <ruifeihuang@gmail.com>,
	Detlef Vollmann <dv@vollmann.ch>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 24 11:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhK3V-0002jD-2l
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 11:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab1AXKxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 05:53:45 -0500
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60738 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab1AXKxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 05:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
	h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=c5idy5rThBUCLX/CANz0POF1Ae4VKOxjgnemHdT3o6g=;
	b=kabI1SvRHC5tVM6zcyxMFoaMEDZ/Xfstu9Kau5Q2wlZDbjmH6NWIHxaUzHDDKJus1FqaMilUK0hqFZwDuafh4+rFqfX4bOmqQxq20WMGLX6SskKzfodzNqCEFqQf+RdqUcBgzRByMaPXBRmIBvdn9LhpsebkI6vjpxAKAj7+MLs=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PhK37-0001ou-Tv; Mon, 24 Jan 2011 10:53:30 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PhK36-0004vc-LX; Mon, 24 Jan 2011 10:53:28 +0000
Content-Disposition: inline
In-Reply-To: <4D3D2865.4020408@viscovery.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165446>

On Mon, Jan 24, 2011 at 08:21:09AM +0100, Johannes Sixt wrote:
> Am 1/21/2011 15:50, schrieb Russell King - ARM Linux:
> >  SetEnv GIT_PROJECT_ROOT /var/www/git
> >  SetEnv GIT_HTTP_EXPORT_ALL
> >  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
> > 
> > Great.  Deciding that it will be http://servername.example.com/git/ is
> > really damned annoying as that's traditionally where gitweb lives,
> > which requires a different script alias.
> > ...
> > I'm really not interested in working out how to bodge this into working
> > along side the existing gitweb setup by adding lots of rewrite rules,...
> 
> It has been worked out for you already. It's just a single rule (although
> a bit longish). Look for 'ScriptAliasMatch' in
> http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html

Thanks, added taking two server restarts (one of them took a few minutes
for apache to restart as it was soo busy...)

I assume this also means that I need to update the URLs people are using
(as the tree wasn't exported under http://hostname.example.com/git/)?
