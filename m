From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Sun, 30 Jun 2013 12:17:48 -0700
Message-ID: <7vli5rjtlv.fsf@alter.siamese.dyndns.org>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
	<20130624224925.GC32270@paksenarrion.iveqy.com>
	<20130625221132.GB4161@sandbox-ub>
	<20130626160219.GC9141@paksenarrion.iveqy.com>
	<7vli5wvb3n.fsf@alter.siamese.dyndns.org> <51CC5235.6030908@web.de>
	<20130628065001.GA2783@sandbox-ub>
	<7vk3lenkhh.fsf@alter.siamese.dyndns.org> <51CDF819.9030308@web.de>
	<7vr4fllugy.fsf@alter.siamese.dyndns.org>
	<20130628230714.GA22143@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 21:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtN8P-0007A9-RB
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 21:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab3F3TSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 15:18:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814Ab3F3TSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 15:18:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14B32C7FA;
	Sun, 30 Jun 2013 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ohoJoc+w68MhDlIucECpz12x2cc=; b=JOSuEt
	dr+YR3AuhF3/OFq7Yebs4pMyyoN13ZnBxLEICMoFj49pBnt9fX+JHfLueCEkOWkQ
	eAKnO7GXYoiJrk01rFpuvX1R9s9nmh7O+WWBX7QMcSSmNCpihmwqaL6z6QUzox3y
	JLQmDmSUHGWn2AJb11YPO/07xqlth3Xf5bowM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ygHpnakInlvQKaZbrPY3OL5vr31KNlVl
	D0+nq0dA/117DcwQPh+mYc6o8X//B/rmLR9MSD/FaYkVyxEo0FOGfZ5KBe3EbCyP
	o6riDd0qFCiFkaZ8xNZkEUI5qsbuOnGRcYL6L1eGgDHnaP429tZwMrucDZe69tfD
	KM4Y7OwEj4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4FCE2C7F7;
	Sun, 30 Jun 2013 19:17:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59B4E2C7F4;
	Sun, 30 Jun 2013 19:17:59 +0000 (UTC)
In-Reply-To: <20130628230714.GA22143@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Sat, 29 Jun 2013 01:07:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6B8F3B2-E1B9-11E2-A3EC-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229283>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

>> OK, then "--depth" it is.
>> 
>> The points in your review on the last version with "--depth" (which
>> I picked up and parked on 'pu') still need to be addressed, I think?
>
> I agree, I'm on it

Thanks.
