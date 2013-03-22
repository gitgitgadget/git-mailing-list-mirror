From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 07:52:47 -0700
Message-ID: <7vmwtv8p1c.fsf@alter.siamese.dyndns.org>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com>
 <20130322144454.GA3083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3LJ-0003Z3-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601Ab3CVOwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:52:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933594Ab3CVOwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:52:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D957B6CF;
	Fri, 22 Mar 2013 10:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u06NS3b8zNgFRzVie2D+7/VG4jE=; b=G4owv4
	KPQWyGv3IMH/RReQsnqQXhZpS2M4fr8EOtRn83IkOtZbRRZPK4f2K3PA+kjoJdGc
	HNf4/dILIPuBJkCzG+xAZbfKautp/9N3Fz0WWXD61SmXZGGc7GSicOEbB5MiMAHM
	zNOWqxcdKjSi5yxos/sQd05xwUTubLoM21BNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GH/F4RC+E+LqTEB71CFPmpFsAyAte6dL
	W75cG5JNCMAE8/BBunSbB7jnoMnqkVcqwCeNV0kJ5/Eis/q8NbTy4s7RulnZRaJN
	xs4tqZVBR6er7ItPCfVhAqbdVDwKNZErurXZwRm68IOrgL4owBukiKP0WlAiZ62C
	PUzWK5LIIX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 315E2B6CE;
	Fri, 22 Mar 2013 10:52:49 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A90A4B6CD; Fri, 22 Mar 2013
 10:52:48 -0400 (EDT)
In-Reply-To: <20130322144454.GA3083@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Mar 2013 10:44:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29E9CCEE-9300-11E2-9A6A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218805>

Jeff King <peff@peff.net> writes:

> I think this is OK, and I do not mind if it gets applied. But what I was
> hinting at in my earlier mail was that we might want to do this (I have
> it as a separate patch on top of your 3/6 here, but it would make more
> sense squashed in):

I would prefer to see a preparatory patch to teach mk_test/mk_empty
to _always_ take the new name (i.e. the result of your patch) and
then do whatever new things on top.

By the way, I am planning to _not_ look at new stuff today. I'd
rather see known recent regressions addressed (and unknown ones
discovered and squashed) before we move forward, and I would
appreciate if regular contributors did the same.

Thanks.
