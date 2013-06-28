From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup-builtins: remove unused cruft
Date: Fri, 28 Jun 2013 11:49:40 -0700
Message-ID: <7vfvw2nk8r.fsf@alter.siamese.dyndns.org>
References: <1372434379-24085-1-git-send-email-artagnon@gmail.com>
	<20130628164545.GB9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 20:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usdjv-0007ea-KC
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab3F1Sto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 14:49:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab3F1Stn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 14:49:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C522C1CC;
	Fri, 28 Jun 2013 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lfm4JZMLMZ4qRPigqsEywBtfbzk=; b=O+3+g3
	QaPFPAMBfVic9n/YVF5gopgUaxcY2WUp9uhw6JWyc0pA0cYPvNtF4gg9+7k3BySB
	/VSvTBNhgJEddzWeSQBOYAVO0+Wglx3qcW2OyDBdyIQhcbcPdoRVL7x6GNmJG04v
	lfENBSIUolyXarzpuA+wGXFB0+SghZDQiPryI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/NzrCPsJklKPLtTPkiqjAf4yDugHn4i
	ikhb1hctM7k/Scdx/NvKAdWl6519OX5t5N2W9gg8ULS/wpqMv6VNYgULTRKikEZe
	0tluXGKetzKZoRWXWwuwS+LGnHHI5EDbpjqbKTrl3JjMZlrwGX1cBPKVBHBlXTJO
	MdEVOveo+fQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCC012C1CB;
	Fri, 28 Jun 2013 18:49:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3826C2C1CA;
	Fri, 28 Jun 2013 18:49:42 +0000 (UTC)
In-Reply-To: <20130628164545.GB9127@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Jun 2013 12:45:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E536EE6-E023-11E2-B8F0-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229226>

Jeff King <peff@peff.net> writes:

> So I think it is probably a good idea to remove it, but the
> justification is not "this is unused cruft", but more like:
>
>   This script was added in 36e5e70 (Start deprecating "git-command" in
>   favor of "git command", 2007-06-30) with the intent of aiding the
>   transition away from dashed forms. However, nobody is really working
>   on that transition, and even if they did, this tool will probably lead
>   them in the wrong direction, as it produces a large number of
>   questionable changes.

It is not "nobody is working on", but "it has already been used to
help the transision and served its purpose, and is no longer is very
useful for follow-up work because the majority of remaining matches
it finds are false positives."
