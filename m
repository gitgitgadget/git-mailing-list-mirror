From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Command-line interface thoughts
Date: Tue, 07 Jun 2011 08:11:48 +0200
Message-ID: <4DEDC124.3060302@drmicha.warpmail.net>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DEC8322.6040200@drmicha.warpmail.net> <7vk4cz9i1b.fsf@alter.siamese.dyndns.org> <4DECE147.3060808@drmicha.warpmail.net> <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 08:11:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTpW8-0003hE-2X
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 08:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135Ab1FGGLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 02:11:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52004 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103Ab1FGGLu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 02:11:50 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7CDD220726;
	Tue,  7 Jun 2011 02:11:50 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 07 Jun 2011 02:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=++4lrGGbW08jflSUP7zuRcbuWv8=; b=YNa/N6MG6sJjXjSODwOjmQJK1No5k3CmXoJMjXahjhWQb7QefXEBiCvEvx5CKo7qXbH97H+PTNMYsGWvReXOuVxbvOss/3n/IZSiBvrYqlRoa78MDFsU1jGIKVXIWj/KEhkt9W9WkJ70PWkM0VrUcnQAepFTmqpaj5ID61jwhhE=
X-Sasl-enc: klhdnDpv2iLnXcyb3Aj1pOisud4v/rZfG0zSr04RJViS 1307427110
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8B3EA446258;
	Tue,  7 Jun 2011 02:11:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175188>

Junio C Hamano venit, vidit, dixit 06.06.2011 18:14:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> That is why I asked what the user experience of "git show NEXT" as opposed
>>> to "git show INDEX" should look like. So what should it look like during a
>>> "pull" that did not finish?
>>
>> If NEXT is to mean the result of a commit in the current state, and the
>> current state would or should not allow a commit, then trying to access
>> that pseudo-commit should error out with a helpful message.
> 
> What "helpful message"? I asked for the user experience, not handwaving.

I specified the exit behaviour, that is no handwaving.

[...]
>> Another option is to make NEXT/INDEX mean a tree (:0:). I have not
>> thought this through (and have not made a suggestion, accordingly) but I
>> do see a problem in the UI. (I don't think we need to change the
>> existing ui in that respect but can amend and improve it.)
>>
>> Anyway, it's rc phase :)
> 
> Rc or not rc,

I spend my limited git time running builds and tests for master on
several systems these days (and following changed build environments
there which I can't control).

> just repeating a fuzzy and uncooked "idea" around phoney
> ref-looking names that will end up confusing the users, and selling that
> as if it is a logical conclusion to "we want to give an easier to
> understand UI", without presenting a solid user experience design that is
> convincing enough that the "idea" will reduce confusion will not get us
> anywhere, especially when it is sprinkled with ad hominem attack at me.

I've re-read all my posts in this thread and have no idea what you're
referring to here. If I were more sensitive I could spot attacks at
myself in the above, though. Just count your usage of terms like
"phoney", "fuzzy" etc. directed at other people's ideas and arguments.

I'm actually wondering whether there is any agreement on the sheer fact
that there is a problem in the ui, namely having too many different
commands or options (reset/commit/add/checkout resp. diff invocations;
I've described that already) for different aspects of a "similar"
concept (cp content version from A to B resp. diff it).

If we don't agree that there's a problem then there's no point
discussing solutions (or ideas/brainstorms thereof).

Michael
