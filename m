From: Andrew Rodland <andrew@cleverdomain.org>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 14:22:27 -0400
Message-ID: <CABFQKmONh2dQ+dkt3MsSXtFyKh5mnfK1fQVyw6Ez6aWajo=BDg@mail.gmail.com>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
 <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
 <20130320170957.GA21350@sigill.intra.peff.net>
 <7v620mf05l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINf7-0006Jn-IM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab3CTSWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:22:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab3CTSW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:22:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F02A4A194
	for <git@vger.kernel.org>; Wed, 20 Mar 2013 14:22:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=sasl; bh=1PIQhJq5Jik74da+FtWAYJttKTQ=; b=X4Wnrk
	TkM0MCDgBm1cy6nmZhXjssS7TWbv4oZAvKln0k/pKgFbu707ZlNzr9d+wLnzcB03
	BLDKpenh0y3PMM3p1NnkQs4hXq9eaYpDpf2F/AcYORd6zIe8r3X7s95BSQQI2ay2
	H/VeIaLrWBQZ9/YA95C/6Y6JBFrUknC5qxS2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF0EA193
	for <git@vger.kernel.org>; Wed, 20 Mar 2013 14:22:28 -0400 (EDT)
Received: from mail-ie0-f170.google.com (unknown [209.85.223.170]) (using
 TLSv1 with cipher RC4-SHA (128/128 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 841D9A18D for
 <git@vger.kernel.org>; Wed, 20 Mar 2013 14:22:28 -0400 (EDT)
Received: by mail-ie0-f170.google.com with SMTP id c11so2473746ieb.1 for
 <git@vger.kernel.org>; Wed, 20 Mar 2013 11:22:27 -0700 (PDT)
X-Received: by 10.50.20.168 with SMTP id o8mr2182045ige.77.1363803747753;
 Wed, 20 Mar 2013 11:22:27 -0700 (PDT)
Received: by 10.43.67.70 with HTTP; Wed, 20 Mar 2013 11:22:27 -0700 (PDT)
In-Reply-To: <7v620mf05l.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 1F4970E4-918B-11E2-98EB-EA7A2E706CDE-16769786!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218638>

On Wed, Mar 20, 2013 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> And the cost is that we have another Makefile knob people need to tweak
>> that would not otherwise need to be there. Which can be annoying, but is
>> also not that huge a cost to deal with (we might want to improve the
>> configure script or something, though).
>>
>> I admit I don't care too much either way.
>
> I don't, either ;-)
>

For what it's worth, I'm not really invested either; I just figured
that raising the issue was better than not, since I bumped into it.

I think it would be good if NO_NSEC and USE_ST_TIMESPEC were
controlled by configure instead of config.mak, and it doesn't seem
like too tall of an order.

Andrew
