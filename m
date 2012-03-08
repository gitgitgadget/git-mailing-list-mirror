From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: fix ls command with empty path
Date: Thu, 08 Mar 2012 08:39:56 -0800
Message-ID: <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:40:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5gNo-0000pr-7W
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 17:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988Ab2CHQj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 11:39:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269Ab2CHQj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 11:39:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A7D7A34;
	Thu,  8 Mar 2012 11:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58/LAd7Ti9skmyUoLd3Qe4H+Tvg=; b=C1szI1
	CV7TiuhBxFGBEi4ziCPYleO61QmKCutJuZlmww/6ukcWkTmPK15bmcyc7Bdw4mrc
	UacvRTnQFXKA0yZmAUj9LwsBXRrGIjE+dVsNeyYzMsunose8mQ3IAaZ+X2L2VRPU
	jDiZHkyfaoBfddraabRe6CwvnTXaBxKbH8h6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHIfkjPBVEoBoJf5QiynRVjNZ/S6k4qQ
	ej/6WbjiK19nAA21rYGAPBzMiyhn2n6voLmRTFuFkMQ+XnHIW7H75kT5NNfwExbc
	M6ZA2DMrlVHCAgzn/8v+OLGFVIzLc9ieFL1/sg/1XTnN89fthR1xMT+K3rJHJ29X
	6oJxtSJiKm4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80ED67A33;
	Thu,  8 Mar 2012 11:39:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D360C7A2F; Thu,  8 Mar 2012
 11:39:57 -0500 (EST)
In-Reply-To: <20120308070951.GA2181@burratino> (Jonathan Nieder's message of
 "Thu, 8 Mar 2012 01:09:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5775CA20-693D-11E1-84B9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192617>

Jonathan Nieder <jrnieder@gmail.com> writes:

> For what it's worth,
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks very much for taking care of it.
>
>> [Subject: fast-import: fix ls command with empty path]
>
> I would s/fix/accept/ to be more precise about the nature of the
> breakage.  (In other words: rather than mishandling ls with an empty
> path, fast-import was not handling it at all.)
>
> ...
> (good).  What do you think?
>
> -- >8 --
> Subject: fast-import: allow filecopy to copy from root

So what do you guys want to do with topic?  My gut feeling is that
this is not a new regression and can wait until the next cycle.  I
could certainly carry David's patch in 'pu' if doing so helps the
discussion to come up with the right solution, though.
