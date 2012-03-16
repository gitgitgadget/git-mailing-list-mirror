From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 16 Mar 2012 12:35:51 -0700
Message-ID: <7v7gykgwyw.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
 <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
 <vpqfwdjas0m.fsf@bauges.imag.fr>
 <20120309033826.GA6164@sigill.intra.peff.net>
 <7vsjhi9wku.fsf@alter.siamese.dyndns.org> <vpqobs65gfc.fsf@bauges.imag.fr>
 <7vwr6u6qrn.fsf@alter.siamese.dyndns.org> <vpqmx7mcgdz.fsf@bauges.imag.fr>
 <7vk42pu6io.fsf@alter.siamese.dyndns.org> <vpqwr6o3k9s.fsf@bauges.imag.fr>
 <7vlin4llwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 20:36:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8cwS-00064M-CI
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 20:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab2CPTfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 15:35:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756460Ab2CPTfy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 15:35:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 752DD61D4;
	Fri, 16 Mar 2012 15:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SrNUVyp56lSMaw8FugeDxDKYvKY=; b=BnR/Zu
	D+lS+EPRrwVfevHgvM4JB+7q1IK0zsuHlETLUykMnY1w5np1cqvdGUBolIdQYC+T
	bL2yoaEiAYjPlyN/xc94gGEK8QqeLeVObjnU6745oGQTeuoCoawbKVPQYXRPXNGj
	nw2gV2k+q951KKDz8WVhfdA3/lD8m7jIbrapA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TiglO/jo6SKVn8UQM2ckU0BV63U/e4g7
	bneuWHDlU2byY4fLPZrP5cnCEWmma5tfKpCd9T+5tUT75IxqZ2FjWMyflgswEvR+
	nOuYvZTtPcqWL9aIa70UomdVTOaiWTWxs22rnlpalUyoIEygzhtq02IRmoXVFXmX
	u8cgc+80eqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A46C61C6;
	Fri, 16 Mar 2012 15:35:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE26A61C5; Fri, 16 Mar 2012
 15:35:52 -0400 (EDT)
In-Reply-To: <7vlin4llwx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 13 Mar 2012 05:34:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E153FC6-6F9F-11E1-942A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193281>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> Sounds OK from a cursory read, except for a few minor details.
>>>
>>> Thanks.  Nitpicks follow.
>>
>> I'm taking them all. Here's the result:
>
> I'd hold onto this version for a few days before I paste it in my
> blog or send it to k-list in order to give others a chance to
> improve the text further, but this looks good (obviously) to me.
>
> Thanks for getting the ball rolling.

So a few days passed, and I do not think we heard anything from anybody.
I am not sure if that means everybody is happy with the wording of the
draft, or simply nobody cares, but unless I hear from anybody further on
this topic, I'll start my part of distributing this to where I feel are
appropriate tonight [*1*].

People who want to see the default changed, please help the message to
reach corners where mine wouldn't reach.  For that matter, people who 
want to see that the default remains the same, please do the same.

Thanks.

[Footnote]

*1* The places I have in mind are:
 - This list (which may be pointless)
 - linux-kernel@vger.kernel.org
 - http://git-blame.blogspot.com/
 - http://gplus.to/gitster
 - http://gplus.to/git
 - Google internal (there are a few users at $DAYJOB)
