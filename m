From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 17:28:21 +0200
Message-ID: <4CB32D15.4080204@drmicha.warpmail.net>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net> <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com> <4CB2FEB8.3050705@drmicha.warpmail.net> <201010111718.39996.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 17:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5KIQ-0006qC-TW
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 17:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab0JKP2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 11:28:08 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37740 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754843Ab0JKP2H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 11:28:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8A2AF5A0;
	Mon, 11 Oct 2010 11:28:06 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 11 Oct 2010 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=w9dkQ+scpN/IeJ06eE81BmBKlQE=; b=XL28J+ccbXdeqsTwUju1sBykEo7lWjE0IyCNvuNW9Fpu/dC2TyXNrSIRD9P/xFP82ScuOBz6VBSGHQuoBvxi85rc/I7ZfmKRjx/zL8LbWhY1Nb+QNbTGhA4ckMm13DkyhnNqtDpDTSF9tgUNGHixb8llftRJYv2VzwLmsG5ndw8=
X-Sasl-enc: EzvsIsuQpAKNrWLZqSJJLWq7CXRj2c32G7Qt/C8hZ7iy 1286810886
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BF8B65EBAE1;
	Mon, 11 Oct 2010 11:28:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <201010111718.39996.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158766>

Jakub Narebski venit, vidit, dixit 11.10.2010 17:18:
> Dnia poniedzia=C5=82ek 11. pa=C5=BAdziernika 2010 14:10, Michael J Gr=
uber napisa=C5=82:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 11.10.201=
0 11:40:
>>> On Mon, Oct 11, 2010 at 08:39, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>>
=2E..
>> configure is a second class citizen in git.git (we even explicitly
>> .gitignore it - if you allow that lame joke),
>=20
> We .gitignore 'configure' script because it is *generated* file, and
> generated files should be not, as rule, placed under version control.

I don't know which part of "joke" was unclear?

>=20
>> But, really, the typical responses to build problems with configure
>> indicate that most long timers don't use configure either, and proba=
bly
>> don't feel too comfortable with it. So, I think we should either mak=
e
>> the status quo clearer (Makefile as primary method) or change the st=
atus
>> quo. I can only do the former ;)
>=20
> Because ./configure script enhances Makefile rather than generate it,
> using configure script can only improve situation (at the cost of ext=
ra
> cycles spent detecting)... well, with exception of rare cases bugs in
> configure.ac making it misdetect.

My observations on the list don't quite confirm that "configure" can
only improve the make situation, but I don't use it myself. So, I'll le=
t
those give configure advice who use it.

Michael
