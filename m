From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:02:35 -0800
Message-ID: <7vhbq4xbok.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org>
 <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
 <7vmxzwh906.fsf@alter.siamese.dyndns.org>
 <ron1-6C7BCB.14122429012010@news.gmane.org>
 <b4087cc51001291633l68760880i340d12e865641077@mail.gmail.com>
 <7vvdek70ma.fsf@alter.siamese.dyndns.org>
 <ron1-FA4289.22165129012010@news.gmane.org>
 <7vaavw1478.fsf@alter.siamese.dyndns.org>
 <ron1-0D3105.23314829012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb8I6-00039z-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 09:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab0A3ICp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 03:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533Ab0A3ICp
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 03:02:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0A3ICo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 03:02:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E91F595FF0;
	Sat, 30 Jan 2010 03:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jYzyWwrHsqQG6SSfp7Lses++36s=; b=qToh/X
	YI+xeOHmDG7U4GzmqS2U8WPg/qanMyVEIk3UY/vHyPDCwrgDkMdx7ECzKg8ujfU9
	91ye/SowxXr0cnJuv6x5Cd5ve45y0hxF1+sifXAEHnt8/0D2NnLRpu/hdWn//LDz
	xh9jxPBg10QCIRo4/q0qJHv9P50muz26xsvRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SevUvQtgTaAxL0WwpQ/XsqF4hpF9k5kK
	WxcR0tkteWZtXR7jXT8d//7PS4R2nv261VBtOWHv7Rw6uUGCeRigUdf+auVgpBK3
	Ey4L8XvBrfkzBGglpeMTLKQl9uIEQZEiPgc3aQUgok4TktUPrDRE8YCuiBVmqDMf
	xc0iiHRJiuU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA53C95FED;
	Sat, 30 Jan 2010 03:02:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A7F895FEC; Sat, 30 Jan
 2010 03:02:36 -0500 (EST)
In-Reply-To: <ron1-0D3105.23314829012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 23\:31\:48 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D603B008-0D75-11DF-BDA2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138462>

Ron Garret <ron1@flownet.com> writes:

> It wouldn't.  Was this a trick question?  Did you mean to ask what would 
> happen if I ran commit -a?

I didn't mean _literally_ "git commit".  Any random thing you may want to
do when you come back to work the next day and find a checked out work
tree.  Viewing, editing, committing, etc.

>> *1* As a set of "building blocks" to implement "reset" and "checkout", I
>> don't necessarily agree that "update" would be a good way to go from the
>> implementation standpoint, but that is a totally separate matter.
>
> Did you mean "don't necessarily DISagree"?

I have huge doubts that "update" is the best way to do reset/checkout.
