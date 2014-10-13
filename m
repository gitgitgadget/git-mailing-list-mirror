From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Mon, 13 Oct 2014 15:05:33 -0700
Message-ID: <xmqqlhoj1v82.fsf@gitster.dls.corp.google.com>
References: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
	<CAPc5daUTKU1JepLuyVC1Nk6LG4AZ2TA5SEYLsTSPbPKkauzNyQ@mail.gmail.com>
	<20140928.133623.1635797151132857721.chriscool@tuxfamily.org>
	<7viok7k0c0.fsf@alter.siamese.dyndns.org>
	<CAP8UFD1ATE-CtqXJyd7qDw-34RJ3ZQibHo6BSi+42hkaPNzz5w@mail.gmail.com>
	<CAP8UFD0Fx455GiM8EphkG=-vswR-GOD169EOgf2gJsGzTHS=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:05:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnkU-0001pG-GU
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 00:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbaJMWFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 18:05:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877AbaJMWFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 18:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C059716DB9;
	Mon, 13 Oct 2014 18:05:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QFBDPLoLt9beyuO2rLliXEYwnGU=; b=LVpRNf
	Bd69azMdzXA8qCGupyfnZH80WcxDLoOPnUjFD8hleBk9CYNx6kuVd388SVG2DXb7
	LWwL5M8Ame02bHO1TEHWngh6QKkv8lvV/E70HEPV4UvPt7WmSnJEnUM7Ou+tUPJq
	1s4EdQ8mmmto/3ZxzO++dyoxOZWKJwon/U+G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E9NTgU+HzfSlaCk4YbPfqnFX9NUEcMYc
	WHy3r9k9VszU9wy5rqgI9b+jybN+nEXAnPhxdCUX0dHFYhnE8vpVKXRTMFXq+aiu
	NL+9itcRSgTV5psl/gNFrravdrUHUi/j0tHQDcUSKv+R0oRo57olXDcVlGV2Tgj3
	kS1/ifFdDt4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA2BE16DB8;
	Mon, 13 Oct 2014 18:05:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B19616DB6;
	Mon, 13 Oct 2014 18:05:34 -0400 (EDT)
In-Reply-To: <CAP8UFD0Fx455GiM8EphkG=-vswR-GOD169EOgf2gJsGzTHS=SA@mail.gmail.com>
	(Christian Couder's message of "Mon, 13 Oct 2014 07:09:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E028020-5325-11E4-BD3E-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sun, Oct 12, 2014 at 11:36 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> With v16 you can easily choose if you want to have the S-o-b in the
>> output or not, when there is already one, ...
>
> By the way, I sent v16 just before the above email, but the series
> still hasn't hit the mailing list.
> Did some of you guys in cc receive something?

I see them and picked them up to replace.

Are these now ready for 'next'?
