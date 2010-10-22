From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 16:22:03 -0700
Message-ID: <7vk4l9ke3o.fsf@alter.siamese.dyndns.org>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 <7vocalkf53.fsf@alter.siamese.dyndns.org>
 <20101022231820.GB25520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 23 01:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9QwG-00016F-9x
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 01:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab0JVXWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 19:22:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab0JVXWO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 19:22:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 482F9E0CA4;
	Fri, 22 Oct 2010 19:22:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j3xsei/KbMgf
	w6K6VfCXL9sOZ4U=; b=ndwOSHMrpJQh6yxmlJOQd9B0nWhfP+DV8A/OeWvBf/YE
	cEFTQ7hI+PyGmzIhLKTtwf9goc+wPrhbe3RoDdyTejDnTme/0oUwMajySzIe2D6q
	qg0GSEg5atO78YcEYwMLZIs9ZKEJRhb3ph/ly1zikAwgsCd6jhFpJ+6AlTBSRfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BBlOR8
	IWxNVegid5E3YdCchVpb7JibUiwYa+PnEveyvfrc64x0XuQaEvMxDk9JTWx94Uz4
	NxMx4o+vqn1ppz/sQZyORJzaGGLGHwQ9VQjHksbOH/b1MjJhrgK4Aqj4Kv42r2AI
	6zQn8hfQpPkDAy6NeB3s9PwP/A21T1Im8O9XU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B7DE0C9E;
	Fri, 22 Oct 2010 19:22:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 376FDE0C97; Fri, 22 Oct
 2010 19:22:05 -0400 (EDT)
In-Reply-To: <20101022231820.GB25520@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 22 Oct 2010 19\:18\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3188F95E-DE33-11DF-8E3E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159764>

Jeff King <peff@peff.net> writes:

> How did you calculate this? I don't see how it could be right. For
> example, =C3=86var's contribution, while being impressively large lat=
ely, is
> only 12877 lines total over all commits, let alone surviving lines:

Yeah, there seems to be something fishy in my math, adding up numbers f=
rom
blame output.
