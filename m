From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The future of gitweb (long term goals)
Date: Tue, 15 Feb 2011 10:09:06 +0100
Message-ID: <4D5A42B2.3090603@drmicha.warpmail.net>
References: <201102142039.59416.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpGxJ-0002ev-13
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab1BOJMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:12:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41749 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818Ab1BOJML (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 04:12:11 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 43457202A0;
	Tue, 15 Feb 2011 04:12:11 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 15 Feb 2011 04:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=EHEYG6T92P05tHP5ihJqQpiROhQ=; b=uK9Ke7iPmPo4PZ9QbKREsZ1A1Bl+Q+yQS0da7A3Zqjon1UeG2tRHKthOq46FQq+C4i5Zxr6RBcmhBFTzELBSYjPf6VPBagCJPf0rBcFOB8v9DGYszrI0/t5wSAmRNxopxESkVbqgTdJCvraMovFxc1QRTefiw2NWYfNBR2O0XSU=
X-Sasl-enc: CIF1go8KNbjMpE8dFh6W0cDZjEEhfxxs7JektHKJTToY 1297761131
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ADD0844356F;
	Tue, 15 Feb 2011 04:12:10 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <201102142039.59416.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166830>

Jakub Narebski venit, vidit, dixit 14.02.2011 20:39:
> Now that we are talking about future of git, including breaking some
> of backwards compatibility bugs / misdesigns for 1.8.0, perhaps it is
> the time to discuss long term goals and the future of gitweb.
...
> Current requirements are:
> - Perl 5.8.x (for proper Unicode / UTF-8 support)
> - core Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename,...
> - non-core Perl modules optional, needed for some of extra features
> - backward compatibility (query params and path_info URLs)

I'd second that this is important for adaption by some main users.

> - easy installation even without admin rights
> - scanning for repositories (as an option)
> - lightweight

All of these are important for instaweb also. I consider instaweb a very
underrated feature! (It also needs some works of love, not just
appreciation, of course.)

> 1. Splitting gitweb into modules (packages), for better maintainability.

Also, this may help including other optional parts. The graph viewer as
used on repo.or.cz sets gitweb apart from quite a few alternatives and
would be used more widely if it were an optional module shipping with
gitweb. Just imagine instaweb with graphs ;)
Also, being part of gitweb, the viewer may attract a few coders.

Michael
