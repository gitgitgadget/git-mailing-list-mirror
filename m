From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] Documentation: pack-objects: Clarify --local's
 semantics.
Date: Thu, 18 Feb 2010 21:44:19 -0800
Message-ID: <7vk4u9wzik.fsf@alter.siamese.dyndns.org>
References: <1266550170-17013-1-git-send-email-nelhage@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Feb 19 06:44:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiLfH-00030L-9E
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 06:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab0BSFo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 00:44:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0BSFo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 00:44:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE2C9B8C2;
	Fri, 19 Feb 2010 00:44:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJUGnsDbyJvqgDLLYKTRKwux/7c=; b=sSrA9v
	KLA3F21WO9nQa/gKGOinM009Jf0A72coPlJh5oKRgPAmWZR1UnqGNtY+stv3mfj3
	AY/ujNhJMQDnp2gdPvN8TTw1WHkkT5sH8yABIg7UcKG7sYGvi/WW4YacIwgNwpi1
	yHg5BUnI9dVjjb93K0mPbPUTp0U1olk60U+a4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QkqO2UAw+sYNlomYBmMhoWfc7TKGmFKA
	Gswer5ve4Hr9uWm0xtj/6Iz5RE+1rIg3DSbR3luncEg1V2oD+pkE4xA+OPI3XNSN
	MMjNFgNG93czSXdO+sbiATabNEwHxz0Q/t/pFWhRu9yRM2N3ttsX3LwO4PJJci2A
	5JEzpBmJAMU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E689B8C1;
	Fri, 19 Feb 2010 00:44:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 894659B8BF; Fri, 19 Feb
 2010 00:44:21 -0500 (EST)
In-Reply-To: <1266550170-17013-1-git-send-email-nelhage@mit.edu> (Nelson
 Elhage's message of "Thu\, 18 Feb 2010 22\:29\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D62F2982-1D19-11DF-8DC4-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140410>

Nelson Elhage <nelhage@MIT.EDU> writes:

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index f54d433..d8e5686 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -117,14 +117,13 @@ base-name::
> ...
>  --local::
> -	This flag is similar to `--incremental`; instead of
> -	ignoring all packed objects, it only ignores objects
> -	that are packed and/or not in the local object store
> -	(i.e. borrowed from an alternate).
> +	This flag causes an object that is borrowed from an alternate
> +	object store to be ignored even if it appears in the standard
> +	input.

Thanks.  Comments from "packing" experts?
