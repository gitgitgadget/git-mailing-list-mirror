From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pretty placeholders for reflog entries
Date: Mon, 07 Nov 2011 15:41:19 -0800
Message-ID: <7v8vnr1oww.fsf@alter.siamese.dyndns.org>
References: <CAMYxyaWPWVGUHz0qQOnARb9wexHCx73a04Bu_UhrJR=xrinX7g@mail.gmail.com>
 <20111107211325.GB7380@sigill.intra.peff.net>
 <CAMYxyaWJO7e8Lg__8N9BhL16mwfQtd-GBuLpBSCYmLMZ3gsMPA@mail.gmail.com>
 <20111107224556.GA28188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jack Nagel <jacknagel@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:41:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNYoi-0007PW-C4
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 00:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab1KGXlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 18:41:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab1KGXlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 18:41:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46B6E6A9D;
	Mon,  7 Nov 2011 18:41:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6Wk9iocbEDB4F7t8bNQW8q09Ac=; b=VC+FjN
	/dp1ukylh7E2vQZz5v2I0vhW5qQ4G5xIzYZq2jPZpG7z1s1bud6u4UrIQZHMgzZ5
	XqzldZHHYguppO7IU9v/PMUm6uC7EvN8FatTuyJvSvaXXF4qKJeNoX7mddgn/UQ9
	ZwwuDU0ra4dP+BxCUsgPX5lFvsEVCR5QqBUNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FMK7irKovQfPZ6rJ1z/acOhJZ3d1andG
	V7UfNrzJsQh7qqjYT/+BI5fKOsLACM34ttoynkfrdfGPAuO2fdR0adF5k7BcRjkO
	GrUrzQoQC8VVaBDW/yiRLe54A8f+5Icu6B/ee9iu1aj6s+K3xzyph0394Fps+0zz
	iSBP6aTXOgE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB956A9C;
	Mon,  7 Nov 2011 18:41:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D9B76A9B; Mon,  7 Nov 2011
 18:41:21 -0500 (EST)
In-Reply-To: <20111107224556.GA28188@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 Nov 2011 17:45:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF3C3306-0999-11E1-A28F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185047>

Jeff King <peff@peff.net> writes:

> It would be a little nicer to provide explicit date placeholders, but we
> can't quite make them match the author-date specifiers, because "gd" is
> taken.  We could add %gt, %gr, etc. But in the long run, I'd like to
> move to considering most of %ar, %at, etc to be historical, and have
> something like "%ad(short)" be the official way of picking different
> date formats[1]. And then the reflog placeholders could learn
> "%gt(short)". So making more reflog placeholders right now just feels
> like cluttering a namespace I'd like to get changed eventually.

I tend to agree with the direction.

As we are not adding anything new before the 1.7.8 final, I'd rather ask
you to hold onto this and other changes in your footnote, instead of
having me to carry them in 'pu', which is an integration branch even less
official than it would otherwise be during the freeze period.
