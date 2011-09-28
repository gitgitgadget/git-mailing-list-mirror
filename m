From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch
 head'
Date: Wed, 28 Sep 2011 11:17:29 -0700
Message-ID: <7vwrcszg3q.fsf@alter.siamese.dyndns.org>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
 <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
 <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
 <20110927233549.GA10434@sigill.intra.peff.net>
 <7vpqiltsky.fsf@alter.siamese.dyndns.org>
 <CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
 <vpqty7wok5a.fsf@bauges.imag.fr>
 <CAMOZ1Bu8UiV+Z0+0CLjxSv5Zic8i4=aGxnzmLc+H7c2T-P4avw@mail.gmail.com>
 <vpq4nzwoj1o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 28 20:17:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yhN-0004fh-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 20:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab1I1SRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 14:17:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58620 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab1I1SRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 14:17:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0256A460D;
	Wed, 28 Sep 2011 14:17:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PTqRP1IxTM/M+sZ4kCgSmO6qJxc=; b=cZ0Mre
	v/A7U71goGGG0EV6jN3f5NYRDAJrzCdQEuicpBsIv7ge+HYKQ05Q9y7c5kixCbtu
	m88U2Rugc4yYdRaYTCJYuyCbTsAqr+LqMyJa2b9xaoGW2wXxKeaJLZ9QaXz+SjkO
	uHy9udjd4v1m1Q8U57oQIozEUUf5lHZqb3sow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fxKOO/f+GLRK1LlljEcqbadk6tFWLnUk
	vkPTHhKCvJajRUVi7FGfp0CJpuDGrPpzVaF5JD+xbnSOr/Im8a3jOuQo/upt9EXh
	6BjixSjIPrnfP4IdhdNyNQ06W+WVqidIqJIhFQAQZh2L7awx9aYVggzA5SHe8Yf5
	qLNKY4zkyp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC4BC460C;
	Wed, 28 Sep 2011 14:17:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CB46460B; Wed, 28 Sep 2011
 14:17:31 -0400 (EDT)
In-Reply-To: <vpq4nzwoj1o.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 28 Sep 2011 16:09:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 218C68C4-E9FE-11E0-9FF7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182355>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Michael Witten <mfwitten@gmail.com> writes:
>
>> Well, as Junio mentioned, "--orphan" could be deprecated in favor of
>> "--no-parent"; the uncommon nature of this task works to our
>> advantage, in that it makes a deprecation of "--orphan" easy.
>
> I agree that _some_ cases would be more natural with commit --no-parent,
> but I disagree that it is a better solution in general.

Just for the record, in my later message after reading Peff's response, I
said I agree that adding it to "commit" would be a mistake.
