From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 28 Feb 2011 10:38:19 +0100
Message-ID: <4D6B6D0B.3040304@drmicha.warpmail.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com> <20110214231920.GA24814@elie> <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com> <20110227084317.GB3356@sigill.intra.peff.net> <87bp1xest7.fsf@catnip.gol.com> <AANLkTinphmVJe8XW6BhjoyHgA38aopgEk=o=qEp4UT+4@mail.gmail.com> <7vmxlhm3ne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:41:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzbu-0005gR-S5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab1B1Jlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:41:42 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47301 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752387Ab1B1Jll (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 04:41:41 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6005720A2B;
	Mon, 28 Feb 2011 04:41:41 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Feb 2011 04:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5r+G+r6jLUq2O8duHbk6UGWtJc4=; b=p50kRD7/ZVLu1B5w15VxWWWs5k2iCAsROWLcBETt0ZNIVcsmUxQcK+ddj8XshIWqFLZXZzAdLLrjcfA6myeBN5DjLdQUd7dUNHq3nNN9LXLnZcJrXSP55lCKpAt/C5UK0Xh1INWCzMtX1bd2gUaMSVkPNP4hjs0+Ec4bVPq6pHo=
X-Sasl-enc: Hb0UjgfS8CwPdv57WFlQ2xiX1GxEa9SJ7EGqulCktVKM 1298886101
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F8E740AD04;
	Mon, 28 Feb 2011 04:41:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vmxlhm3ne.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168085>

Junio C Hamano venit, vidit, dixit 28.02.2011 00:57:
> Jon Seymour <jon.seymour@gmail.com> writes:
> 
>> I guess the noun 'stage' does have a use in git-speak to refer to the
>> different arms of an unresolved merge.
> 
> That is correct.
> 
> For some historical background around "cache" and "index", this
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/780/focus=924
> 
> may shed some light.
> 
>     From: Linus Torvalds <torvalds@osdl.org>
>     Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
>     Date: Tue, 19 Apr 2005 18:51:06 -0700 (PDT)
>     Message-ID: <Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
> 
>     That is indeed the whole point of the index file. In my world-view, the
>     index file does _everything_. It's the staging area ("work file"), it's
>     the merging area ("merge directory") and it's the cache file ("stat
>     cache").
> 
> And this one:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/6670/focus=6863
> 
> is even more illuminating.
> 
> Notice that the word "staging area" is used in the old article as a way to
> explain one of the three important aspects of the index, and the other
> article that is about nailing down the terminology, the word does not even
> come into the picture at all (one reason being that it will confuse
> readers if "staging area" is used too casually in a document to precisely
> define terminology, which needs to explain the merge stage(s) in the
> index).

Oh, the classics :)

Thanks for an illuminating and entertaining read!

Michael
