From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: git log -M -- filename is not working?
Date: Fri, 07 May 2010 22:39:54 -0700
Message-ID: <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
 <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
 <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 08 07:40:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcm2-0000fo-7M
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab0EHFkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:40:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0EHFkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:40:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2C6B1E2C;
	Sat,  8 May 2010 01:40:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vvpC4cq7XJUS2ZZPOOYeM19fF2M=; b=cBqNsxw6PCMUwI6yySgwd1Z
	Fd8DZWZMOw9twIfi0qsJlDMmg2Fw+KLtsTKrq9wg7DeaMn8mqa0nmaGo+Mzpdyql
	IKQgxuk0xQV/ivN4dhAJj3LtdSSrOk/sUc4xYPzn7Yi+RsdOCrTh98R36fkg/MhS
	r5G8SyFZUyPg6o9T08Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=G0KJHy4ey/4unA8US1UrVh3755YP4o7o/W+czim4MisH1ZL9x
	o+ma0XdnaCcCbdyh5fDb5wmmqAynCiXSeA4dy8WDAHDVffubNInIBow2afpBcP8k
	AzJgJFlYONivZRvKd2IO2gHKaq05VFty/YSC9wIsAz7DHacJb3pf09Echs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6910CB1E2B;
	Sat,  8 May 2010 01:40:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F896B1E2A; Sat,  8 May
 2010 01:39:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2686F9FA-5A64-11DF-81F7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146643>

Eli Barzilay <eli@barzilay.org> writes:

> So if there was some single
>
>   --do-whatever-you-can-as-much-as-you-can-to-find-all-renames

If I am not mistaken, that is exactly the point of Bo's patch:

    Message-Id: <1273207949-18500-4-git-send-email-struggleyb.nku@gmail.com>
