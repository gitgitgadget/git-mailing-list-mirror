From: Junio C Hamano <gitster@pobox.com>
Subject: Re: file names
Date: Thu, 09 Dec 2010 09:51:51 -0800
Message-ID: <7v39q6hm14.fsf@alter.siamese.dyndns.org>
References: <AANLkTikeAFj68Rr35gcf4dxXXHU+au9wA7wd+-WB3BSS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 18:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQkf1-00035E-RP
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 18:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab0LIRwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 12:52:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0LIRv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 12:51:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C0963886;
	Thu,  9 Dec 2010 12:52:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1W/+FTa/qwct+uZkXoIajwI2jNY=; b=n0sF4t
	rnDT4CHLRAHlXUaC6ksAinJ/Tez2NJYQVjA42eFgeSnILkBSz5ktHOAeOXVr/IcP
	WVZ3mG+etj+nM2GTd/fF/dA5M1GcAGAYgOtOMw/9fgkzMwEsgo29Czf191ZZMqoS
	a5Pa0ObVjRc+8J5SA5RGpWep0A76c2IyS3zI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oBTv6fRgioJX62iXq5YJr0nsYwrnX0cX
	925WEcXgvx295FPx4nSXUU1UPXxyJeLiME+jSmrcwxin89SlDMYf/iPl52/inrfF
	SrcDWJW9USoymu3JZwcvTPaQhLTQNvq4NrK+CSIwIa/AtVxVXmeDiuU0iacLLCj/
	binpWCMLmXo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2560F3885;
	Thu,  9 Dec 2010 12:52:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3AA6F3883; Thu,  9 Dec 2010
 12:52:16 -0500 (EST)
In-Reply-To: <AANLkTikeAFj68Rr35gcf4dxXXHU+au9wA7wd+-WB3BSS@mail.gmail.com>
 (Thiago Farina's message of "Thu\, 9 Dec 2010 15\:05\:33 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11A9884C-03BD-11E0-BE2F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163298>

Thiago Farina <tfransosi@gmail.com> writes:

> So it seems from this data, there is a preference for naming files
> using dash over underline.

Yes.

> So the question is, should the files using underline be converted to
> use dash instead?

If this were before v1.0.0, it might have made some sense, but not at this
moment.  So the answer to "should?" (or "could?") is a firm "no", which is
always different from the answer to "wouldn't it have been nicer if they
were named differently?"

Or just after a large version bump (say 1.8.0), perhaps.
