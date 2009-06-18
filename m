From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:44:06 +0200
Message-ID: <4A39FE56.8070808@drmicha.warpmail.net>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de> <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> <7vk53aymuz.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906181030260.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:46:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDGD-00045L-HP
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197AbZFRIob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbZFRIoa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:44:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42754 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756277AbZFRIo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 04:44:28 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7A648361E0F;
	Thu, 18 Jun 2009 04:44:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 18 Jun 2009 04:44:31 -0400
X-Sasl-enc: +4l36TMla+sdnkroDAR3j428WX6YUPI59WktmdyB+F1V 1245314670
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9596D2E323;
	Thu, 18 Jun 2009 04:44:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090617 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0906181030260.4848@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121819>

Johannes Schindelin venit, vidit, dixit 18.06.2009 10:33:
> Hi,
> 
> On Thu, 18 Jun 2009, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Wed, 17 Jun 2009, Junio C Hamano wrote:
>>> ...
>>>> The commit not only must begin with "squash to " but also there has to 
>>>> be a matching commit whose message begins with the remainder of the 
>>>> title of the "squash to" commit _in the range you are rebasing 
>>>> INTERACTIVELY_.
>>>>
>>>> In addition, the resulting rebase insn is presented in the editor, and 
>>>> in a rare case where you do have such a commit, you can rearrange it 
>>>> back.
>>>
>>> Well, that really sounds pretty awkward to me.  I regularly call such 
>>> commits "amend".  If there is a risk I confuse myself as to which commit 
>>> needs to be amended, I use "amend.<short-hint>".
>>>
>>> I'd really rather stay with "fixup".  And as I use single-letter commands 
>>> quite often, I'd also rather stay away from that magic "!".  And by 
>>> "magic" I really mean that: people will not find that magic intuitive at 
>>> all.
>>>
>>> My vote is for "fixup".
>>
>> I am too tired to either make the final judgement nor proposal on this 
>> topic now,
> 
> Okay, I'll add another point that should convince you that the commit 
> message is not the good place to trigger that behavior:
> 
> Interactive rebasing is about having made a quite messy patch series, 
> maybe having a few fixup commits, and then deciding how to clean it up.
> 
> The decision how to clean it up is very much a rebase-time decision, not a 
> commit-time decision.
> 
> For example, it is very easy to decide that you want to squash one fixup 
> after all instead of leaving it stand-alone.
> 
>> Of course we _could_ use notes for that, but that won't play well with
>> rebasing I suppose ...
> 
> Reminds me.  Nothing has happened on that front, right?

<!--#if expr="$SARCASM_ON" -->
No, but isn't that the true purpose of out-sourcing? You've got someone
else to blame now!
<!--#endif -->

Cheers,
Michael
