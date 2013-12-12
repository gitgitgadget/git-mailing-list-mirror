From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] cat-file: handle --batch format with missing type/size
Date: Wed, 11 Dec 2013 19:05:46 -0800
Message-ID: <7viouuu5th.fsf@alter.siamese.dyndns.org>
References: <20131211115458.GA10561@sigill.intra.peff.net>
	<20131211115844.GB10594@sigill.intra.peff.net>
	<20131211204200.GN2311@google.com>
	<20131211231549.GB16606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Samuel Bronson <naesten@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 12 04:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqwb4-0007q4-SU
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 04:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab3LLDFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 22:05:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab3LLDFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 22:05:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15CF35AFEE;
	Wed, 11 Dec 2013 22:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s6l4xU+kJE9zKoTO0ZkH2uTqcZk=; b=UtNCN3
	zHNd2//2GU5Hc2p2jWbY241s8K6hgybGX+LcctbPhq/g/ONH2EEAchMz6PSEgSCL
	zVZNvo04jjk9W+QXJTzHiPR2xJp+Fvou3ZU0jyZd4AsVfzpsG7krhXvr01uWia3p
	e3ulLdbdKbn+hP5uqaqotWO+3+TLjmfLVhcCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2DPRjeXKTI7JBqkAeRB9+idGO5EXGh9
	hPZURWY5yN5YhN2LGevSry9oqsMtLmKeQbsl1fETpgjoq+HEMjbPb5jtpomhLrdW
	anmburnBRqlrq4Tkng9qQsta0fha+RESPsdfJ5IxNh0/McFwEoBH3cj+zMAl9l8m
	JYrYKyvmY9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F835AFED;
	Wed, 11 Dec 2013 22:05:49 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C32185AFEC;
	Wed, 11 Dec 2013 22:05:48 -0500 (EST)
In-Reply-To: <20131211231549.GB16606@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Dec 2013 07:15:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D27730A-62DA-11E3-82B3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239223>

Jeff King <peff@peff.net> writes:

> Yes. The loss of the optimization was a small thing compared to being
> totally broken. :)
> ...
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks. Updated patch is below.

;-)

I like it when I see patches are polished between the submitter and
reviewer(s) fully, before the maintainer has a chance to pick an
intermediate version (only to later replace and requeue).

Thanks, both.
