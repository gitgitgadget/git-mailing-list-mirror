From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Improvements to githooks.txt documentation
Date: Mon, 25 Apr 2016 11:34:42 -0700
Message-ID: <xmqqeg9tlepp.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
	<1461593665-31395-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:34:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulLO-0007SJ-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307AbcDYSeq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 14:34:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933040AbcDYSeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 14:34:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0152314707;
	Mon, 25 Apr 2016 14:34:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k5XBLdBCGshR
	6i4oqL+bNFxre1E=; b=d+yLtaC+BJ2C/J4gP+NAMLhg0rH9OXi4AhXBcYjs5hV1
	OpqCZP6McE6xs2ipaAqRGGU0OPswMb7asdpffUcftz/rDrsnmY0A1rLDcuTI2RQX
	Ak/EaKsrMcIsoWnBDNM1ZOvif9jp4Ztdw9T++ZufWFO4xQ0c8ank74CEBTuhbuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UdJijQ
	zvyS7k3aFp6FcAAU82b7nqW5FqZuZ0GPoP4k2UgszUUkdIHkLvwKczamDyuSa5Qx
	goxoniKno6batlNgqxPIckuon1XZdg4plL5D03qXSIq0kruLO9+gv+X0/4DZ5VZv
	elzBLLk4WgmfWDeXLLeXDR6h9CbeatoC+Xvco=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC7B014706;
	Mon, 25 Apr 2016 14:34:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 675CB14702;
	Mon, 25 Apr 2016 14:34:44 -0400 (EDT)
In-Reply-To: <1461593665-31395-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 25 Apr
 2016 14:14:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 617F3178-0B14-11E6-B548-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292541>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This includes minor grammar edits pointed out by Eric Sunshine + the
> one v2 patch I sent out in response to comments by Jacob Keller.
>
> I thought it was less confusing to just send out a whole v3 series
> than ask Junio to piece together v1..v3 of various patches.

Yup, that greatly reduces the chance of screw-up on my end and is
very much appreciated.

>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   githooks.txt: Improve the intro section
>   githooks.txt: Amend dangerous advice about 'update' hook ACL
>   githooks.txt: Minor improvements to the grammar & phrasing
>
>  Documentation/git-init.txt |  6 +++-
>  Documentation/githooks.txt | 72 +++++++++++++++++++++++++++---------=
----------
>  2 files changed, 47 insertions(+), 31 deletions(-)
