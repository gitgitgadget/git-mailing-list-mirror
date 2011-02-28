From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 10:21:47 -0800
Message-ID: <7voc5whves.fsf@alter.siamese.dyndns.org>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
 <4D68D630.9000608@drmicha.warpmail.net>
 <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com> <7v39n8ll0s.fsf@alter.siamese.dyndns.org> <4D6B5D09.8010806@drmicha.warpmail.net> <vpqwrkkpkea.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 28 19:22:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7jV-0002fQ-Ic
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 19:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab1B1SWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 13:22:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab1B1SWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 13:22:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AE1D4D37;
	Mon, 28 Feb 2011 13:23:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=S+1VKNqoS+SH+NsMK7uj70ygLg4=; b=uLg8dC
	beS9ag37c20XFgHsfbhd8qTzrYNXXkSiI+9vCTb5S4uUnQb1+5dNecBMHm0lwdHU
	MrfDjP+0Skgqu4itvs3Z1uSXquy4zLHVn/myKnYKmxL5oY6g03IHoaylgKh9a5zF
	uQxPX5H02wpzNvEiPAG7EiC1L1dyTCy9mWc8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k+qQtx3ts/1S34ZRITSvM1H4p88WOJUb
	V8J6atYkLDjksHNQ+X6XY7VJJUqwUj1q0HB5/Glq7oSV7PIOkjAo4hXDlSI1rCV8
	Nz4JxLVIKGxeZ5MHAAA/sFlD5/VszFzl5BE1aivuYsYMNk4qgAz2xcjN3K5Ugu1U
	zN9+37OJxho=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A1884D36;
	Mon, 28 Feb 2011 13:23:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD8B54D33; Mon, 28 Feb 2011
 13:23:07 -0500 (EST)
In-Reply-To: <vpqwrkkpkea.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 28 Feb 2011 10\:40\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE484CCE-4367-11E0-AB28-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168130>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Today, "git add ." adds new content in tracked files, and new files, but
> doesn't notice files deletions. Did I miss something, or is there no way
> to do that with your proposal?

That _may_ be something we would want to discuss, even to introduce a
backward incompatible change, aimed at 1.10.0 or 2.0 timeframe (if we are
starting to discuss something new today, it is too late for 1.8.0).
