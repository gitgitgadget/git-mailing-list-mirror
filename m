Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3431F744
	for <e@80x24.org>; Fri, 17 Jun 2016 08:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbcFQISK (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 04:18:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53456 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942AbcFQISH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 04:18:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 2356C20819;
	Fri, 17 Jun 2016 04:18:06 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 17 Jun 2016 04:18:06 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=uiZleATJGIlsO1K6oRY0DGiuHZ0=; b=m8LPvY
	RmqowcYybJhqiPAhN4QRGlm/dgth8gVXAS168kU0LS4T2buNgpdIfXa+NUdbFbIV
	PlRse5XPWknnK9ISrEQDOXmxZzdHSillaXI66ZBJoonN0y7d2Fq3r0nmxft3fRYT
	PPNTnmL4O5SUie7VeIxrfR+nb27kGZyNn0jFU=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=uiZleATJGIlsO1K
	6oRY0DGiuHZ0=; b=GuHprRCUvV0/MfDyPJtBfaB15PMATsNI3cce95Tq8jaV4vE
	z+54l0Ao8Jo8mVaMHAUiYbml0AuoTSxegxLdqMhjNbldI3aqPTyDYI8Rn5AtV7+o
	LonoW1ZjmLfBfFyygXaoGVRoeNEqvs/EnBkh67egqU3OHTV0DrI6NdESadO8=
X-Sasl-enc: 1zEXTY7uIOhpYaqSFzp8GMVRiWLGfIXs76oSObAZpaZh 1466151485
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 67689CCDA6;
	Fri, 17 Jun 2016 04:18:05 -0400 (EDT)
Subject: Re: I lost my commit signature
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
 <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
 <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net>
 <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
 <20160615043450.GA3975@sigill.intra.peff.net>
 <be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
 <20160616073410.GA651@sigill.intra.peff.net>
 <xmqqr3bx5ahp.fsf@gitster.mtv.corp.google.com>
Cc:	ZhenTian <loooseleaves@gmail.com>, git@vger.kernel.org
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <171543e4-a343-c6d2-aa9a-2098db5b42ec@drmicha.warpmail.net>
Date:	Fri, 17 Jun 2016 10:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr3bx5ahp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 16.06.2016 19:06:
> Jeff King <peff@peff.net> writes:
> 
>> But why does somebody run "commit -S" for a single commit, but not all
>> the time? Is it because that commit is special? Or is that particular
>> moment special? One implies that it's important for the signature to be
>> retained during a rebase, and one does not.
>>
>> So I dunno. I would not be opposed to such a feature, but I'm having
>> trouble figuring out why it would be useful (though for the most part, I
>> do not see why anything but per-project commit.gpgSign config is
>> particularly useful. Maybe I just lack imagination).
> 
> I am not so imaginative, either. One remotely plausible use case may
> be a project that has two classes of paths (let's call these classes
> sensitive and others), and requires its participants to sign commits
> that touch sensitive paths.  The user needs something finter grained
> than per-project commit.gpgSign there.
> 
> But even in such a case, the fact that an original commit is with a
> signature should not be a good indication that the rewritten version
> of that commit in the new history still touches the sensitive paths
> that required the original to be signed (i.e. the history the user
> is rebasing onto may already have the necessary changes to these
> paths).
> 
> So, I dunno, either.
> 

While I follow both of your lines of argumentation, I tend to claim that
they imply: there is no reason to blindly sign any commit... We should
dump that config :)

Since it's not possible to sign commits after the fact without rebasing
(they are not "notes" attached to a commit but part of the commit) it is
very conceivable to me that you build up your work with fine-grained
commits and then, at some point where everything is ready and carefully
inspected, you sign it. There are various possible reasons why you may
not be able to rebase at that point. (I don't know why one wouldn't want
to use signed tags here, but I never understood the need for signed
commits in the first place.)

I guess users of signed commits with rebase should speak up so that we
can serve them well.

Michael
