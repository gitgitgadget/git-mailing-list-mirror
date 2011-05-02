From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Mon, 02 May 2011 19:49:30 +0200
Message-ID: <4DBEEEAA.3000004@drmicha.warpmail.net>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net> <20110429223433.GA3434@sigill.intra.peff.net> <m2k4ecy6rv.fsf@igel.home> <7vfwp0uwu4.fsf@alter.siamese.dyndns.org> <m21v0kw1es.fsf@igel.home> <4DBE6E77.3030703@drmicha.warpmail.net> <BANLkTinxszGhtYobuvci5Yi8eTHW+pi2wA@mail.gmail.com> <4DBE8FD8.90303@drmicha.warpmail.net> <7v7ha9ngsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGxFb-0006De-2b
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab1EBRtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 13:49:33 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33231 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753091Ab1EBRtc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 13:49:32 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4EBCA208BC;
	Mon,  2 May 2011 13:49:32 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 02 May 2011 13:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lgz4H/IHkvXvNnYhvsO9GQpsB+M=; b=ZEkyA4aHYlHW7R2farwyDM1lNe0CQEYl0Ulq+jiu1hnA1NFuUbWN3WrgOXOfbvXnUEIHGlT+y9RWFHPRVEojydj6t7JUBJ5jyexayMNEmugY9Egrd5NhkFW13FnKN/n13T3QZS05h2IunZZ+c5/tPWMykimlDkVD2td7ZUtsufk=
X-Sasl-enc: xQ5VJ1l1I2ryc80SnK4vfzUqB5kT04Dx6hNZRLKoXHvf 1304358571
Received: from localhost.localdomain (p548592F4.dip0.t-ipconnect.de [84.133.146.244])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A403C443C9A;
	Mon,  2 May 2011 13:49:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7v7ha9ngsf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172608>

Junio C Hamano venit, vidit, dixit 02.05.2011 18:33:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Introducing a shortcut ~n for HEAD~n does not introduce new
>> inconsistencies (it's a shortcut for a commit, for every command which
>> takes a commit) - and does not contradict introducing -n at all, btw.
> 
> I thought we already ruled out ~n because many shells think ~n is a path.

You have, apparently ;)

unquoted ~0 conflicts, but unquoted ~n conflicts only when you use pushd
(and the stack has n entries; or n+-1, I can't count either...). Even
\~2 is shorter than HEAD~2, btw., although I don't consider that viable.

But I understand that I'll have to leave ~n for my private edition.

Michael
