From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Mon, 12 Aug 2013 01:29:07 -0700
Message-ID: <7v8v071fe4.fsf@alter.siamese.dyndns.org>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
	<1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
	<20130809200101.GX14690@google.com>
	<7vr4e230g8.fsf@alter.siamese.dyndns.org>
	<7vd2pj1gto.fsf@alter.siamese.dyndns.org>
	<520898AD.8030406@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 10:29:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8nV5-0001jW-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab3HLI3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:29:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab3HLI3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:29:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE863417D;
	Mon, 12 Aug 2013 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0/NkgwAFYZuPXMFZXxm1YbB3E0o=; b=NqwkZC
	YCe8JzEYZA0PjBLEx5liqrP00b23zpAElM9nWwyQewTIzjAyPCi/Jkv/IQp3XR02
	yvCX4glnwUDXHSulOdE3zkdLigbv90t2fRDMwWIHz60dqQf/qKsUf9egiJN7Tbx7
	GiBX2oZc+jYq9o3J0M/e2eKAJwri8ZhnT0bIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KiZYP6oHJYYRklkHTXQWGf6wHmFcT5kt
	z6lVjvnABFY1KNWxlFh/mqJcpXyIX4fy5jgftoS3FcMEBObKE0eevWTXHnWFNQb4
	cfa4bd1QExn7caUpjvsLIj/KzaQZKSwns4nbZuUtY4oZCEACULH7Cw7Qi0gfPTFK
	LxAoc7b3yrI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6058B3417C;
	Mon, 12 Aug 2013 08:29:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA2C23417A;
	Mon, 12 Aug 2013 08:29:08 +0000 (UTC)
In-Reply-To: <520898AD.8030406@googlemail.com> (Stefan Beller's message of
	"Mon, 12 Aug 2013 10:11:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41FF8F0A-0329-11E3-AE51-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232176>

Stefan Beller <stefanbeller@googlemail.com> writes:

>> +# The 2 following authors are probably the same person,
>> +# but both emails bounce.
>
> You seemed to be sure about Nanako Shiraishi for example, 
> but here you're uncertain, whether he is one person 
> or 2 persons having the same name? 

Nanako did 70+ patches, and was on many discussion threads, which
made me feel that I was corresponding with the same person across
address change.  I however cannot recall this contributor with just
3 patches whose last contribution was in 2007.

But more importantly, this leftover "unreachable" comment I did not
notice before sending the patch out---I did not send any "please
ping back" message to any suspected current address for this
contributor.

> So in case you'd know he is one person with just different emails, maybe
> we could write 
> +Jason McMullan <jason.mcmullan@timesys.com> <mcmullan@netapp.com>
> as it doesn't matter which email comes first (both bounce anyway).

The last contribution was from netapp.com address in late 2007 (the
other address sent two patches in 2005), so I'd suggest making the
netapp address the canonical one.  If we cannot reach him, that is.
