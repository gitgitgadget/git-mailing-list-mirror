From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 22:36:46 -0700
Message-ID: <7vsiy1j7dd.fsf@alter.siamese.dyndns.org>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
	<CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
	<xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
	<CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
	<CAPig+cR0Z0gghUH5C6+XCuGQ3gz5JoWrnObVbbA5_ahPmC8G2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 07:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCk3K-00010Y-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 07:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab3HWFgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 01:36:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303Ab3HWFgu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 01:36:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 516FF36427;
	Fri, 23 Aug 2013 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJ8AbUHnf+PSRj/jGOeYiv2STUM=; b=gSmM+r
	ZyxU6DjZ7IfoSVcxLzQ/QgmTsAgQlRcfB1h1JtKA/oJvT6uuBJriTb1GJJf3JFjN
	6BTVKFtPpifa+PerLKoln+f3VGBCaQNLWhxjZ8Ywl3XCAuDcj5SilKr1Ntov9ntc
	XLiOZwAeDpsg4W01Hpjvs+JPcptCM9E/jEau4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QaRnPPIRpqBFhWZ62PrXjxNpm557Cvy2
	RrPYHuraCrAofHwyQIOC3OJinSdAv+xU8E8DhyZqp4/ccCwMi9fyGOrmTm7lyAam
	qzxp1K9xz9Jc2qDUSoqT5wy6zl0re/nVE2sDcEN0B8o4J9sRwcKd1fbwlAl1gvrp
	rvHDyxk3uIs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43DC036425;
	Fri, 23 Aug 2013 05:36:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9913736424;
	Fri, 23 Aug 2013 05:36:48 +0000 (UTC)
In-Reply-To: <CAPig+cR0Z0gghUH5C6+XCuGQ3gz5JoWrnObVbbA5_ahPmC8G2Q@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 23 Aug 2013 00:32:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01612C7A-0BB6-11E3-9C6D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232800>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I sent a patch [1] which resolves the problem, although the solution
> is not especially pretty (due to some ugliness in the existing
> implementation).

Yeah, thanks.

I tend to agree with you that fixing the "icase" callee not to rely
on having the trailing slash (which is looking past the end of the
given string), instead of working that breakage around on the
caller's side like your patch did, would be a better alternative,
though.
