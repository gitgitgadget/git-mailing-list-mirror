From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Signed tags in octopus merge..
Date: Mon, 16 Jan 2012 14:49:51 -0800
Message-ID: <7vobu3uusw.fsf@alter.siamese.dyndns.org>
References: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:49:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmvNG-0005F1-VC
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab2APWty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 17:49:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab2APWty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 17:49:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A89C57BDE;
	Mon, 16 Jan 2012 17:49:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+BEN1LPbgeNQ6GwRIxOs4yldsmQ=; b=Vhyc+J
	CoKWolPSFwLMRlW2BS1chziHVTRH7zxrZcnRq5M3rR/S6v3ZNdQ+oQ5qPd3DX19L
	u2eRmQdt2ixxepi2eFhD3g0Ej0Svb4tklXWqqSRX08oUTyIbWcWsMime896DVFMB
	KcaQxItl0iq+YHGyHUCcsEUvC3ry2YVmmuQYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJX+vXWo2V8F77/kgBae9EuM3wye1rQA
	4pZSz0G5redzGJ9uKS15ZV80NgRyjGVuzyhWFl64kyRe35BDWlgcWbRqnM4qtLZm
	XS9nD6n6KQCiNhoIxVTc9T8QpK55ZoXCtoqarRYu1YzwYjccluO5/bfShWYvCrhM
	pp2BlAtWNFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A00F57BDD;
	Mon, 16 Jan 2012 17:49:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EBDD7BDC; Mon, 16 Jan 2012
 17:49:53 -0500 (EST)
In-Reply-To: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com> (Linus
 Torvalds's message of "Sat, 14 Jan 2012 13:30:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 675DC842-4094-11E1-B598-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188663>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Just a heads-up and congrats: octopus merges of signed tags work well,
> and did exactly the RightThing(tm), both at merge time and with
> "--show-signature".
>
> I knew it was supposed to work, but I have to admit that I was a bit
> apprehensive about it when I tried.
>
> Current top-of-head (commit 81d48f0aee54) in the kernel, in case you care.

I looked at it again, and it makes me wonder if we should further reword
it to say "side branch #1, tagged 'devicetree-for-linus'" instead of the
current "parent #2, tagged 'devicetree-for-linus'". It looks very weird to
start counting from #2, when we know we will never show #1 there.
