From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Tue, 14 May 2013 11:59:05 -0700
Message-ID: <7vzjvxie12.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
	<CAMP44s3D1qTaSWVgNWEDUp7FKK91RxhJozr1LKV6VK95rAQmzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:59:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKRN-0001p7-1l
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab3ENS7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:59:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57476 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab3ENS7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:59:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5041E3F8;
	Tue, 14 May 2013 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CvT38VlJSm3j0w8Q7hFVLYusJiU=; b=AHhZwz
	0+FGwuI2GXlEYt5sZoh0baA+PeOQ2GvoRRP3O+shQtu9hfioAguwhPrN+Qm9GOZj
	ykTNJvlHjXIOHslpY2bbB3CNX1IXz9+/3x1uJSS1TttVx1OiJnXgy2aLE8L2E6tE
	/y3s64mZowce7eCYnMph1teEDaEROzVVAgu+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mf03aCSDM7CQlAodJ50rv29idwcgVwd8
	/K8jekVUdDxw9n+4Es9CJDSA8HUUfF5ug2/towQdnYlxK50GT+z8S0ByGTESRYda
	oaLc+f3/TPxjMQZFMX0B6K4iy+atj7JhZrLoU8erLU8UZ2+ahwtEtjMJujDXmisI
	GTaLmuVsuCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0191B1E3F7;
	Tue, 14 May 2013 18:59:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78E8F1E3F6;
	Tue, 14 May 2013 18:59:06 +0000 (UTC)
In-Reply-To: <CAMP44s3D1qTaSWVgNWEDUp7FKK91RxhJozr1LKV6VK95rAQmzA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 13 May 2013 23:47:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A10C5A2-BCC8-11E2-94F5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224317>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, May 13, 2013 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Folks interested in working remote-hg, please try it out, so that we
>> can have a polished one soon after 1.8.3 ships (I am not saying this
>> round is not polished---I haven't even looked at the patches).
>>
>> And others, please spend time on testing the 1.8.3-rc2 to make sure
>> what we are going to ship is free of embarrassing regressions.
>
> If we want folks to test something, it should be the patches I
> prepared for 'next' which I just sent.

Yeah, but that is for the release _after_ 1.8.3; I'd rather see
folks help to make sure we have a solid 1.8.3 relaese.
