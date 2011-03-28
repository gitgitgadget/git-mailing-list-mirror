From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] tests: fix overeager scrubbing of environment
 variables
Date: Mon, 28 Mar 2011 14:03:09 -0700
Message-ID: <7vk4fjvtyq.fsf@alter.siamese.dyndns.org>
References: <4D8FAAAC.3050905@web.de> <20110327213756.GD25927@elie>
 <7v4o6n18oy.fsf@alter.siamese.dyndns.org> <4D90DE79.7000103@web.de>
 <20110328193744.GB13433@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 23:03:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Jax-0003oD-MF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 23:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab1C1VDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 17:03:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab1C1VDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 17:03:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5464A4804;
	Mon, 28 Mar 2011 17:05:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YNC7pIVUVpDDeqcyLMgbOLuHqtk=; b=yVO88/
	wUEmaFSRllgGF6MNFL5WXAHQlOg6zRyYUVc9tSndWUlObf4thvOYjV4iuWXDjxhm
	oRKUE42aM2Ri/kWQtZtDZ8g/+BMknfzqD66zu0hfuIdhCW/NrWRGn9u4rGbuH+B9
	T6stxTyzynGQwvqSrjF2D6nbEJ9ZN6k6PNZwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=enJNt74iua9W+hXCc0bMvS0u+IWz2t+U
	VArYC84ccmNG6KFucIpnGXfoctXQYKIkgOz7jc8bZVW//gMvB1SJEsslQmqBlueP
	qkP2Gfz5lfoKFZjfm4flQmv7d8eM18UoFaMyxMQi9uio0PZSNaqsC+awwF3Q1EqY
	L0etsrDZbRw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B9814800;
	Mon, 28 Mar 2011 17:05:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A636947FF; Mon, 28 Mar 2011
 17:04:57 -0400 (EDT)
In-Reply-To: <20110328193744.GB13433@elie> (Jonathan Nieder's message of
 "Mon, 28 Mar 2011 14:37:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CAF1D62-597F-11E0-8890-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170192>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jens Lehmann wrote:
>
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Yes, still. :)
>
>> So here is v3 of my patch which
>> just makes these variables work again.
>
> Thanks, all.  This looks good for an immediate fix, and I can think
> separately about how to make downstreams projects suffer less if
> changing the names of variables like GIT_SKIP_TESTS to follow a
> GIT_TEST_ scheme.

Thanks, all.
