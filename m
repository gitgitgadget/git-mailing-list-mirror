From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 07 Sep 2011 16:38:03 -0700
Message-ID: <7v7h5j2aas.fsf@alter.siamese.dyndns.org>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
 <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
 <33309DB6F935472497D9790A26046452@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle Neath" <kneath@gmail.com>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 01:38:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Rh8-0003dm-5H
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 01:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488Ab1IGXiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 19:38:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757466Ab1IGXiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 19:38:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18116586C;
	Wed,  7 Sep 2011 19:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oNRqf/MZdB5/RVkvvF5WRyjm1Ug=; b=Udobht
	la5RLoHSCxndexDUnCHE9wQ9r0hJlRwkr4xHtcflpkBeTvNkncQH5gnumP+IJP9j
	NHGEqvIMJOnPFRVi0KQnZ4ZH7g+A4pP+cLAEWkzodSz3uSd0aXM1beGwMkptJl0s
	KpErk6/4Pw+3GhPmtdWt59o2EI4XyPI2g/SXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EuE0Ovw0RLzBzyzNXoRi+a5UtRENiIhi
	kZEBH4UPhsUXMrui9iqwP6b+Bc8jIq/Se/di5rBlNgCJFjxqKb2VYPiFdoe4W24s
	PeA0ZwvopPvuLJYVRSuU1/ob4BDE5o3V6H73kelgE4iIW3rHEq+lKyaS8rPd56BT
	DkAAnMnPWnU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C50F586B;
	Wed,  7 Sep 2011 19:38:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C449586A; Wed,  7 Sep 2011
 19:38:05 -0400 (EDT)
In-Reply-To: <33309DB6F935472497D9790A26046452@PhilipOakley> (Philip Oakley's
 message of "Thu, 8 Sep 2011 00:01:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F3F3C7C-D9AA-11E0-99F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180929>

"Philip Oakley" <philipoakley@iee.org> writes:

> Would it not be possible for GitHub to provide for those key users such
> a trial version that includes the patches identified to obtain the
> "real-world success reports" that are needed, as mentioned in the "Re:
> What's cooking in git.git (Aug 2011, #07; Wed, 24)"
>
> This should help satisfy the needs from both sides, even if you can
> only push it to a few clients.

That would not help very much, as (1) we know what Jeff included as sample
keystores are more or less cooked and good, but (2) nobody in your style
of trial will come up with different keystore to exercise the API to make
sure that will not paint us into a corner we cannot upgrade without major
pain in the backward compatibility area. The "real-world success reports"
you can generate would only for (1) but at this point we are not worried
about that. We are more (much more) worried about (2).
