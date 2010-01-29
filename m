From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 19:03:36 -0800
Message-ID: <7vtyu5k3xz.fsf@alter.siamese.dyndns.org>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
 <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
 <4B6201BC.9030800@web.de>
 <69b754db1001281338l58eb4b84t5a5725de294b6cc5@mail.gmail.com>
 <20100129090345.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Linck <mgl@absolute-performance.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:04:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nah9M-0002Ff-1d
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 04:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab0A2DDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 22:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182Ab0A2DDw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 22:03:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab0A2DDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 22:03:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87F9595798;
	Thu, 28 Jan 2010 22:03:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GiXxib+kDQJD683CCmcTJO1eBuU=; b=fIFITG
	lRQtwZh8iLjiG3jlhRHaXyO/jiaUoAGmZa2XmEb7Pb8HARuIxrqVpqPdqIsBao4G
	H1iGM01VaOe4mWZCo7QpkoeZwbZZyD3invdGFo73b2Aiy5RRp68cxTZaBI3z9I07
	RweCUff6SCwrzZg6dCAgtoisXM2sHBIJbX42g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q6xJ63Y+eRYlJCg9swTEj6LQ3bt39GbU
	G5sMSqW/m4cHoJ+gkgbY+dasB8e6B1B/nltcb7GxEnchRdlD9gD4t4HljKuy7fZP
	b33sjgx6r5nB/diDRWa3PKSQ60EQpxSjoVObJR9OCioWBG/dXqXeSzjIvx7j8QpE
	SE//Glbpd80=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B0A295795;
	Thu, 28 Jan 2010 22:03:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3662795794; Thu, 28 Jan
 2010 22:03:38 -0500 (EST)
In-Reply-To: <20100129090345.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri\, 29 Jan 2010 09\:03\:45 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9334CFE-0C82-11DF-A7B3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138297>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Mike Linck <mgl@absolute-performance.com>
>
>> Could anyone point me to a good book that actually describes the style
>> of code management that git was intended to support?
>
> You may want to add the result of googling 
>
>   "Fun with" site:gitster.livejournal.com
>
> to the list of Git documents you read. "Fork from the oldest branch" is
> one of the techniques Junio teaches often and many of his other
> techiniques are built upon.
> ... It is a useful substitute until his book gets translated to English
> for people who don't read Japanese.

Quite honestly, I don't think my blog articles are all that good;
certainly not as good as the book, as I don't draw pictures.

For this particular topic, I would instead recommend:

    http://nvie.com/archives/323 (A successful Git branching model)

What it teaches isn't anything earth-shattering (it's the same old "how to
use topic branch effectively" and I don't necessarily agree with the
choice of fork points of topic branches depicted in the article), but
people seem to like its graphics very much and it is scoring quite high in
delicio.us.
