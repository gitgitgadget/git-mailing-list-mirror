From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 4/5] branch: introduce --list option
Date: Mon, 29 Aug 2011 08:35:03 +0200
Message-ID: <4E5B3317.7000207@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net> <cover.1314543252.git.git@drmicha.warpmail.net> <05a1a73e0b942dd94dd091c233be964fa19dfc6a.1314543252.git.git@drmicha.warpmail.net> <7v8vqc92yp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:35:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxvRA-0004zc-U6
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab1H2GfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 02:35:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35364 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780Ab1H2GfG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 02:35:06 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A9F9D20FC0;
	Mon, 29 Aug 2011 02:35:05 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 29 Aug 2011 02:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=w/E87WySb95LxFWDlyBJ1r
	r8fzE=; b=HynalGtj3WxAy6/myeH7FgKwiTSATW7v056fhvA9BxPRze7/82MTB0
	ZAdzDDEo8uMlYt0dq7mTR4ofRQYsBGsoFU0T/CaRu/DBBFltSJ8LBJcfnAsLE86/
	mA1euVo8Y0Uao1ljvN4YsEYhN7y8iQBF1VnS32Ver0vxzJBnrH8B8=
X-Sasl-enc: wdaZ7H60jo5ErHT5534MT95ycvwvk/3POY+24ITbXZ/B 1314599705
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0D429A20358;
	Mon, 29 Aug 2011 02:35:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7v8vqc92yp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180301>

Junio C Hamano venit, vidit, dixit 29.08.2011 07:55:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> +test_expect_success 'git branch --list shows local branches' '
>> +	git branch --list >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +cat >expect <<'EOF'
>> +  branch-one
>> +  branch-two
>> +EOF
>> +test_expect_success 'git branch --list pattern shows matching local branches' '
>> +	git branch --list branch* >actual &&
>> +	test_cmp expect actual
>> +'
> 
> Does this one exclude the "* master" entry at this stage in the series?

Sheesh, that rebasing mistake (flipping the order of 4 and 5) was
present in v2 already. Only recently I learned about rebase-i's "exec"
and have to make it a habit to use it for step-by-step series testing.

Sorry, I'll send out v3 a bit later when I see that there are no more
comments (and a full step-by-step series test has passed).

Michael
