From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Mon, 21 Mar 2016 09:07:36 -0700
Message-ID: <xmqqy49bn7av.fsf@gitster.mtv.corp.google.com>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
	<xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQYYPmUtOoTGDzzQJC8n+9UoVEskmnZ19E=rroyU5+Pkg@mail.gmail.com>
	<CAJPOeMd-zeThDhx-OWW_6LwG9A+U3UU-oKPOZGcycR-xQRPcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:07:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai2Mq-0003Yr-A4
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 17:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361AbcCUQHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 12:07:40 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756044AbcCUQHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 12:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BDD14B24B;
	Mon, 21 Mar 2016 12:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/cYaHhaDj9y8qa4QGoaJHyT6gyY=; b=ijKwSP
	3kE/b0a1URxhm1QdbZ13N2UHXxsh54M7XKL7bFWMExgFXFGyffTdwjJ2RxZiLg//
	FlnwaNdIi/XaanyzejU2NZ4bfx534p4c7d2RDG/1JEy50USWp9RPKvaaRvd6dual
	/XxLraZ5V0gXpYrp+lpI+6KWucCUi7iWtRMDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QAq4SvbLH5pjjs8YN+MileYORRHAVuXL
	Qkxx09mzwPQwlhQudkZHQvXBafnuIhpJm8J2QiYSPkxXucMNB42g8Si1vCqToFPK
	edoMWhVMaoL4XBjcj9CLYclDc5Bud/gQtBnah6REHoVQDz47y+9k1kPH0YAoJ3jq
	gad98jF6Aqw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13D044B24A;
	Mon, 21 Mar 2016 12:07:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 89E0C4B249;
	Mon, 21 Mar 2016 12:07:37 -0400 (EDT)
In-Reply-To: <CAJPOeMd-zeThDhx-OWW_6LwG9A+U3UU-oKPOZGcycR-xQRPcgg@mail.gmail.com>
	(elena petrashen's message of "Mon, 21 Mar 2016 18:12:36 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07D21DD0-EF7F-11E5-8B94-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289423>

elena petrashen <elena.petrashen@gmail.com> writes:

> Hi Eric, Junio,
>
> thank you very much for your feedback! I honestly apologize I
> got so many things wrong.

Nothing to apologize. You are not expected to know all the local
conventions from the beginning, and we appreciate your willingness
to adjust ;-)

> I'll try to minimize the scope a little bit for the next attempt to
> make sure my approach is good first and then expand:
> i.e will only teach git branch to delete "-" & give out an
> error message in case there is no previous branch
> to make sure I got the basics correct.

Sounds good.
