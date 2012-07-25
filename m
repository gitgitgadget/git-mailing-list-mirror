From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] difftool: Simplify print_tool_help()
Date: Tue, 24 Jul 2012 19:40:38 -0700
Message-ID: <7v629cef6h.fsf@alter.siamese.dyndns.org>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
 <CAFouetjhGChULHa-Ax9oR--TccyEBnqn=UATbMpJxcdm3AOE1w@mail.gmail.com>
 <CAJDDKr47F9ZAPPCnFBdPYhQsx8qGGggHHrFWeZw2zpf-mukq5w@mail.gmail.com>
 <CAJDDKr6JcbKkvg-9M6Sf4i0+YrMFJeKhmVoxQ_g1QBCRnoGRxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 04:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrWq-0008E7-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 04:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab2GYCkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 22:40:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480Ab2GYCkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 22:40:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 107D78FF3;
	Tue, 24 Jul 2012 22:40:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yh8gGGUNZKL99xFTO4MyVfnR9LQ=; b=Nb/xr+
	s+A9XCsyS5h6fvrjcsk4t1pIy9R4gaUsmV89sc/54hj2H817Z5nPtzkxGm9kzmh5
	f1iTTdTlPrl+C189zDJUXYwpYtRHikvIa2C51GEI+kJc1/sYX0OjySML1FxyhD3x
	wIGIm+rl88lgIzStc/6v/coxACRXoc8nGWQVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JMkZVsxZE6Bo+JfMocOfrmhrLpdqI5bi
	NRolRlcHMA5/U9FHZ1/Neqy+O/b3Q+ArelgA5qJWId9J8AF/9nT1Nnr2gL9YuhCJ
	anCjiw6wXbYlQTtMaqTTw9w933QvpRToaBaJHMenEP94Szz14++mhusnhZDKtMEg
	k1IMzrG9DaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F19DB8FF2;
	Tue, 24 Jul 2012 22:40:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 545468FF1; Tue, 24 Jul 2012
 22:40:40 -0400 (EDT)
In-Reply-To: <CAJDDKr6JcbKkvg-9M6Sf4i0+YrMFJeKhmVoxQ_g1QBCRnoGRxw@mail.gmail.com> (David
 Aguilar's message of "Tue, 24 Jul 2012 19:18:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F6FE872-D602-11E1-9D30-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202092>

David Aguilar <davvid@gmail.com> writes:

>>> Does this implementation handle that case?  I'm sorry, but I haven't
>>> had time to apply and test myself.
>>>
>>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/193233/focus=193925
>>> [2]: http://thread.gmane.org/gmane.comp.version-control.git/194158
>>
>> Good catch.  Eliminating the globals should be the goal, then.
>> I'll have to re-roll.
>
> Junio, would you prefer follow-up patches or a rebased series?

Incremental patches, please.

Thanks.
