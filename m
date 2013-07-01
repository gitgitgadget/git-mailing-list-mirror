From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Mon, 01 Jul 2013 15:05:04 -0700
Message-ID: <7vip0uaq02.fsf@alter.siamese.dyndns.org>
References: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
	<CAM9Z-nmk1qfQZLCH1g2DVaZXm+WY03oTr19ZRZ8L9rb1apSz6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	=?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmLB-0005bA-QZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666Ab3GAWMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3GAWMs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CCE32D36D;
	Mon,  1 Jul 2013 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=IC1nlv5uXu1O2wxl3BepqzZHXGQ=; b=yGPuzTY3A043E021ddA1
	2emDzmwUZzL0vicOUx6wstTCXc3RXCqQa9sfLRyN/DvNpmepjvJS73phtzcBzD+U
	WeiEE0DyTJ7GTuuAmOQkZBaMaHbXg/yZRPj3epbqO344XudNh5li22jo7D1gnO+O
	sm+0XrCxGGYelpnB32E3SnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aIFx86d8KcLESa2Qtf7CO7WsVYNHVufe51K4N3krl2fI2L
	A1P7wGSiEzNE3yDAjE11XcyE6NRAPekDfB+cz/7TAwmfuFg/HFJi4WPuENzbksDr
	v31SFs2LpOpKU+AtEUAnOMZ+oifDFnNb3JT2mRsc60nc2Qe2u1yXql6vDFa5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B1C2D36C;
	Mon,  1 Jul 2013 22:12:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E20712D368;
	Mon,  1 Jul 2013 22:12:46 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C354EB8-E29B-11E2-8E6C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229335>

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

Ping?  No need to hurry but in case somebody else is interested but
is stopped because of this offer to review...

Thanks.
