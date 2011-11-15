From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] upload-archive security issues
Date: Tue, 15 Nov 2011 15:40:51 -0800
Message-ID: <7vehx9t0n0.fsf@alter.siamese.dyndns.org>
References: <20111115214159.GA20457@sigill.intra.peff.net>
 <CABPQNSZ71==pQvH9nTQ3rD6c1RJiLmkA+k_9KS=T45cQb+PTLA@mail.gmail.com>
 <20111115222320.GA28646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 16 00:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQScc-0004mZ-If
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 00:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab1KOXky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 18:40:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab1KOXkx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 18:40:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2557960D6;
	Tue, 15 Nov 2011 18:40:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZwT3c+/A+oXZ999YywNVss9/QdE=; b=WCmDbr
	OKiTVcnb9BTe420PbFzVjiF8jHZHdBxakEorG1xQvBlsc2zPV/CICFX/gqNj0myV
	0jO65zBrJSr/uoHq6uZtL0GGSyv0eKcbNWitpbaSGdUVFfcf7Tc+sCuRB5Iwcc7Q
	VAaJdoZ0fyfxYK3Lxw7ycEtZTYBOQ0ZUqyZL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxClg4+a/h6OsX9KNU0PxoXlxoHJolfg
	Amdy4fuHipLU7ZTDdB12MYn1TAc89/ZGyBPVnynQXrbYZOB8BgkHLiqFutl3rnFh
	LCGUj0AknGKjfP4ITSeuYEzOgoeXbwJ/Cu8Cq+3480Y5zLzWQdDqSPxbgVkDv1VP
	MTr4RozmXr0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D5BB60D5;
	Tue, 15 Nov 2011 18:40:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A60460D4; Tue, 15 Nov 2011
 18:40:52 -0500 (EST)
In-Reply-To: <20111115222320.GA28646@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Nov 2011 17:23:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41530D24-0FE3-11E1-8932-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185500>

Jeff King <peff@peff.net> writes:

>> For the record: I would be fine with c09cd77e simply being reverted
>> for this release, and having a better version applied in the near
>> future. Windows support for upload-archive is not worth the risk of
>> slipping in a remote code execution bug...
>
> I'd be OK with that, too.

Ok, that is easier ;-)
