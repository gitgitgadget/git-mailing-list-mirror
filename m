From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add: Add the "--ignore-missing" option for the dry
 run
Date: Mon, 12 Jul 2010 15:14:41 -0700
Message-ID: <7viq4k8i0e.fsf@alter.siamese.dyndns.org>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com>
 <1278351183-18734-1-git-send-email-avarab@gmail.com>
 <7vmxu572w5.fsf@alter.siamese.dyndns.org> <4C33A552.5060008@web.de>
 <AANLkTinn_Vz6I619Do4AOCVMUgfpyy84L1wh3lkuCP7R@mail.gmail.com>
 <4C37A03E.7030801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 13 00:15:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYRHB-0001M1-Me
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 00:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab0GLWOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 18:14:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab0GLWOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 18:14:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6EAC3740;
	Mon, 12 Jul 2010 18:14:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GqnpLAEjBfrOqU276Ilm+glPQ7s=; b=DoODjX
	HOkrV//5C08HhgapFmEdeLkT+UCmW506IJQzKiA8amqztS0+TrFqhNm1FHHIhGWL
	PKcgEjEWi/JcV+jXA3dSVDZd6ltYz5Z1A7vTYYwO7ow3mh1d7r1bomPgbUQD0oI5
	eRIU//iy3DosXTsx5fyGgrPiFaqOhqT9vcLFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgwhbjESF4HdCI3jsCKl6WRu86RLgzUd
	rFpOlCjoRxtfCWCs85Pcjsjh7HPdui4x1IGZKCBN5ZCIigjmoXkD/LKI6v6Y6AY3
	QmCPxDExfR0/9JVF79v326vLPCt/+gYD/nKRdnUp0sAewof2BkK3/WFd47jyh6HU
	afbzB+2VgMw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC3CEC373F;
	Mon, 12 Jul 2010 18:14:46 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0723C373D; Mon, 12 Jul
 2010 18:14:42 -0400 (EDT)
In-Reply-To: <4C37A03E.7030801@web.de> (Jens Lehmann's message of "Sat\, 10
 Jul 2010 00\:18\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E175E7FE-8E02-11DF-BD69-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150851>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> With this patch it should be easy to have "git submodule add" return
> an error /before/ adding a submodule path and its contents when it
> is found in .gitignore.
>
> Opinions?

Sounds like a right thing to do.
