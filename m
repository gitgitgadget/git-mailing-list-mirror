From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Sparse checkout in worktree
Date: Wed, 25 Nov 2015 20:44:46 +0100
Message-ID: <56560FAE.3000605@drmicha.warpmail.net>
References: <5655AC29.20801@drmicha.warpmail.net>
 <CACsJy8Acb0Z3sw7_r6QfTTz=GqedsU76QxjexWf4yZFg9O7W-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:44:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1fzn-0002Wf-IW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 20:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbKYTou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 14:44:50 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36026 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751400AbbKYTot (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 14:44:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5F50E20A60
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 14:44:48 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 25 Nov 2015 14:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=mMkz6IxMDsNegvwYa6/8ZLmlWFA=; b=MZQie5
	TRB8QlwQMSzSID7YZxwf10KcUve5ogBihHguJlGAdlR276eBXR2K/JLYgyxFvke9
	PDmSz/lfgSgolv/DqR3nTUsfUe6SQmJailByxlUIatr0be3sjlCKPLrJ0dj7bqpO
	ZGquNtEgIpTbGHQcoeN0NuuMrQ9aY9kP5gyB8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mMkz6IxMDsNegvw
	Ya6/8ZLmlWFA=; b=YjFzqye+3E1xKoqW/ScsVq0exGMaLeXQTOqgOIzFVual6dv
	zKlbAizi3Q+iN5R42N0v48cAraQ0egefAPDmscrFIqox2M4lq/ELTD4gY6wXkdUK
	xA2djFTLwEQ8g+jhkivgCjh7NUom4jiy+6v+fd6RWhizdlHuJoxEfYT8txOc=
X-Sasl-enc: Zx9ThyjYXFQBGBmwFx5hKJup+D9VzckxYXpxFoRUjB61 1448480688
Received: from UltraSam.fritz.box (dslc-082-083-017-046.pools.arcor-ip.net [82.83.17.46])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6D740680169;
	Wed, 25 Nov 2015 14:44:47 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CACsJy8Acb0Z3sw7_r6QfTTz=GqedsU76QxjexWf4yZFg9O7W-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281733>

Duy Nguyen venit, vidit, dixit 25.11.2015 20:38:
> On Wed, Nov 25, 2015 at 1:40 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Hi there,
>>
>> I'm wondering how much it would take to enable worktree specific sparse
>> checkouts. From a superfluous look:
>>
>> - $GIT_DIR/info/sparse_checkout needs to be worktree specific
> 
> It already is.

But where should I put the worktree specific sparse_checkout file? Is
Documentation/technical really the only place to find information about
this? And to make the existing tree sparse, do I need to rm -r and
checkout sparsely?

Michael
