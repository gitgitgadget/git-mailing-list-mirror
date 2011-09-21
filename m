From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] read-tree cleanups
Date: Wed, 21 Sep 2011 09:51:53 +0200
Message-ID: <4E799799.8060106@drmicha.warpmail.net>
References: <4E7996AA.4040909@drmicha.warpmail.net> <cover.1316590874.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Sep 21 09:52:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Hb6-0001YE-Du
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab1IUHv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:51:56 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34326 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1IUHvz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 03:51:55 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 6FA6320F73;
	Wed, 21 Sep 2011 03:51:55 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 21 Sep 2011 03:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=eXicx3kdH64emNqTc2/NPQ
	wokvk=; b=YhBKTv+Lg9a68aTYUFWptMdR9ck54stqjyyQfYhZ4gDoZMm0/DeRPm
	4972g8ota4yw9uNVctc6pfcCBkMZZQB3VaDAeSR2LtCmrP24UBHjnIO4G9RpgujA
	AEW8gV79JE+bTCfgw1/D2LS2UW2KnqPK+iKVS5c8wcv0a6oAD3bL8=
X-Sasl-enc: md2n/VcDljIw//CaDwO9WQPpJ11m4qlJkbIitFH5A8Bd 1316591515
Received: from localhost.localdomain (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D18C37C0650;
	Wed, 21 Sep 2011 03:51:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <cover.1316590874.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181825>

Michael J Gruber venit, vidit, dixit 21.09.2011 09:48:
> These are a few cleanups I noticed while checking Joshua's sparse checkout
> problem when swithcing branches with a dirty sparse tree.
> They are independent of a possible fix.
> 
> Michael J Gruber (3):
>   unpack-trees: print "Aborting" to stderr
>   git-read-tree.txt: language and typography fixes
>   git-read-tree.txt: correct sparse-checkout and skip-worktree
>     description
> 
>  Documentation/git-read-tree.txt |   48 +++++++++++++++++++-------------------
>  unpack-trees.c                  |    2 +-
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 

Uhm, I forgot about the dont-cc-jc-in-rc policy, sorry. This is not a
late-minute regression fix and can wait.

Michael
