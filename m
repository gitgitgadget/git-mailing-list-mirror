From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Trivial fix: Make all the usage strings to use the 
 same pattern.
Date: Tue, 22 Sep 2009 22:16:57 -0700
Message-ID: <7vvdjajl4m.fsf@alter.siamese.dyndns.org>
References: <1253639330-9185-1-git-send-email-tfransosi@gmail.com>
 <7vocp2ssv4.fsf@alter.siamese.dyndns.org>
 <a4c8a6d00909221255i2f45e19ex95a13b027886d3e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 07:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqKE6-0001UM-1Y
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 07:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZIWFRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 01:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbZIWFRD
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 01:17:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbZIWFRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 01:17:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3842A5B39A;
	Wed, 23 Sep 2009 01:17:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=o5dABj6+Mt4ZD753v50rwn4agLg=; b=xogJTvf3/9C3a+5SHcEPv8c
	zsyOtqzEFiayWWCvYc5NugGbSW7XxHe86/O2FPJ0xP0F8jvlR8lr0leJYJu2r7Nm
	b3fq9y1nqD9olazIldlZKsRKuhkakH9wR8wkjez2VHNIvB7L73JtLIJ/GlG/0hda
	tLETKfNfKVUlNhVJHE1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=B2AP+9LfefykP3HnPvOk0bHVRSOafXLfgIzf3NlUnZ0pRUTby
	ZFHyhOM5Nw9NS6eHd0S5fmtrP3j7OUNJRpZKnNqM/oW/LXKbeYCuzJ5mzDAccWdC
	o4XD/eVxSDohPwQiHjaUXtYWdbcPcBAp9mMYpQy8RjT9vq7XFPkWKEVdck=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 142E35B399;
	Wed, 23 Sep 2009 01:17:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E52715B398; Wed, 23 Sep 2009
 01:16:58 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 536215D4-A800-11DE-A89A-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128968>

Thiago Farina <tfransosi@gmail.com> writes:

> On Tue, Sep 22, 2009 at 4:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> What does this _fix_?
> The answer here is nothing. But I think the benefit is to a have a
> pattern, but if it is _not_ desired, I can stop here.

That was not what I asked.

    What does this _fix_?  Does the benefit of this patch outweigh the
    cost, and if it does, in what way?

Does the benefit of "having a pattern" outweigh the cost of this patch?

That was the primary question.

The same patch, depending on the time it is considered for inclusion, can
have different cost.  Because it is about cost vs benefit ratio, asking
"is it desired?" has no black/white answer.

If we were writing git from scratch, we would have written things in a way
that matches a certain pattern, so the answer to the question for any
"needless churn to bring a pattern in" patch would be "yes", but that is
only true if we _were_ writing git from scratch.

But because we are not, changes involve some cost. Is it worth the pain?
What is the best way to minimize the pain, and when is the best time to
apply such a patch?  These are the concerns a maturing project has to
worry about a patch like this.

The answer at this point is a _very_ qualified "maybe".  Yes, if it were
pain-free, having a pattern would be much better than not having one.  If
on the other hand if that means people need to re-re-review 2500 lines of
patch every 15 minutes and I have to resolve needless conflicts,...

If I were you, I'd pretend as if I have only one chance left, and try to
come up with a perfect [*1*] patch that does not touch any file that is
different between master and next, and follow it up with a set of separate
patches for files that are different between master and next, one patch
per file.


[Footnote]

*1* that means no "Huh?  Why is bisect_helper's usage named differently
from others?" kind of glitches anywhere.
