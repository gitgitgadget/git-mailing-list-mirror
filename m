From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Tue, 12 Oct 2010 10:33:20 +0200
Message-ID: <4CB41D50.9020208@drmicha.warpmail.net>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net> <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com> <4CB2FEB8.3050705@drmicha.warpmail.net> <201010111718.39996.jnareb@gmail.com> <4CB32D15.4080204@drmicha.warpmail.net> <AANLkTimAj_sCquCixmTOEV5ZaQVbbv-yvm=Yw82har1t@mail.gmail.com> <20101011162638.GH25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 10:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5aIP-0005q5-5s
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 10:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002Ab0JLIdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 04:33:07 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35645 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756973Ab0JLIdF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 04:33:05 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5D56E57A;
	Tue, 12 Oct 2010 04:33:05 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 12 Oct 2010 04:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Juu0uVp6uOGZvh8fN0b0lJ/rg/U=; b=WdTC8WWHAH9MEb86t4aRL6TheSdT5LV7DwK9i2gl/RaNnyHlAojhYtsgAqLM2lZ1sc2km0U4xw8Xw4rUMSy1yfgkPU/9PI/6goacos+YIsmmn6RVFApP6/kwbBKY63aSFMMMxcr4793Lho5z8455bvFNmNIai4FO9XQ3jJXuIl0=
X-Sasl-enc: iz6lO5jbVPgzj/WzOJ592UqNxoFSoRWiMrpc8TxCG0d9 1286872384
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F104D5E3B4B;
	Tue, 12 Oct 2010 04:33:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101011162638.GH25842@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158824>

Jonathan Nieder venit, vidit, dixit 11.10.2010 18:26:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Oct 11, 2010 at 15:28, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>=20
>>> My observations on the list don't quite confirm that "configure" ca=
n
>>> only improve the make situation, but I don't use it myself. So, I'l=
l let
>>> those give configure advice who use it.
>>
>> If it doesn't improve it that's a bug that we need to fix.
>=20
> Probably Michael was referring to the FreeBSD 4 thread:
> http://thread.gmane.org/gmane.comp.version-control.git/158639
>=20
> I suspect it has nothing to do with "configure", but given that
> most of the active developers do not use autoconf, it tends to be
> the first unknown one is tempted to eliminate.

That thread was just the hair-trigger, so to say, there were many other=
s
in the past. But it's very typical. We often have "Don't use configure =
-
it's second class"-type answers to build problems. I don't really
remember that many "I use configure, and it works here"-type answers.

Given the vigorous defense showing up here against deprecating configur=
e
(in the sense of declaring it second class), we can all be confident
that there will be many knowledgeable and helpful answers to build
problems for configure users, right?

Michael
