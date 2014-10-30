From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] Documentation/technical: signature formats
Date: Thu, 30 Oct 2014 11:19:18 +0100
Message-ID: <545210A6.5020302@drmicha.warpmail.net>
References: <cover.1413990838.git.git@drmicha.warpmail.net>	<13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net> <xmqq7fzshqrb.fsf@gitster.dls.corp.google.com> <544B5FA1.2050804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 11:19:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjmpF-0005E3-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 11:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920AbaJ3KTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2014 06:19:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59271 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758919AbaJ3KTU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 06:19:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 284E920996
	for <git@vger.kernel.org>; Thu, 30 Oct 2014 06:19:20 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 30 Oct 2014 06:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=J1I/7X/z+assjvqJn/rPRs
	UqH9Y=; b=GRatOiXB/hXibp7XYTztzz5qccUnPyDsxOx5GabMCuguDNDyUYNSX7
	Rv8SbBV47NyG20QfXfFUFqf70zvq5VJ7lglvvJCC9KA5YuuP2n/D7KSxB/HyJ4gJ
	K9SiBwMFLjlgLkGGX2T56zt59vjp/EbvVqwE0c7uyJUbn+2syzPiI=
X-Sasl-enc: fPt8OxksptCbJLP4E3yPq40z8OAq1iUurAk4gVA++q5Q 1414664359
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 863336800C3;
	Thu, 30 Oct 2014 06:19:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <544B5FA1.2050804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski schrieb am 25.10.2014 um 10:30:
> W dniu 2014-10-22 21:02, Junio C Hamano pisze:
>=20
>> A mergetag is not fundamentally a "signature" in the above sense,
>> though.  It is just a dump of the object content in a regular object
>> header field (hence indented by one SP), and its contents having PGP
>> SIGNATURE is merely a natural consequence of the object recorded
>> being a signed tag.  So the description of it in the same place as
>> description for signed tags and signed commits feels a little bit
>> out of place, but I do not think of a better place to describe it.
>=20
> Does this mean that you can merge annotated (but not signed) tag,
> and have it (as description of merged branch) in 'mergetag' header?

We don't do that (so far).

In principle we could do that, of course. (But I really wish mergetag
would point to the tag object rather than embed it.)

But the point of the merge tag is to "bake into the commit object" some
verifiable information about the source of the merge, or rather about
some of its parents.

Just adding some non-verifiable, "come-and-go" information seems to be
more suited for notes.

Michael
