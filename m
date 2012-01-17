From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* Regulator updates for 3.3
Date: Mon, 16 Jan 2012 22:13:02 -0800
Message-ID: <7vboq2uaa9.fsf@alter.siamese.dyndns.org>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
 <7vehv77xeq.fsf@alter.siamese.dyndns.org>
 <CA+55aFzuGtJkQFDooSGWQ2_NiJVHN2E7S5dmOnWTYn8_s8Gg3g@mail.gmail.com>
 <7vzkdu7miv.fsf@alter.siamese.dyndns.org> <4F136BE4.4040502@pcharlan.com>
 <7v62gbussz.fsf@alter.siamese.dyndns.org> <4F15080C.6060004@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 17 07:13:24 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rn2IO-0004As-FZ
	for glk-linux-kernel-3@lo.gmane.org; Tue, 17 Jan 2012 07:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab2AQGNI (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 17 Jan 2012 01:13:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab2AQGNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2012 01:13:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 006237DD0;
	Tue, 17 Jan 2012 01:13:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ScuacaJZRjQ+YCSOCws2stgzzHY=; b=ieaEhQ
	RotmqyGkoxl3NGCbBeTn0VyY0/wginrL9ZLYgZSCvvX5TEvB5QNfW0VX7WYHISMz
	BWKBm7AMPia0saO7AChOPH8OrXQQbKcShxZdlyQtnCos8T1QI5Tq45fB6pCgCBy4
	gVGKPARn8cBOju6WX5foZuYNeT8Cokza42vI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UnTRmuNZGjIirqK0x6ykVLBJ3D9vHLY/
	gMVTT0DBrr0BCrsAdiZSlxdCVQIjZVQ7wGxm2nrQZ4XL4qjx7bRXkC+Z+DWBqo7j
	DKUdRn6IHsKbiNcuRPHv4fFa/YPyBmFLA96g2sLf68IJtbfr0c7eSkyC0m5c4ZGb
	47iBBdhum9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB5977DCF;
	Tue, 17 Jan 2012 01:13:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B4E77DCD; Tue, 17 Jan 2012
 01:13:04 -0500 (EST)
In-Reply-To: <4F15080C.6060004@pcharlan.com> (Pete Harlan's message of "Mon,
 16 Jan 2012 21:33:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51068708-40D2-11E1-8E2A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188691>

Pete Harlan <pgit@pcharlan.com> writes:

> ... The
> only time I think I'd prefer "LEGACY" is if you're planning on
> deprecating and removing it eventually and you want to indicate
> something to that effect in the name.

The discussion that led to the naming of that LEGACY token needs to be
re-read, then. The kind of "LEGACY" you prefer is exactly why the
environment variable is called LEGACY in the patch you are commenting on,
written in response to Linus's suggestion to switch the default, even
though I am not 100% buying it.

Having said that, I think I am wasting my time responding to this thread
during the feature-freeze period for v1.7.9, as I am not a big fan of
switching the default without adequate warning and transition plans, after
getting burned by the "'git-foo' vs 'git foo'" flames back in the v1.6.0
release. We would likely to take a gradual and smoother migration route to
transition, e.g. v1.7.9 to introduce "merge --edit", v1.7.10 to introduce
a configuration variable merge.edit (lack of which gives a warning and an
advice message while defaulting to 'no' to preserve the traditional
behaviour), and finally v1.8.0 (or v2.0) to flip the default to 'yes'
(while the configuration still giving a warning and an advice message)
that "merge --no-edit" can still countermand.

So you have until v1.7.10 to decide a good name for the overriding
environment variable.
