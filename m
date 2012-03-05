From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Mon, 05 Mar 2012 14:46:28 -0800
Message-ID: <7v1up6zmwr.fsf@alter.siamese.dyndns.org>
References: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
 <CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4gft-0007Ao-45
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 23:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab2CEWqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 17:46:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582Ab2CEWqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 17:46:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC827DE6;
	Mon,  5 Mar 2012 17:46:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XsHDU/fOzIP0McU+i7+HnOv5YDY=; b=lI1Y1b
	m9wJkdBr/RYdx7iUTY9iOOGBUgEtv0J58LekMfdOuQqSUAuCv12RiLE7nfcG94XU
	AWYjnOXQdrpVPeU8Ow64qunfD4S+XFN9WDPHJfb3RYTS79aCObKzaOCmc1r+c69e
	Wyuh4Fy0FPeqro7L88WtyBdfGJ/WnKAejxTnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KmeP6XHWtxItlTVqqJr62hF5X7W36gQf
	Egshj34dbU2EU4KaRZQjhwpuycsR54bzzYErTcN7Csk4mvMssXYFt3fgra91opoI
	hy2fjGhKlq9fqMFAd2IOsQ8e9CPVxrjdPhJu1evaxFjTNeS7tPyYVEWCc5tCcWmU
	Ap/CzFuRijg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 024497DE5;
	Mon,  5 Mar 2012 17:46:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D49D7DE4; Mon,  5 Mar 2012
 17:46:29 -0500 (EST)
In-Reply-To: <CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com> (David
 Barr's message of "Tue, 6 Mar 2012 09:34:08 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C48AF38-6715-11E1-8E4F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192282>

David Barr <davidbarr@google.com> writes:

> On Mon, Mar 5, 2012 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> You can find the changes described here in the integration branches of the
>> repositories listed at
>>
>>   http://git-blame.blogspot.com/p/git-public-repositories.html
>
> Just a note that the htmldocs are readable at:
>   http://git-htmldocs.googlecode.com/git/git.html

That's good to know.  Even the cross reference links work ;-)

It is different from the URL of the document that lists repositories
I gave above, though.

> Also, they would be readable at:
>   http://gitster.github.com/git-htmldocs/git.html
> If the branch gh-pages existed and mirrored master.

I have no idea what you are talking about here, sorry.
