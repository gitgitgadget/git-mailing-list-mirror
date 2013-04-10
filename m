From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 13:21:12 -0700
Message-ID: <7vli8qkuh3.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <20130410195256.GA24177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Ngu?= =?utf-8?Q?y=E1=BB=85n?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:21:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1WE-0003wc-4b
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936386Ab3DJUVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:21:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936370Ab3DJUVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:21:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A66411536F;
	Wed, 10 Apr 2013 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X39gIzSdPX6bukywCQWxoTG9aLw=; b=sR+TDg
	kgnPgMRjBSD200aEosnu4bbrZ8ukkA85rPNdTO/8F50WCq2snNV2SRXblOVjg3Bg
	URITMI5HJqLEJ5zWHIykOa4s1kxRSCIaNTLhGzfkEKVnKXVQnEU+8AMKCMr2tX3U
	Ni+7hlqwPQTTnkgd/VtDJcfY3ZZnJ5sCfRu2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yee2OygzcbBiD4VNs70xhVS6nxPdFUQ9
	nR2QJkBTDhP4xDp83jdg11TfU9ex8m7KGtPKUSGjDAzoVGfrld58n3j6z3MD2zsj
	ag9kG+C/3F2K0WdJj16t6X3eXy65UmRBfkG6OXR2+Uz3Lf8iC/smU51KvQyCa8hX
	/rSUtIHjY4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 944241536E;
	Wed, 10 Apr 2013 20:21:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E11071536D; Wed, 10 Apr
 2013 20:21:13 +0000 (UTC)
In-Reply-To: <20130410195256.GA24177@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 10 Apr 2013 15:52:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 310A93AC-A21C-11E2-AB2C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220753>

Jeff King <peff@peff.net> writes:

> If we changed push.default=matching to ignore branch.*.remote, then that
> would be consistent, and would probably be safer over all. It is a
> regression, but I doubt that anybody was using branch.*.remote for this;
> it really only makes sense with the "upstream" mode.

True.
