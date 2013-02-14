From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Thu, 14 Feb 2013 08:59:27 -0800
Message-ID: <7vd2w23k7k.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org>
 <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
 <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
 <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com>
 <7vtxpf341w.fsf@alter.siamese.dyndns.org>
 <CAH5451mMG-U8qETAy_6pRJLbtOjtAPhbapVA9RLbrrS2yy7rCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U62AG-00068s-PM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 18:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934776Ab3BNQ7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:59:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934337Ab3BNQ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 11:59:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76B8CC1DA;
	Thu, 14 Feb 2013 11:59:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bl5WYAQv49Woi59aSHUtVgbF7vI=; b=HDlddI
	nob0VVdVEVLiQuBm/bbHYgW9ANqv9RiUVlPxo8mYi1wyLEgwHoGM6I2pJMi8Faz4
	qSw0q+YSHCRhj6RKEMGvh99y6eXU1zve7ge/9nnbbajo07RRQf5nOtQWjkKPkL+K
	00yHN9rOd4kZJx51yRRwkdNPSUL7VOp8XC9ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CnRZmS6Ao3MPF1A4+g1Zif2q9KO4d1oq
	xT+o5stwXpZBTe4iHOEYGQeg/9BXQj/iXddrlf7wAZYqPBo+PYk7gcXAxgzTqAoj
	n9usU6La2GpTd9USs9MxJ3nPRhzvwvR11m/l1jBmB+zW8PKeD7ofXw3m+/9HFYdL
	L/e6syVgtoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B19FC1D8;
	Thu, 14 Feb 2013 11:59:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5D07C1D6; Thu, 14 Feb 2013
 11:59:28 -0500 (EST)
In-Reply-To: <CAH5451mMG-U8qETAy_6pRJLbtOjtAPhbapVA9RLbrrS2yy7rCw@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 14 Feb 2013 15:54:51 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4FCBE7E-76C7-11E2-A0A7-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216322>

Andrew Ardill <andrew.ardill@gmail.com> writes:

>> If that is the change we are going to make, and if you can guarantee
>> that nobody who is used to the historical behaviour will complain,
>> then I am fine with it, but I think the latter part of the condition
>> will not hold.
>
> Does the impossibility of asserting that no-one will complain put this
> in the 'too hard' bucket?

Basically, yes.  "Cannot be done without UI regression."

It could be a Git 2.0 item, if you plan the transition right, though.

> The implication here is that a relatively small number of people will
> be inconvenienced by needing to specify extra flags/set up an alias.
> Compare this to the many for whom the expected behaviour is now
> default, and we have a net win.

We take backward compatibility a lot more seriously; it is not even
a democracy.

"Net win" does not mean an iota.  Even if "small number" is 47 and
large majority is 4 million, it does not change the fact that you
are breaking things these 47 people have depended on working in an
expected (the "expected" does not have to be "intuitive" in this
sentence; what counts more is that it is the way they are accustomed
to) way and introducing a UI regression.
