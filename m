From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: fix zsh support
Date: Wed, 27 Apr 2011 09:56:18 -0700
Message-ID: <7vzknb8wgd.fsf@alter.siamese.dyndns.org>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie> <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
 <BANLkTinep961dg9v3TD8hZZAvTYL3_H+xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:56:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF82c-0005KM-FM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 18:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759515Ab1D0Q4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 12:56:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759345Ab1D0Q4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 12:56:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B65F544CD;
	Wed, 27 Apr 2011 12:58:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iM+HAomb0ouID1jF9QBOelUigZU=; b=U+56x9
	3XHjXRtPO4s2A7gGMRFP6WxrZkFRem1YYbOueaS8rrv6BWLy26WDidskoBKmsQ/o
	ZqiH78SEAcfDQXEYApYSGLd2FthzPxmSetuVCf0jeYPc++OhtU06I08T3aCves3B
	YeSQDjkbvh9CKSVrMm+oVo3vWmtjDSpu02YNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QxcwF2RF3npoeGTtIZb83i3miwjpAcB0
	+zCMYSx2VEYAs5AnlCpzGfIgwZW4gSEf41JA/igUKRDXBBcwQ15rtNZ2bveBKVQh
	rQzBn7djcnwQ96qbwbcSTze4Y9G2eFMg2qLIm6qXJ2gfXeFqd2AbFYhkvkxIPQBR
	X6QJIX143wI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56A5944C2;
	Wed, 27 Apr 2011 12:58:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9530D44B8; Wed, 27 Apr 2011
 12:58:21 -0400 (EDT)
In-Reply-To: <BANLkTinep961dg9v3TD8hZZAvTYL3_H+xg@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 27 Apr 2011 11:20:42 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 935A021E-70EF-11E0-A248-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172244>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Apr 27, 2011 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I'd love to share the enthusiasm, but find that "as we can see" needs a
>> much more clarification.
>
> Jonathan already described it:
> http://article.gmane.org/gmane.comp.version-control.git/170665
>
> And this snipped demonstrates it:
> ...

When I say "needs more clarification" during a review, I am not asking the
contributor to explain it in the discussion thread to _me_ who happen to
be asking at that moment.  I am asking the contributor to explain it to
people who will read "git log" output 6 months down the road.

You have been here long enough to know that "Jonathan already described
it" that is not connected in the commit that is going to be recorded is
not something we appreciate, no?

In any case, the message of Jonathan's

    Subject: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
    Date: Wed, 27 Apr 2011 01:40:34 -0500
    Message-ID: <20110427064033.GB4226@elie>

seems to explain it better.  The naming of variables and other details
might need to be settled, but other than that is it correct to understand
that we will see a final version along the line of that patch?

Thanks.
