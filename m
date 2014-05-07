From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2014, #01; Tue, 6)
Date: Wed, 07 May 2014 11:59:53 -0700
Message-ID: <xmqqr4459zyu.fsf@gitster.dls.corp.google.com>
References: <xmqqlhuecz1b.fsf@gitster.dls.corp.google.com>
	<53696d8aa12d2_747f15213089@nysa.notmuch>
	<xmqqha52cvuf.fsf@gitster.dls.corp.google.com>
	<536975458b570_110415b330c55@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 21:00:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi74Y-0003aV-0f
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 21:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaEGTAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 15:00:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63432 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbaEGS76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:59:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7FC616D19;
	Wed,  7 May 2014 14:59:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5k3WOGDxaMTXkpkQUu2TivvdHls=; b=WW9Gbr
	7gx9DsB7h4thbI3wWAF51YaaQaHoO0h4EEJVdmg/aoXu681pMymzfq2iMGwjm96K
	//4UUQ4IPxSargn711ZVaUm6VHpf7Eu/1phRT4fsRIHgmn/HAQaBl51VfvHgbdug
	AfPxeWgt/vv59r/6fEfNgi+rS9PWfj9vaIEX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Af/5/plEAMufUuUhh2X/rh/wnB1N6Gcr
	yZExzb9Dx0DyJwB1xTQHfzOi3unH/X3URGlv9ST+PQfT/7/XFrLhN62CP0fQRZ49
	6xLeFBq53YZAL+4JGKnm0uUW/zlnj2G4Pa/mIigG7MKRyOr2OFDJjonu6pTpkbTE
	rZ0KN23gKzE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD2F816D18;
	Wed,  7 May 2014 14:59:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F41B616D17;
	Wed,  7 May 2014 14:59:54 -0400 (EDT)
In-Reply-To: <536975458b570_110415b330c55@nysa.notmuch> (Felipe Contreras's
	message of "Tue, 06 May 2014 18:50:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C6DC8BF6-D619-11E3-814C-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248347>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > Plus this one which has been completely ignored:
>> >
>> >    completion: move out of contrib
>> 
>> It is not about "ignored".  It is about running out of time before
>> concluding the day's integration.
>
> A comment doesn't require integration.

It requires time and attention that are limited commodities.
Moreover, I won't read or respond to pieces of e-mail in the order
they come in.

The topics listed in the What's cooking report is fixed at the end
of the day's integration cycle, as they are essentially output of
"log --first-parent master..pu | grep Merge".
