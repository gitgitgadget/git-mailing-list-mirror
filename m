From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why is tagger header optional?
Date: Mon, 18 Jan 2010 22:35:25 -0800
Message-ID: <7vfx62bo0i.fsf@alter.siamese.dyndns.org>
References: <20100119060946.GA23212@spearce.org>
 <7vk4vebo6z.fsf@alter.siamese.dyndns.org>
 <20100119063255.GC23212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:35:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX7gh-0002zt-W0
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891Ab0ASGfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668Ab0ASGfd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:35:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab0ASGfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:35:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D19629072B;
	Tue, 19 Jan 2010 01:35:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dm1hNqzox43MHMs+bvAUaaaNves=; b=Abq6yr
	FRC7RVnt+D/vIF3d8aIj7mD0GpcxpAGVvyDxuS/tpAke4z/FvXjKAOZ5dLQOo4Mc
	wp1ZbO92Ny58XTra+MRsnGlbZdZoC85m1cEvfhUqtjBkQkMlAOfmLsQaEjGCBK1+
	RzkGJN16dNSwMYbrUqwIkVAqWyxVkNagT14JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4L42Nw9hwkj4InLwx/X555DufrNtnRQ
	ThiyXBIcRPEul9TjvKL054ZiTBvC4WwHxqLoFN1udi+5Bdx+9W90yEBb2skU6S5P
	9qcZTFHqdv1yrztri2rpfUUJQWjsREaUhZ7wpmoG5TkFv6a32Ai5oDmjMRFucU73
	YK5eICQEYxk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A951D9072A;
	Tue, 19 Jan 2010 01:35:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBEA890729; Tue, 19 Jan
 2010 01:35:26 -0500 (EST)
In-Reply-To: <20100119063255.GC23212@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 18 Jan 2010 22\:32\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D6B3ECCA-04C4-11DF-8775-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137432>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > So why is it legal to omit the tagger header from a tag?
>> >
>> > E.g. the Linux kernel tag v2.6.12 has no tagger header:
>> 
>> We didn't.add tagger line until c818566 ([PATCH] Update tags to record who
>> made them, 2005-07-14), which is v0.99.1~9
>> 
>> Linux 2.6.12 is a lot older than that.  v2.6.13-rc4 in late July is the
>> first one with tagger.
>
> Ugh.  So its like the 100640 or whatever mode tags in the kernel
> trees that are also considered bogus by today's standards, but have
> to be allowed because of the kernel history.

Yeah; don't we have "fsck --strict" or something to take the distinction
into account, though?  I don't recall if lack of tagger triggers the check
offhand and I am too lazy to check.
