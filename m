From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: I lost my commit signature
Date: Wed, 15 Jun 2016 09:07:16 +0200
Message-ID: <be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
 <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net>
 <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
 <20160615043450.GA3975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, ZhenTian <loooseleaves@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 09:07:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD4v6-0001uC-S8
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 09:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbcFOHHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 03:07:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55243 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575AbcFOHHT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 03:07:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B1F012194A;
	Wed, 15 Jun 2016 03:07:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 15 Jun 2016 03:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=c7ZkDu6B4jee90LmdjWjXLG523w=; b=N0X7hf
	cO0+n44L4Z6z67b4HKYdWXjGKCWqrlw4yWKBmV7/MTzlQZDvhRBjBD4nFLAHmvrz
	vn2/DPsE1PEivxW4CTw/K7LsgMVGg3NEpGMcybl+nhaHxkuLeAVXD1C1opzBCY6T
	KL4zIaSpthk8c87nO7FWg0CwsFTLSJASQifOM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=c7ZkDu6B4jee90L
	mdjWjXLG523w=; b=nXnuk64pTecL8MYB8uQoo0b2JhqUo4bwFV8OSJhA8i2G2CI
	M9/sltlES/QDV5cX3Jt0ga6L3K2TU1LBScz73Qun3U8NgImTbVQW1CtmYsbX/pG1
	blagoqTPKLUrAjqYJa4RX/1eabrUHCKTbtIgqlqj/cSLpz9I2qnrPRXpq0ts=
X-Sasl-enc: GiNLIfos4UUFF3FhLxm8pT3Hy76njVUNDM5ePAnsur2G 1465974437
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id E6E3CCCDB2;
	Wed, 15 Jun 2016 03:07:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160615043450.GA3975@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297357>

Jeff King venit, vidit, dixit 15.06.2016 06:34:
> On Wed, Jun 15, 2016 at 12:27:15PM +0800, ZhenTian wrote:
> 
>> I got two more lines from gpg -v during commit with -S:
>> ```
>> gpg: writing to stdout
>> gpg: RSA/SHA1 signature from: "2EF2AD6E Tian Zhen <tianzhen@honovation.com>"
>> ```
>>
>> after I commit, I push it to remote, but someone had pushed before to
>> master branch, so I pull on master branch(`git pull --rebase`), then I
>> check my commit via `git log --show-signature`, there is no signature
>> in it, so I commit it with --ament and -S again, the signature is come
>> back.
>>
>> I haven't check signature before push, because I have checked four
>> commits before, every commit is fine.
>>
>> I don't know whether the `git pull` influenced signature or not.
> 
> Ah, so the problem is probably that you had a signature _initially_, but
> that it did not survive the rebase. Which makes sense, as rebase would
> need to re-sign.  It does not by default, but you can tell it to do so
> with "-S". Or you can set `commit.gpgsign`, which should sign in both
> cases.

While it's clear that a rebase invalidates the signature, we could try
to be more helpful here, especially given the fact that (with our model)
you can't sign a commit afterwards any more.

commit.gpgsign signs everything, but there should be a mode for
re-signing signed commits, or at least a warning that rebase dropped a
signature so that you can --amend -S the last commit.

Michael
