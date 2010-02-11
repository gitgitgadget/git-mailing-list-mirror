From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 12:36:52 -0800
Message-ID: <7vfx5733x7.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <20100211193248.GA27072@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:37:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nffmi-0007pF-7l
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 21:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab0BKUhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 15:37:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab0BKUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 15:37:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98B91986D1;
	Thu, 11 Feb 2010 15:37:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=F88FOeGujRKSo7zxQ6T1urN34fo=; b=dXo0kx+MVzoq2RMhmLyJUd+
	oWxjvn3sots136NbtybpXcB+LjalclQOcB9DoJ6M9JECqLwi18rYtptvLMcBdxA/
	vaRdKho6yQORftVC2Lw1vKcIeLCIszGYqBmomsOQiN+BQSlWRoMVZ1f4pB20+vPa
	IXj2K8eGgQwt7BKg9oX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FYP9f/QCYwGdTty54gk5QOLKeM5jEtcUhVGjOt4CClPJxufck
	I9G0T4cQRXve/vy5uDiUIRL/8Wcmb6onj6Yq9I2l2ouufi3xkPQafYuFXpwQ/+TT
	51bZpBKGntat7TWB8zGFeQE31VtLWk5Kp7rLbtFGf3jV2JCnbgQgzv5V64=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 459BD986D0;
	Thu, 11 Feb 2010 15:37:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46D72986C6; Thu, 11 Feb
 2010 15:36:54 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3454357A-174D-11DF-8613-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139622>

Jeff King <peff@peff.net> writes:

>> Having said all I did in the previous message, I think "am --continue"
>> would be a good addition.
>
> OK. I agree with your philosophical ramblings in the previous message,
> but I also think there is some value in making it simple for the user to
> remember.

Certainly I am in agreement and that is why I think "am --continue" is a
good thing.

> Do you just want to pick up my patch from earlier in the thread, or do
> you have further comments? The only thing I could think to change would
> be that we may not want to even bother advertising --continue in the
> usage message (conversely, we could go a step further and actually
> advertise it in the manpage).

I would say our eventual goal should be to make "--continue" the primary
word the end users would see.  It would bring us closer to that goal to
start advertising --continue early.
