From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pretty date option for git tag?
Date: Mon, 18 May 2009 18:02:30 +0200
Message-ID: <4A118696.80902@drmicha.warpmail.net>
References: <20090518151440.GA10536@andros.its.yale.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: dloewenherz@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 18:02:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65Ij-0004p4-RL
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 18:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbZERQCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZERQCm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 12:02:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52679 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752349AbZERQCl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 12:02:41 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id B9038344EEF;
	Mon, 18 May 2009 12:02:42 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 18 May 2009 12:02:42 -0400
X-Sasl-enc: Y0alLb92Nz7289Mz1+15foW7X+KqW/K0wnAfsgnI0Gsw 1242662562
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1FD0D3A863;
	Mon, 18 May 2009 12:02:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090518151440.GA10536@andros.its.yale.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119454>

dloewenherz@gmail.com venit, vidit, dixit 18.05.2009 17:14:
> It is relatively hard to verify the date a tag was created unless it was been
> gpg/pgp-signed at the time of creation, no? I suppose that the Unix timestamp
> included in each tag file is useful for sorting, but it's not very easy for
> people to digest.  Additionally, we have our `log.date` config, why not use it
> here for some sort of option, like `--pretty=date` to make it easy to see when
> a tag was created?
> 
> I.e.
> 
> $ git tag -l --pretty=date
> ...
> Mon, 13 Apr 2009 00:06:25: v1.6.3-rc0
> Sat, 18 Apr 2009 22:11:00: v1.6.3-rc1 
> Sat, 25 Apr 2009 06:01:13: v1.6.3-rc2 
> Sun, 26 Apr 2009 23:43:48: v1.6.3-rc3 
> Sat, 02 May 2009 06:32:21: v1.6.3-rc4 
> Wed, 13 May 2009 05:30:37: v1.6.3.1
> 
> I don't know if this is feasible. Perhaps there already exists a feature for
> this that I'm unaware of. Or maybe this would be a waste of time.

You might want to experiment with

git log --tags --simplify-by-decoration --pretty="format:%ai %s"

which may show a few more commits than just the tags but comes close to
the output you envisage.

Michael
