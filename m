From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Thu, 11 Sep 2014 14:40:03 -0700
Message-ID: <xmqqk359defg.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSC69-0000s1-PX
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 23:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaIKVkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 17:40:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50356 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbaIKVkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 17:40:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 870A33A299;
	Thu, 11 Sep 2014 17:40:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/P2g6TTy51NDYK/RB5wJF8OfyFA=; b=poMntF
	HgC6hN/3rTzlrzrJUmlM4Z6jKyefc134I07gOsuwZ/WRp+PD/UgmYpSEAyIX/SfU
	QZeQt98Hq5ZsEn0Vj807/GaBr4aNoAwnmUFemhsi0ImGqAH9opjZs10OfKUF18Jr
	t4XHWJutwISXC8Q7RYurCDNVv99wWY6XZtt9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NT0guGcyp2otxlHXM0SC/mBvsALq1SZS
	DI6BBML9ATIexvanDRjMQHIK0i0HnNdJy80SLxCNi2jL/ZEf9tDCEoyQT5ycOKUA
	fIThzjQGz7Xlnr0C9Q2sz6rqx8iEPB/8UEQECqro4NaSfsApama0VhXhxSK3jBai
	pqqFCWGcNqk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B4083A297;
	Thu, 11 Sep 2014 17:40:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E48273A295;
	Thu, 11 Sep 2014 17:40:04 -0400 (EDT)
In-Reply-To: <20140911030318.GD18279@google.com> (Jonathan Nieder's message of
	"Wed, 10 Sep 2014 20:03:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 314AD204-39FC-11E4-995D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256882>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> The next series from Ronnie's collection is available at
>> https://code-review.googlesource.com/#/q/topic:ref-transaction in case
>> someone wants a fresh series to look at.
>
> Here is the outcome of that review.  It could use another set of eyes
> (hint, hint) but should be mostly ready.  Interdiff below.  This is meant
> to replace rs/ref-transaction in 'pu' and I'd prefer to wait a little
> for more comments before merging to 'next'.

Alright.  I'd assume that all the other rs/ref-transaction* topics
that depends on rs/ref-transaction series will be rerolled on top of
this new round when ready.

Thanks.
