From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Wed, 16 Mar 2016 16:32:56 +0100
Message-ID: <56E97CA8.8070400@drmicha.warpmail.net>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
 <56E6D8C4.2010205@drmicha.warpmail.net>
 <xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
 <xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
 <56E96096.4020108@drmicha.warpmail.net>
 <CACsJy8CyLGtYpPnwdhS-AD4d2pcU7RVv=OxPEePcHYhFpDh4pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 16:33:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agDRZ-0006f2-MY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 16:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935146AbcCPPdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 11:33:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35606 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935092AbcCPPc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 11:32:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 1FC7620FC8
	for <git@vger.kernel.org>; Wed, 16 Mar 2016 11:32:58 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 16 Mar 2016 11:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=vmtEYy6p5fnetVZk8rHGqHEUxb4=; b=pDuRAj
	kum8l3vMYBTVoUWzvb/wvJZOfkt0FhbuVIwsK0a+WrUENTvqQyiCC8nyqUK4ZPfn
	3KiL19G/oi9AWcW6nUD9yP0fvoHXRmkF2sLYoaRUfYdRZWozMIO0v/zswOqfbclh
	ks/bLWlifx7Mj9KJjrsb0lqWEX5ODIgFSI7Sc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=vmtEYy6p5fnetVZ
	k8rHGqHEUxb4=; b=hzTzsyM5BBHZqAxx6a7zZA5HF5SVUkui2p6ZB3VgqDeYrDM
	vXd4sApz+1qqNMCLMXBSQsyyGMyqidFWK+5gKQE2vEVMbGHnrX8FUNiapRMxxRKC
	hcVYp5flX/bu0ROwrKBQseRlM5BgwYtu1oPHjaaU7pngbM1a+3Fh2aA6EkwA=
X-Sasl-enc: c01nBnjDQTjGQ9NzYFozCe5fY9+NyjuISc4uO1hiyGMK 1458142377
Received: from UltraSam.fritz.box (dslb-092-076-189-025.092.076.pools.vodafone-ip.de [92.76.189.25])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4C4E7C0001A;
	Wed, 16 Mar 2016 11:32:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CACsJy8CyLGtYpPnwdhS-AD4d2pcU7RVv=OxPEePcHYhFpDh4pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288981>

Duy Nguyen venit, vidit, dixit 16.03.2016 14:40:
> On Wed, Mar 16, 2016 at 8:33 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> In hindsight, what happened must have been like this:
>>
>> "ahead " was marked properly for l10n and translated in the past.
>>
>> 7a76c28 (status: disable translation when --porcelain is used,
>> 2014-03-20) introduced those extra parentheses. Matthieu probably didn't
>> rerun "make pot" and "msgmerge" so that he didn't notice the consequences.
> 
> .po(t) files are _very_ noisy because they record line numbers and
> that pretty much guarantees huge diffs. Even I as a former translator
> do not want to "make pot" and see the differences. If only msgmerge
> supports an output without line numbers...
> 

echo '*.po diff=po' >>.gitattributes
echo '*.pot diff=po' >>.gitattributes
git config diff.po.textconv "msgcat --indent --no-location"

With or without the indent, that gives a pretty clean diff. [It's
unfortunate that one half of that config is in-tree, one-half is not.]

The way it currently is, "non-l10n" coders don't even notice when their
changes affect the set of marked strings. But I guess ususally that's
not a problem.

For our l10n coordinator it is impossible to decide whether a "git.pot"
diff between two runs looks the way it is supposed to look - he would
have to be aware of all code changes that intentionally change the
marked strings. (Likewise, for the translators.)

So, really, the "actual coders" know best whether their changes should
affect l10n or not, so they should be made more aware of it. Forcing
"make pot" (and maybe more) on everyone sounds a bit harsh, but what
else can we do?

Michael
