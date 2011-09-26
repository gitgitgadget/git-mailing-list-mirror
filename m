From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 15:03:37 +0200
Message-ID: <4E807829.7050609@drmicha.warpmail.net>
References: <4E8066AB.7000208@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Georg-Johann Lay <avr@gjlay.de>
X-From: git-owner@vger.kernel.org Mon Sep 26 15:03:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8AqX-0000xK-V7
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 15:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab1IZNDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 09:03:40 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53717 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750833Ab1IZNDk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 09:03:40 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D1FFE249CC;
	Mon, 26 Sep 2011 09:03:39 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 26 Sep 2011 09:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=zC9EPtjrzQ8rr6aHPLaBC5
	5Ig1Q=; b=H5vmIJYjoABlNfleho/uQAKkxV/ApQMpL4NlZQPOlMpcdfhzkhUO1V
	d5OOUdB4DnjxjzvFc9A0KzQ7FSNeAABHMNcFezu8wIzqHy5ktBn9h9jbCoVEqXAw
	XgK36DHZBpj/OX7jtJtMYPeImkv4nf96xJPZ3woRum/+HXvKeTBqQ=
X-Sasl-enc: WtOP8W/FH5VTtblKFA1izN1StpV5mNb7kK/C1jthlk3t 1317042219
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5B211A00B85;
	Mon, 26 Sep 2011 09:03:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E8066AB.7000208@gjlay.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182109>

Georg-Johann Lay venit, vidit, dixit 26.09.2011 13:48:
> Hi, I just downloaded git and built from source, version is
> 
> git version 1.7.6.4
> 
> I am particularly interested in git-svn, but running it I get complaints
> 
> Initialized empty Git repository in /local/Downloads/v4.5.x/.git/
> Can't locate SVN/Core.pm in @INC (@INC contains:
> /usr/local/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
> /usr/local/lib/perl5/site_perl/5.10.0
> /usr/lib/perl5/5.10.0/i586-linux-thread-multi /usr/lib/perl5/5.10.0
> /usr/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
> /usr/lib/perl5/site_perl/5.10.0
> /usr/lib/perl5/vendor_perl/5.10.0/i586-linux-thread-multi
> /usr/lib/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at
> /usr/local/libexec/git-core/git-svn line 42
> 
> I found out that a module like subversion-perl is missing, but installing it
> via OpenSuse 1.11 would downgrade my SVN installation, so I skipped that.

So, where did you get your svn from? If you compiled it yourself, you
should rebuild it with the perl bindings. Make sure you note where you
install this to - you may have to adjust your PERL5LIB.

> Thus, being no admin and no perl guy, I am stuck now and am asking here for
> some kind help, being very well aware that it's not a git issue but just about
> getting some prerequisite for git.
> 
> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
> that in subversion.tigris.org, so that I am stuck and need some hints on how to
> proceed.
> 
> Many thanks,
> 
> Johann
