From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Mon, 19 May 2014 12:01:08 -0700
Message-ID: <xmqqegzp1tl7.fsf@gitster.dls.corp.google.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
	<53795ef8e4023_10da88d30825@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 21:01:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmSoN-0001LE-Po
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 21:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbaESTBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 15:01:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54344 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455AbaESTBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 15:01:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2E63175BD;
	Mon, 19 May 2014 15:01:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DkRWqWVs57ocaiqM1e3RWHK7Sxo=; b=Of9Yg1
	n51Jmop51AopqMWL6HqSxkThZGfg56Blv2R2h7v9RITJSEYWFcH2GIh7HihU+i9E
	7dBXiobyI0jrXRdXPqvYesFD9TIQt50jXM3KMjeu3Dqbm04XZqK3uIBxyCya6k2M
	2HgTqbGX4YoXW1Nk+Xupsr1pSDSyc80FHhHOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZGQCKEk9I2PbyadM5z+wpK1ynlFp0Fj
	tp5NzM8JuhQo0gHx3LPTTBE/dl5EJPrfQi0Y0XeW+sskqZX+DA2rekzBJwnaj9mm
	BnV1Fv0prICjpTKu0OJEl4KK8TRV/W7A7ihFNzo6LIhh7QvW+qk4Dp28FH+KYFkq
	S8AyaqXGcPA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAEB3175BC;
	Mon, 19 May 2014 15:01:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32F46175AD;
	Mon, 19 May 2014 15:01:10 -0400 (EDT)
In-Reply-To: <53795ef8e4023_10da88d30825@nysa.notmuch> (Felipe Contreras's
	message of "Sun, 18 May 2014 20:31:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F0A56E4A-DF87-11E3-B059-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249611>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>
>>   2. add warning that is given every time the scripts are run and
>>      give the same instruction as in README.
>> 
>>   3. (optional) cripple the script to make them always fail after
>>      showing the same warning as above.
>
> This is what I want, and I already sent the patches for; the scripts
> will be stubs. At this point you would have effectively removed the
> code, which what I want.
>  
>>   4. Keep README and retire everything else.
>
> After you've removed the code, I don't care what you do, but I'd say you
> should remove the stubs after a long period of time.

Let's try this in a different way, as I sense there is a
misunderstanding somewhere about your "wish".

>> "that" does not refer to "remove them at v2.0 (unconditional)".  It
>> refers to "If Felipe really wants for the removal for v2.0, I would
>> respect that".  And I saw you said you did not want to disrupt v2.0.
>> 
>> If the options I listed all meant removal at v2.0, then I would
>> understand your complaints, but that is not the case, so I am not
>> sure what to make of that.
>
> It is a weird choice of semantics then. You said you would "respect" my
> wish, but your proposals did not "follow" my wish.

I understand you do not want to disrupt v2.0.  My assumption of that
"not disrupting v2.0" has been "there still are git-remote-{hg,bzr}
that work just like what they had in v1.9.x, perhaps with some
enhancements and regressions you added in the meantime", and I
understood Peff's comment "If Felipe wants the removal" to mean that
kind of "disruption", i.e. "there is no git-remote-{hg,bzr} that
work.", which would be either step 3 or 4.

But your "After you've removed the code" comment above makes me
wonder that perhaps your definition of "not disrupting" was
different from ours (which is not good or bad, just different) and
you consider that step 3. is "removal but not distupting v2.0"?

If that is what you want in v2.0, then please say so, and I already
said I am fine with that.
