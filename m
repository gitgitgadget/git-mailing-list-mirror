From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Individual file snapshots
Date: Sat, 13 Feb 2010 10:58:19 -0800
Message-ID: <7vy6ixj73o.fsf@alter.siamese.dyndns.org>
References: <ron1-CD3223.04030512022010@news.gmane.org>
 <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org>
 <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>
 <ron1-62D136.13570812022010@news.gmane.org>
 <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com>
 <ron1-5EFFD7.14390512022010@news.gmane.org>
 <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com>
 <7v6362c672.fsf@alter.siamese.dyndns.org>
 <ca433831002130713i5b015686k9f53911954858845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 19:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgNCL-0003fR-GC
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 19:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab0BMS62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 13:58:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586Ab0BMS62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 13:58:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A52F599F05;
	Sat, 13 Feb 2010 13:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b5zoEqLvCI7UANHdmFJ11axXuIQ=; b=WBS+iH
	Z/C6uRlgU9r5Jp8c6Hcpc82lCfBZ0xVAhpMKb0QH5a1MQ8H4RVZ5mif3IksTW2Py
	0KWZeRXaRIcDOtCtUCHfW64Uw0hhdYxWizwZ2dAakf9joVThkuhSOdwa7zEwJjVf
	eFlVIHYtalWQdsnskg97BH2pAZ9Y8Zm672gwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9Zl8fW9Z1deg5SNdhat2xIFqa5C6/GW
	4ecvdQKOm8gnSPEaGEKVyW/vRqqe8ZhXe/QmbLuusf452vRpboGtGz2LN594IQKE
	zBl5RuaCMYwSrNfqX6+Q+nH1sapcLVzsVE28CiHoBWV6UQcrS/ZOFhZopFuPsqJy
	GJ4dcTTmqY8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7150A99F04;
	Sat, 13 Feb 2010 13:58:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D1899F01; Sat, 13 Feb
 2010 13:58:20 -0500 (EST)
In-Reply-To: <ca433831002130713i5b015686k9f53911954858845@mail.gmail.com>
 (Mark Lodato's message of "Sat\, 13 Feb 2010 10\:13\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C311B942-18D1-11DF-8C32-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139822>

Mark Lodato <lodatom@gmail.com> writes:

> ...  Besides, using GIT_INDEX_FILE as suggested
> by Junio allows me to leave the original index file intact.

Heh, that is what the Professionals use ;-) It is used by git-stash.sh for
example.

Aspiring Porcelain authors would benefit greatly by learning from some of
the few remaining scripted Porcelain commands.  With the recent rewriting
to many of the originally scripted ones in C, it may have become somewhat
harder to learn the plumbing mechanisms and techniques that way, but we
still keep some older ones in contrib/examples directory for that purpose.
