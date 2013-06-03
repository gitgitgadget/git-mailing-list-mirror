From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 03 Jun 2013 08:28:52 -0700
Message-ID: <7vsj0zjjrf.fsf@alter.siamese.dyndns.org>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
	<CAM9Z-nmk1qfQZLCH1g2DVaZXm+WY03oTr19ZRZ8L9rb1apSz6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	=?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 17:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjWgu-0002Po-OV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab3FCP24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 11:28:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756753Ab3FCP2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:28:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 209B024EC7;
	Mon,  3 Jun 2013 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/1biPvbEXFYgfHjWSdV7kg2AoUA=; b=WzFG7H
	aWl6vBgtnKf8v9D4LZjgIo2TVjERp7omrMEGAlkgmeK2CwQJgir3rK8dAe+gNvg5
	/Av60DRk0j3kwQK07ykKgji9OEWJRbVdocapReXoaAKn0PAJuS/JIGgMSwbAdhkU
	Qe/twi5o1wJPkeVg8dV4wwARb5ZWUJ12E7imY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZeM6aEH6uAMcF7RuWMpeqrrFjeTzcmMB
	lEAeUz9eFD12NpitApiKVycDW/PnLT4lsmoqTh6gOMx11vTfnkN/oJXpDFb7/J+K
	AOewDBhbSe6XpBiS7ZKuk5tCzw6mqvfMzzcCGfIxAmkfO6eJhyZd6tgFQqBIe7l7
	wm5VmSzP2Cg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0814E24EC6;
	Mon,  3 Jun 2013 15:28:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A60524EC5;
	Mon,  3 Jun 2013 15:28:54 +0000 (UTC)
In-Reply-To: <CAM9Z-nmk1qfQZLCH1g2DVaZXm+WY03oTr19ZRZ8L9rb1apSz6Q@mail.gmail.com>
	(Drew Northup's message of "Mon, 3 Jun 2013 08:10:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CEA3986-CC62-11E2-8D0F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226221>

Drew Northup <n1xim.email@gmail.com> writes:

> On Sun, Jun 2, 2013 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> --------------------------------------------------
>> [Stalled]
> ...
>> * jk/gitweb-utf8 (2013-04-08) 4 commits
>>  - gitweb: Fix broken blob action parameters on blob/commitdiff pages
>>  - gitweb: Don't append ';js=(0|1)' to external links
>>  - gitweb: Make feed title valid utf8
>>  - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch
>>
>>  Various fixes to gitweb.
>>
>>  Waiting for a reroll after a review.
>>  Will discard unless we hear from anybody who is interested in
>>  tying its loose ends.
>
> I'd like to have a closer look at these. It may be a week however as
> there's some serious in-house chaos going on right now. (Finally
> starting to settle after about 2 months...)

Thanks.
