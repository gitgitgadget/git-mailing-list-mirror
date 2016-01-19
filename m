From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Tue, 19 Jan 2016 08:07:23 +0100
Message-ID: <569DE0AB.9050403@drmicha.warpmail.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
 <569CEA1C.90700@drmicha.warpmail.net>
 <20160118170655.GA24184@sigill.intra.peff.net>
 <20160118213957.GA25460@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 08:08:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLQOl-0003Ds-UF
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 08:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256AbcASHIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 02:08:12 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33575 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169AbcASHH0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 02:07:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5135B20B79
	for <git@vger.kernel.org>; Tue, 19 Jan 2016 02:07:25 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 19 Jan 2016 02:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=9JhSbSKeFNSGgmG5HxxYBOshVmA=; b=SxLksb
	1mZoCVjob0SuBCIAEnCqo+c5/IIXHPYsKvZ3UdqKWWU5ii3AavI11vuOYrSmNt1N
	CinLN4QeDR70+opyegyz/KhNWzDpmAemsehTSotz0Ps3TSM28W1IctmYOpQ/ay2p
	Sa58GZg9nYCEjAkRwXq0WJQ7WGaIB0ZeEqbaw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9JhSbSKeFNSGgmG
	5HxxYBOshVmA=; b=j4zKk1vnJ3FcKOThzG1LJjmclLnzKyfjPZfMmaib6U3u4Hn
	PdHu2h/lMj9D8JLvDEGF+8hkZ+PAkd/ybwyAwwoONVB4TLLL/0cuqaFliUYifQ/v
	gyRQeiW1rZtL1NyFvk3Ygaa61lwklBk4rQyNeZSLex8Q6Z7Lj4YWNhH608P8=
X-Sasl-enc: KFFZTGPbD+4RFBxbtA3QSAslc3m0vbUnV9ZnTnYy4fS0 1453187245
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id A2089C01709;
	Tue, 19 Jan 2016 02:07:24 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160118213957.GA25460@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284349>

Eric Wong venit, vidit, dixit 18.01.2016 22:39:
> Jeff King <peff@peff.net> wrote:
>> On Mon, Jan 18, 2016 at 02:35:24PM +0100, Michael J Gruber wrote:
>>> Junio C Hamano venit, vidit, dixit 12.01.2016 00:45:
>>>>
>>>> * mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
> 
>>>>  Will discard.
>>>
>>> Oh, sorry. Work killing me plus I was waiting for help, too.
>>
>> FWIW, I took a look at them a few months ago, but I couldn't reproduce
>> the problems in the first place. I think it has to do with the default
>> apache setup given by my system (debian unstable) versus others.
> 
> Ugh, I was meaning to look into these too (after upgrading to
> Debian Jessie), but maybe it needs to be tested on Fedora/RH-based
> configs?

It needs to be tested with a "default config" I think, in the sense of
"apache 2.4 default". Fedora seems to use the default config which is
different from earlier apaches' defaults.

Debian uses a config which is not the 2.4 default but makes switching
from earlier apaches easier.

Back then, I was only able to get half way to running the git svn tests
over http. I think I got our test suite to start http and run the git
over http tests that didn't run before on Fedora, but I couldn't get git
svn over http tests to run (so that they are run via local protocol
instead). I'll keep it in mind, though.

Michael
