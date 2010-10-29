From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests
 with TAP
Date: Fri, 29 Oct 2010 15:19:20 +0200
Message-ID: <4CCAC9D8.20501@drmicha.warpmail.net>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net>	<20101014172301.GA2770@sigill.intra.peff.net>	<7vmxq0ebe9.fsf@alter.siamese.dyndns.org>	<20101027045709.GA11250@idm.gtisc.gatech.edu> <AANLkTimH=fbRAdz-F-V-9WTKzAyVvpzRHC06e+94a2wJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 15:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBorH-0005LI-SS
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 15:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695Ab0J2NS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 09:18:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48400 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756182Ab0J2NS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 09:18:57 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5EF3F734;
	Fri, 29 Oct 2010 09:18:57 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 29 Oct 2010 09:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tMSbu2WZjACdwTGv2rBVqXuhom8=; b=pAMC8R0cin8lBFMyZ/I8tf+hoKfw83jPxX+CVEYUT31ppjNPPseQePwnvz7Iu11lFZ7yreXNoSPyRocP7pMuG4RX2b4KWacskKww15tjNex4OUOpWMkizhZrIjII/gqU9p89nzi2t4ao9rpbemJEwjrLB9EDGoDY/i2v1fP8DXs=
X-Sasl-enc: 1IoyCkTKHe0yXtEFWcg8WW+DaWR8cEwKhyL7E48fEEoF 1288358337
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A22235EA6FD;
	Fri, 29 Oct 2010 09:18:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTimH=fbRAdz-F-V-9WTKzAyVvpzRHC06e+94a2wJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160331>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 27.10.2010 1=
3:00:
> On Wed, Oct 27, 2010 at 06:57, Jeff King <peff@peff.net> wrote:
>> On Tue, Oct 26, 2010 at 05:18:22PM -0700, Junio C Hamano wrote:
>>
>>>> like -j16, but it's a pain to construct the command line (especial=
ly as
>>>> I use --root in GIT_TEST_OPTS to get a significant speedup).
>>> [..]
>>> I kind of like this.  Perhaps with something like this squashed in?
>>
>> Yeah, looks good to me. I guess you can steal the commit message and
>> authorship from Michael's original.
>>
>> =C3=86var mentioned something about t/harness, which I honestly have=
 no idea
>> about (I don't have the right perl modules installed to run it). But
>> maybe that could be an alternate DEFAULT_TEST_TARGET. I dunno.
>=20
> The non-standard module there is only needed for the smoke testing.
>=20
> If we used t/harness for running "make test" that code could be
> modified to run anywhere prove itself does.
>=20
> Anyway, if there's a patch now to invoke prove(1) let's use that. We
> can change it to t/harness later if that makes sense.

Thanks, Junio, for taking this up (and others for discussing it), I've
been out of the loop a bit. I'll try and keep up with my other
half-baked patches ;)

Michael
