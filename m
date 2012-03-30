From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #10; Wed, 28)
Date: Fri, 30 Mar 2012 08:56:51 -0700
Message-ID: <7v4nt6nku4.fsf@alter.siamese.dyndns.org>
References: <7vsjgss6ua.fsf@alter.siamese.dyndns.org>
 <m3fwcrarwo.fsf@localhost.localdomain>
 <7vobreq2zp.fsf@alter.siamese.dyndns.org>
 <201203301313.01432.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 17:57:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDeCC-0002Vg-6P
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 17:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934136Ab2C3P44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 11:56:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347Ab2C3P4y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 11:56:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 678567DF5;
	Fri, 30 Mar 2012 11:56:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=050AO6VMlJ/K+u6z3VNQYykF8mE=; b=Swx6qQ
	7Btet8PYYUGgEXtUv8o5+38x+TS0Ms8NF4HBqVNm8VOSFw8a2WwtMFaLTTOrXlHW
	vzH2Z7QZJv5H5uRu3TWUmWkvdsN9lhLf7kXwXTWNgNLO3QjYjBA7be12dVhSxGWU
	1YVXdV/H/iviYP20sSBmUiKW1LpL2zzc96to4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M3//Z7foGs3fJQPIIeIwkjUelnXjG3ZD
	iHCDHcJMaHENFU1XeBHTehmoHprh6+OZh23zEgwQaZu6mw3OHjZI8b5cM6+49eEY
	xnhHeIe74TkjiSNOy2ZIHCzw2Y3zjoUGRq7zDpvgGQFkfUcJtAuhxjhuQWoIUbe/
	E99N9RXhMlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D3807DF4;
	Fri, 30 Mar 2012 11:56:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE0487DF3; Fri, 30 Mar 2012
 11:56:52 -0400 (EDT)
In-Reply-To: <201203301313.01432.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 30 Mar 2012 12:13:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7BC8AF6-7A80-11E1-A449-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194369>

Jakub Narebski <jnareb@gmail.com> writes:

>> I was waiting for the review cycle to come to a resolution.
>
> Ah, so you were waiting for review before even considering this
> series even for 'pu'...

It was more like "Putting a version from a random day I happened to pick
the series up and queue them in 'pu' and leaving it there while if it is
still daily being churned would not make any sense, because, I wouldn't be
able to keep up with it anyway; it is not my area."

> I think this series is in quite good shape, and I expect in next revision
> or two might be even ready for 'next'.  One more serious issue that I'd
> like to see solved is requiring untabify() run before format_diff*() vs
> having format_diff*() do it itself which is more future-proof I think.

Thanks for reviewing and helping the topic move forward.
