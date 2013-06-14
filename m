From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 10:09:46 -0700
Message-ID: <7vip1gpqjp.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
	<7vli6crau5.fsf@alter.siamese.dyndns.org>
	<7v61xgraba.fsf@alter.siamese.dyndns.org>
	<CALkWK0m6iiDAmbxG9wrpgxJ3=nM816U7RM519Mu62qSgDwJbaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 19:09:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnXVa-0001Yv-47
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab3FNRJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 13:09:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab3FNRJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 13:09:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E923327FD2;
	Fri, 14 Jun 2013 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yjqQumH8Y5g/85vsKskialmK4sk=; b=mRWlWQ
	rrzC8USK95K4jIFZ9E0lSi+3OR1jeSzJ67RXmHXwWl8ZxNh5dU1ytCxHWJEcgrIj
	7fqqoQahhZ37Ehlxmc2yy8rEc4SZWpp7vv57tOm0rAvRAH//ZLvo03hSxielzG5Z
	kLVrJl6uxuJ8Ay5ce4lsw3Bf+XBpihONrkgc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rD2Bdf6yJ7lGOT3lZtaBrkRo30r1cALk
	iz3MYKNIKbGpyy2vUIUgI2wsFhIE4h/kul208kl+nCW1SC6brN3PIu+UFzm8OPEA
	vsID7HDn0EWsyyRKA6LITdtdZ0V1NfCOmNDa3W1MRLf4qNPhDIvzruNKH5kb+fab
	aA/eknEmm60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEB5827FCF;
	Fri, 14 Jun 2013 17:09:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6158227FCD;
	Fri, 14 Jun 2013 17:09:48 +0000 (UTC)
In-Reply-To: <CALkWK0m6iiDAmbxG9wrpgxJ3=nM816U7RM519Mu62qSgDwJbaQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 21:43:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37F04CBC-D515-11E2-9ED0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227899>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> And then the message triggers at the second test in t3420 when
>> applied on top of 587947750bd7 (rebase: implement --[no-]autostash
>> and rebase.autostash, 2013-05-12) or 45acb7592825 (Merge branch
>> 'rr/rebase-autostash', 2013-06-11).
>
> What was triggered?  (I didn't understand what you said)

The patch applied on top of either of these commits will *BREAK* the
second test in t3420.
