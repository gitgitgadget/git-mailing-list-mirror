From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: FEATURE REQUEST: Cherry pick in not checked out branch
Date: Mon, 15 Mar 2010 12:01:56 +0100
Message-ID: <4B9E13A4.3090502@drmicha.warpmail.net>
References: <be8f531d1003150139p7cc99700m807ab21bddf8fbb@mail.gmail.com>,<fabb9a1e1003150243o21bab937y122ac61d65777d5f@mail.gmail.com> <SNT124-W1769013489F8B7CE42C581C42E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 12:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr86F-0005Di-PZ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 12:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838Ab0COLEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 07:04:38 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60609 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936113Ab0COLEh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 07:04:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 88FD1E4F99;
	Mon, 15 Mar 2010 07:04:37 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 15 Mar 2010 07:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/gABp39/RiUYYefA30l+g+uKWdM=; b=E/2BN4xg3ZkV1zGDb6o10bhrerfBeQWVy6gcjF9993qvvQJSXBhBPzkzQ4puatRzoeosePV8JlcfqyBXvqP6zST+okx7E9yqbRIkOPro+EhqoRvSuLowGeGUfaWNlGovHZzk0RV4WtrmTBKDn0Lt/RrF9rY4qlsPRVvbjKD82XM=
X-Sasl-enc: BujUf9lQgFdjarFpjQ1JxjFDjUZ6o+wFaGRGFdZnKxcO 1268651077
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B824C49D4F9;
	Mon, 15 Mar 2010 07:04:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <SNT124-W1769013489F8B7CE42C581C42E0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142203>

Tim Mazid venit, vidit, dixit 15.03.2010 10:54:
> 
> Hi,
>  
> Could we not make cherry-pick "stash, checkout, cherry-pick, checkout, pop"?

Sure, that would be 5 command invocations requiring a work tree ;)

Seriously, you can make this into an alias or custom commend, of course,
but it would possibly need to stop in a state of conflict, the very same
way that rebase -i may. There are structural improvements on the way
which will make rebase -i, cherry-pick and so on use the same underlying
code base, and that will help implementing requests such as this one.

Michael

P.S.: Please don't top-post (I cut it).
P.P.S.: Please don't cull cc (I re-added SR).
