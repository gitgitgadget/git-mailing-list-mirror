From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 13:09:54 -0700
Message-ID: <7v8v3lwa5p.fsf@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
	<7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
	<7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 11 22:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbG7F-0003Hb-4t
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 22:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3EKUJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 16:09:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738Ab3EKUJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 16:09:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AB3B1D06E;
	Sat, 11 May 2013 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OJtPieQxqI3v
	gVT65pSdxY1Q1mM=; b=sCoAGJuZW1EcFcZfiCSOWxSpogfraMjrcHPgeC47ZdWa
	S7gjTaKgpBjIbqmo1PmvmUnFWYRzm0G5/DkroGN7gn3aKyTCUEuhyhNEsvtCD0cb
	CPFURocVc7hn2Lo2OSm4kYTTliRyXuTx04MSuNr7nNByGqYKoyfUZsLddFPHnMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OxYPnF
	xXvJ5ctQ1ZxAhhjSekoudgp/B5rlAma2PRxnre/DlR4cTLR+QYTLthFUtm/YOh+a
	7SpagyCmbxQpBCwEkEV7dFY1PfPXIDn13ilZdSE1LprCa24bBE2ME/9+/w2v09U6
	1yRdQAHS46eDvTlYWOHtdhsFGn08b9C7o+zek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EA1A1D06C;
	Sat, 11 May 2013 20:09:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD4D51D06B;
	Sat, 11 May 2013 20:09:55 +0000 (UTC)
In-Reply-To: <518EA351.8000603@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 11 May 2013 22:00:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF977E1A-BA76-11E2-9C24-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224008>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> I did,
> the interesting thing is that the test passes with and without your p=
atch.
> (After enabling  GIT_TEST_LONG and GIT_TEST_HTTPD in both cases)

Strange.  Do you see differences between the produced packed-refs
file?
