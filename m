From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] branch: list branches by single remote
Date: Thu, 25 Aug 2011 11:02:47 -0700
Message-ID: <7v7h61mks8.fsf@alter.siamese.dyndns.org>
References: <4E383132.3040907@elegosoft.com>
 <20110804040646.GA5104@sigill.intra.peff.net>
 <4E4A729D.9030906@drmicha.warpmail.net>
 <20110816151448.GA5152@sigill.intra.peff.net>
 <4E551548.9090807@elegosoft.com> <4E551AD0.7050702@drmicha.warpmail.net>
 <7vei0apsj9.fsf@alter.siamese.dyndns.org>
 <CACnwZYd=pM+fRNy0pqv+jR9bb0AWC89nkgHq3m1nMw9cUfHOQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Schubert <mschub@elegosoft.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 20:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QweGZ-0006rn-En
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 20:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab1HYSCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 14:02:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111Ab1HYSCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 14:02:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D77546CF;
	Thu, 25 Aug 2011 14:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e2VFJ8OA7ppzkaY1Iww7M7atVEE=; b=vbcDwD
	UkfbH7bsdG4rkg0z+RcFLGx7HddD1B2WEBQwO0eIMUbNti407otUkbP+W7wLqss0
	jSny/oU6OF/uHDdcNFDFCKXBefn7nLjMCIqx0NFYuRHC9nB5Xvl5qNwJCIRzWVf0
	im/bAk0CPhOy1XJlq5YrPFRwYa+lbM8VlYYck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1U9C9u6aolUkFavZa7GKTKNQtVazl+S
	uhn2YVxWGudoaVmo7FWStNUxyDILBRGgSxyPlA3lgOK16NYVvRTXGyoE7BzEDzXb
	urnKJaxgK7CB7hPol3zH0ZxRFMy3dPc5nrRWh9DipdrEI0PvtNqfBDCoRTUxN1Vz
	WZAZFlHSb84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1407746CE;
	Thu, 25 Aug 2011 14:02:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A89E246CD; Thu, 25 Aug 2011
 14:02:48 -0400 (EDT)
In-Reply-To: <CACnwZYd=pM+fRNy0pqv+jR9bb0AWC89nkgHq3m1nMw9cUfHOQw@mail.gmail.com> (Thiago
 Farina's message of "Wed, 24 Aug 2011 23:31:57 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7151CD92-CF44-11E0-97FA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180094>

Thiago Farina <tfransosi@gmail.com> writes:

> On Wed, Aug 24, 2011 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> [Footnote]
>>
>> *1* It does not have to be a weekly _posting_ on the list but can be a
>> well-known Wiki page or even a bug tracker. Whatever medium is used for
>> this purpose, there _must_ be a built-in mechanism to expire entries away
>> that are inactive for more than some reasonable limit (say two to three
>> weeks).
>
> Host the project on Google Code for bug tracking? Use rietveld for
> code reviews (ike codereview.chromium.org and codereview.appspot.com)?

If any of the above expires entries by default unless explicit actions
are taken, I am personally fine to go with it.
