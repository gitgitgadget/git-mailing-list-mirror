From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 13:39:30 -0800
Message-ID: <xmqqsi0tpsa5.fsf@gitster.mtv.corp.google.com>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
	<1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
	<CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
	<20160215202937.GA57185@vauxhall.crustytoothpaste.net>
	<20160215203451.GA29705@sigill.intra.peff.net>
	<20160215203659.GB57185@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:39:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQrt-0007yS-5p
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbcBOVjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:39:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752436AbcBOVjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:39:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 095F445F31;
	Mon, 15 Feb 2016 16:39:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EsojLYp2MO6QKbAKsUQMjlIehDk=; b=NDsdvK
	2mJ8E1h15KjGLs0J4Wg+7D2ElX2Fwr2SZ+oSavyV4zMDyg124vKymCXKPScdej1M
	/YmL55PhLnvL6cV2m3HLj2YqLFpTES1ueBmwreEa63vi9GgVstCzsZzYk6h/0oXO
	fCBucGU+5ObX//pNZcNsYltls6bHi0CIZuO64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLPk7ZICz6YbYKrWm5O+DiPhtawtV/bo
	KoernQ1kT3bj32oRH90CzhszuhLzJPmCMdi6zhZ9EXsAfzesycKV7EQSzyYiVMLa
	qY5LyHzk3+cDrE4kDLyHEuT1ikNRBNNOOzNp348AuKQs7s1hX6yBOJbZuKn86tWq
	OUbK4Tj2VrQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3EA545F30;
	Mon, 15 Feb 2016 16:39:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 669A445F2F;
	Mon, 15 Feb 2016 16:39:31 -0500 (EST)
In-Reply-To: <20160215203659.GB57185@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 15 Feb 2016 20:36:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98F237BE-D42C-11E5-83C0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286248>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Mon, Feb 15, 2016 at 03:34:51PM -0500, Jeff King wrote:
> ...
>> So I think this hack should remain purely at the curl level, and never
>> touch the credential struct at all.
>> 
>> Which is a shame, because I think Eric's suggestion is otherwise much
>> more readable. :)
>
> Yes, I agree.  That would have been a much nicer and smaller change.

Alright, reading all reviews and taking them into account, the
original, when a Sign-off is added, would be acceptable, it seems.

Thanks.
