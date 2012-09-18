From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive --format zip utf-8 issues
Date: Tue, 18 Sep 2012 14:12:19 -0700
Message-ID: <7v1uhzkpcc.fsf@alter.siamese.dyndns.org>
References: <502583F4.8030308@tu-clausthal.de>
 <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx>
 <5026D081.2040906@tu-clausthal.de>
 <20120830222603.GA20289@sigill.intra.peff.net>
 <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org>
 <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:12:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE55s-0002hN-QG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 23:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab2IRVMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2012 17:12:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab2IRVMW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 17:12:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CC3E96E7;
	Tue, 18 Sep 2012 17:12:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PxTlXtI8NVbp
	u/LKulHQzhcYfRY=; b=S0JZrhrqndZSkWW1s+qAl+7WQa46i2tlzObr36pWm7fW
	KyljMiDnTIzlRZXU1aRx5D11uV218NjPzr5vEnD1Kfo8A/vNQ1zUnzhHMJCq++88
	WiRRJWQtpShIGGdZpHviY9C5MbTDSy8S7tHWbpK5odvYt70CGjTxbq2AUUq1VA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NYyuF1
	PjMw17KEVk4WjU1Fg6WU/N8G+eD/3K9VkQ7A0OLVY/CAURrX7nIuu9XYqKh2KQLc
	XOncDRXExL12eI6BRs/LV258OKZUnuhiF/AKR6xdl94ryiP5vb9yLdCqCWso2MnX
	pCUgXg1CnvIiHUuFMMLvRwsMQgP8P75F7vetc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A04996E6;
	Tue, 18 Sep 2012 17:12:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C58C196E5; Tue, 18 Sep 2012
 17:12:20 -0400 (EDT)
In-Reply-To: <5058CE49.3070108@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 18 Sep 2012 21:40:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88BB4AA2-01D5-11E2-8697-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205875>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>                                          Windows    Info-ZIP unzip
>                             7-Zip PeaZip builtin Linux msysgit Window=
s
> 7-Zip 9.20                      0      0      46    26      43      4=
3
> PeaZip 4.7.1 win64              0      0      46    26      42      4=
2
> Info-ZIP zip 3.0 Linux          0      0      72     0      43      4=
3
> Info-ZIP zip 3.0 Windows       45     45     n/a     0      43      4=
3
> ...
> I wonder what 7-Zip and PeaZip do that gives them a slightly nicer
> score with the Windows-internal unzipper.  Umlauts, Nordic characters
> and accents are preserved by that combination.  It seems that unzip o=
n
> Linux fails to unpack exactly these names, so perhaps they employ a
> dirty trick like using the local encoding in the ZIP file, which make=
s
> it unportable.
> ...

Thanks for this work.

It is kind of surprising that "Windows builtin" has very poor score
extracting from the output of Zip tools running on Windows (I am
looking at 46, 46 and n/a over there).  If you tell it to create an
archive from its disk and then extract from it, I wonder what would
happen.

Does this result mean that practically nobody uses Zip archive with
exotic letters in paths on that platform?  I am not talking about
developers and savvy people who know where to download third-party
Zip archivers and how to install them.  I am imagining a grandma who
received an archive full of photos of her grandchild in her Outlook
Express or GMail inbox, clicked the attachment to download it, and
is trying to view the photo inside.
