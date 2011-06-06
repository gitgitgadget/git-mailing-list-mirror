From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 16:16:39 +0200
Message-ID: <4DECE147.3060808@drmicha.warpmail.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DEC8322.6040200@drmicha.warpmail.net> <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:16:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTabu-0003Xw-JC
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 16:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab1FFOQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 10:16:43 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38353 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756420Ab1FFOQn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 10:16:43 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B9E8820331;
	Mon,  6 Jun 2011 10:16:42 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 06 Jun 2011 10:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=e/lEgEnPqmb4LVpJqQZJGCTFfeM=; b=r8/FPFLqtw5LPQzQyaulExZ+uSYF+KIrMASIR43KRiZ7777ylAT7hr9jqcljJXivERQ8sgzTYBKvF90IBKEQRig4z6Si0cLngGh9ZjTqci/Ek1wNJY3I8q8OEKE2crtYyieozsSP+o6+zfBc+UtxtWjR11Jh9W/KbZL0btbFCZQ=
X-Sasl-enc: WQWVR/JfwGI+fP8lq3rIRThEAJ02vcUT+d2ggnevoPkv 1307369802
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9B777444153;
	Mon,  6 Jun 2011 10:16:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175126>

Junio C Hamano venit, vidit, dixit 06.06.2011 16:00:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 06.06.2011 08:16:
>> ...
>>> For example, how would you design the user experience of "git show NEXT"?
>>> Try to write a transcript (i.e. "The user starts from this state, runs
>>> these commands, and then says 'git show NEXT'. The user will see this."),
>>> covering various corner cases exhaustively, including what would happen
>>> before the first commit, and during a conflicted "pull" or "rebase -i".
>>>  ...
>> That is why the other Michael suggested "NEXT" as opposed to "INDEX":
> 
> That is why I asked what the user experience of "git show NEXT" as opposed
> to "git show INDEX" should look like. So what should it look like during a
> "pull" that did not finish?

If NEXT is to mean the result of a commit in the current state, and the
current state would or should not allow a commit, then trying to access
that pseudo-commit should error out with a helpful message.

Another option is to make NEXT/INDEX mean a tree (:0:). I have not
thought this through (and have not made a suggestion, accordingly) but I
do see a problem in the UI. (I don't think we need to change the
existing ui in that respect but can amend and improve it.)

Anyway, it's rc phase :)

Michael
