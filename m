From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Sun, 03 Feb 2013 12:23:42 -0800
Message-ID: <7vlib587u9.fsf@alter.siamese.dyndns.org>
References: <1357314431-32710-1-git-send-email-wildfire@progsoc.org>
 <7vhamwse2c.fsf@alter.siamese.dyndns.org>
 <CAM1C4Gm_ea8DgrVhnp_MHmqaF6pyDe98EDA_BPkjvc8M5AO6FQ@mail.gmail.com>
 <7v1udzqv1v.fsf@alter.siamese.dyndns.org>
 <CAM1C4G=mKzfgrfO-n_yXjyDkZ9vA7H6kQEY5Yja-5C-YRRLmyw@mail.gmail.com>
 <20130203201217.GB3221@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.org>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:24:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U266s-0001zL-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 21:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab3BCUXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 15:23:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab3BCUXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 15:23:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2542B27E;
	Sun,  3 Feb 2013 15:23:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPe5szbbn2KPK1gsyCj7UCSkZ80=; b=yOTOBd
	mM9mgQcOxtGhdSvd5RjqgrJzHwtYNv+8JYsLclNGoA2PCV4XTSWfBBiGfLQ5QGyx
	4Ir4anXJieXn3FzAHYR6ZXlfmM1avLXZa48BfiRaOJSiCcCDhJ27QkFtTOgqq0F/
	y9zZ7lEwlSpqmmhLbW+bCPuPji1kchBVKe+m0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OngVQEgYGVn8NG72AhhfBbqFwAa/ig04
	euaCcz+BOFo15wZlOMSMxUsIqLMyOE0IFVlKuFFBe2rC8L8u1AqW64IjHpi6Z6Ba
	nQKR6aM34fX0MaifeOdxdUFjQJcxPYAEOvvRFiZ5RMcp08SNYpv8feZBfnxHMH6A
	ohhz9LNzXkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C28B27D;
	Sun,  3 Feb 2013 15:23:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D056AB27B; Sun,  3 Feb 2013
 15:23:45 -0500 (EST)
In-Reply-To: <20130203201217.GB3221@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 3 Feb 2013 12:12:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C49EE80-6E3F-11E2-9158-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215331>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Anand Kumria wrote:
>
>> I've not been able to find the canonical location of your gitk repository.
>
> Here's how I find it:
>
> 	$ git clone git://repo.or.cz/git.git
> [...]
> 	$ cd git
> 	$ git log -1 --oneline -- gitk-git
> 	ec3ae6ec Merge git://ozlabs.org/~paulus/gitk
> 	$ cd ..
> 	$ git clone git://ozlabs.org/~paulus/gitk.git
>
> Patches, including documentation patches, go to git@vger.kernel.org,
> cc-ing Paul Mackerras.

Or look at "A note from the maintainer" posted here every few
months.

	
