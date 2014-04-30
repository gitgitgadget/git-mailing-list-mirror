From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] t3905-stash-include-untracked.sh: use the $( ... ) construct for command substitution
Date: Wed, 30 Apr 2014 11:07:17 -0700
Message-ID: <xmqqiopqg08a.fsf@gitster.dls.corp.google.com>
References: <1398874987-14873-1-git-send-email-gitter.spiros@gmail.com>
	<vpq4n1alqf2.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfYum-0004Zt-3M
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbaD3SHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:07:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945910AbaD3SHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:07:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E867B7D744;
	Wed, 30 Apr 2014 14:07:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWVJybEqYHNcrYo6ChDsE5ppZyk=; b=QWy3Z/
	STFni2Ads6YH7MnANunns987prSVJ+yb8WcewqGO6nSWsIKCPQprlM4Udn5fjhx3
	4QmV/at+sct4QZyiVY8t3emFQEnCqZ5WAuMWL/g/0QEg8wwvcxLDVlqziTTA1Dji
	eUR1nFA9Nj+X+DC1TEIDhPG8EQjOiSLblMsmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7T626tlP5RuFDGe408D0LBKf1p8bIUz
	mflUYA+jvvNnkERzyVhC8NzPRQTe5zgOCyWV7i5FIRUxy+9RE/+geiK0Zyv+P9Cd
	ntz88qxW8tF6lROajIHYIRNVpevL0ifx03nRMmxFxZ0FguSbr+/JfbB54JwvNtts
	p2OUSVqwME0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3367D743;
	Wed, 30 Apr 2014 14:07:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C74F7D73E;
	Wed, 30 Apr 2014 14:07:18 -0400 (EDT)
In-Reply-To: <vpq4n1alqf2.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	30 Apr 2014 18:42:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44A43490-D092-11E3-B86F-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247751>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Patches 1/14 are
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> On a side note, reviewing patches by batches of 14 patches actually
> turns out to be much less convenient for me than reviewing larger
> batches.
>
> If I'm counting correctly, there should be around 100 patches remaining.
> I'd suggest that the next batch contain them all (probably publishing
> the branch somewhere and posting a merge request here would be better to
> avoid sending 100 mails).

I eyeballed these 28 patches so far (but not this round yet) and
each of the batches did fit my attention span for a series while
looking at other topics also in flight.  Tastes and preferences
differ between us, I guess.

I however can, and am very inclined to, trust your review blindly
and apply further patches on this topic with your Reviewed-by:
without even looking at the patches myself.  If "give us the whole"
is more convenient for you, I am perfectly happy with that approach.

Thanks for reviewing.
