From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 14:09:10 -0700
Message-ID: <7v4ntgwdft.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
 <7viphwxyp1.fsf@alter.siamese.dyndns.org> <4F6B84DF.8040806@in.waw.pl>
 <7vk42cwew5.fsf@alter.siamese.dyndns.org>
 <CAJsNXTkEDr_bg3tCo-OOOzAe_5AVgoGV_9b0b3GOREzPE4Pg_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejew?= =?utf-8?Q?ski-Szmek?= 
	<zbyszek@in.waw.pl>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:09:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SApG2-0001ts-PG
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 22:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab2CVVJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 17:09:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab2CVVJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 17:09:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B58D65C3;
	Thu, 22 Mar 2012 17:09:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fo0LMf80mCzl
	U61gpeC4LDW4Mq0=; b=AGh729AnywDXDwtVeDLSpvY9t4AA+FUyfQvcNUpToafC
	QH8oCmvwBaV67+aw1W4JQwGOifbYoZ1gJflbMyyqGJPDJtBZw7Twmoh+tzTJIyke
	/KXbalTpO64ESEie0uUUYPco6qN5nTD0I/wQT8Oki+591BnuIKc/5vWJjhtLsPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YouirI
	qtiJqrYjLK/1uOpR9wgFHiJ7zmavg6vOfIh8c/l5Lnii9vn9OLdLWklhqUHMbV7G
	aGW8IR1TU6n9OurhqjlNNO2MJT+lnTEkBtmMvOp1AkNsvTPpU+7rZ7dRMFDb3ETH
	o0PcNJlWr5Lj9GRVsS+Y5/BmqmrUFzUXurYM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51B2F65C2;
	Thu, 22 Mar 2012 17:09:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0FB465BF; Thu, 22 Mar 2012
 17:09:11 -0400 (EDT)
In-Reply-To: <CAJsNXTkEDr_bg3tCo-OOOzAe_5AVgoGV_9b0b3GOREzPE4Pg_Q@mail.gmail.com> (PJ
 Weisberg's message of "Thu, 22 Mar 2012 13:55:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45C4A1A8-7463-11E1-8760-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193719>

PJ Weisberg <pj@irregularexpressions.net> writes:

> 2012/3/22 Junio C Hamano <gitster@pobox.com>:
>> Zbigniew J=C4=99drzejewski-Szmek =C2=A0<zbyszek@in.waw.pl> writes:
>>
>>> Even this updated text does not say _what_ happens when
>>> core.ignorecase is set on a case-insensitive filesystem.
>>
>> That was very much on purpose. We tell users not to do that, because=
 it is
>> calling for an undefined behaviour. And leaving it undefined gives u=
s a
>> wiggle room to later do something better if we choose to.
>
> Where do you tell users not to do that?  Nothing on the man page
> actually says that the behavior is undefined,...

Read the messages in the thread you are responding to. It is a discussi=
on
about how we update the documentation to say it.
