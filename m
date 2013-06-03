From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] send-email: fix suppress-cc=self on cccmd
Date: Mon, 03 Jun 2013 14:55:03 -0700
Message-ID: <7v7giadfm0.fsf@alter.siamese.dyndns.org>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
	<1369897638-27299-3-git-send-email-mst@redhat.com>
	<7v7gibjieh.fsf@alter.siamese.dyndns.org>
	<20130603161556.GA16750@redhat.com>
	<7vd2s3f4uo.fsf@alter.siamese.dyndns.org>
	<20130603195833.GA18883@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:55:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujcif-0001bm-5j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678Ab3FCVzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:55:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758645Ab3FCVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:55:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ADC125711;
	Mon,  3 Jun 2013 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R77S6CG5s8Y/ucg4WqVwCZHSmZ4=; b=UPE3xd
	hcgmsND12H23RbaiQFwQqLGNg6V071XyCIKYXcUle6NDKWFvavIRCC46DtUi3SvE
	zrXjSytIsMsc9FuHKoBF6orhJjvLuhEqna+nhsaoiWYpgmTlvhw0lQtM/3GMFuCG
	gPvfKiSvZXL7PGytX40DJQaLrda78z+IVNnow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpOUAS4i0mejpIjPEeC8YJyBJxj+LQ+r
	EnpAmPTWt/cNwqUBZuVk3lDdDaMsVPcH6pv6Mk3BZafkP62NRJDV44oKCocV7QvF
	aixRBmSaFOsfxT2zW/9wR6+U97UDYJ0MzF7qyLkiyjpTHUmTPNspjlPUZOj26pAY
	bZvP6Y5TSpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42B6F25710;
	Mon,  3 Jun 2013 21:55:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEF5F2570E;
	Mon,  3 Jun 2013 21:55:04 +0000 (UTC)
In-Reply-To: <20130603195833.GA18883@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 3 Jun 2013 22:58:34 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F8DDD66-CC98-11E2-B3B3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226296>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Jun 03, 2013 at 11:04:31AM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > What I tried to do here is split the changes to small chunks and I
>> > picked a chunk of a later patch in an earlier one by mistake.
>> >
>> > So this is fixed up by patch 4/6 in the series, which redefines
>> > sender to have the sanitized value, everywhere.
>> >
>> > I guess I'll have to repost moving this former chunk to patch 4.
>> 
>> Yeah, that may be a good idea.
>> 
>> Thanks.
>
> Or just smash 2+4 together ...
> Confused. You are doing this or want me ot?

Sorry, I was expecting you would do so, after saying "I'll have to
repost" and I responded "Yeah, good idea".
