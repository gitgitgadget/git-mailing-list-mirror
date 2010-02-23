From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC] git-svn: Allow multiple branch and tag patterns
Date: Tue, 23 Feb 2010 11:50:43 +0100
Message-ID: <4B83B303.50408@drmicha.warpmail.net>
References: <c8b3bef91002221429l3b277429l56f4e4cac4fdeb43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 11:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjsLd-0003kV-4o
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 11:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab0BWKu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 05:50:27 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53035 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746Ab0BWKu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 05:50:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 11C6DE1B99;
	Tue, 23 Feb 2010 05:50:26 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 23 Feb 2010 05:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VoLcfpKYv3veY4MtkVfQ5zp70dE=; b=a43J0IudG1tp3ah14OpkwFC1hhO7+EWe09aldeVB1w2sete6oezlF+fvXJTSLiHvTZAvrxa2fHkKtYEwFvYcMjxK/NNGT7vBpUPjNuf8zyfX2RL7OXXKFmQDKqhlfkpXOf3gJ55WY4+A7q7PfVnF9bk6HSGVGa9OOPy2S0HbJjE=
X-Sasl-enc: H77tl+oNGbTmiYxITJ4MVsN6I3XS+4/wU4BuojYeyFhF 1266922225
Received: from localhost.localdomain (p3EE2A92E.dip0.t-ipconnect.de [62.226.169.46])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 38DD44BC3C2;
	Tue, 23 Feb 2010 05:50:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100222 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <c8b3bef91002221429l3b277429l56f4e4cac4fdeb43@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140785>

Michael Olson venit, vidit, dixit 22.02.2010 23:29:
> This change allows multiple branch and tag patterns to be specified in
> .git/config for git-svn projects.  This is useful for fetching several
> different parts out of the namespace of an svn repository.
> Additionally, a new repeatable directive called "skip" has been added
> to specify a specific tag or branch to ignore.
> 
> Signed-off-by: Michael W. Olson <mwolson@gnu.org>
> ---
> I've been using this patch regularly for over a year on a very large
> svn repository.
> 
> This patch is known to work on git 1.6.3.3 specifically.  Once I get a
> few responses about whether or not it is useful, I'll rebase it
> against the git.git master branch.  Some further documentation
> (perhaps just a relevant example or two) would also need to be added
> to the git-svn manpage.

I'm sorry, but we have this (multiple branch/tag lines) since 1.6.4, see

6224406 (git svn: Support multiple branch and tag paths in the svn
repository., 2009-06-23)

The skip directive may be obsoleted by

0757620 (git-svn: allow subset of branches/tags to be specified in glob
spec, 2010-01-23)

Cheers,
Michael
