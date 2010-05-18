From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Tue, 18 May 2010 09:51:09 +0200
Message-ID: <4BF246ED.3040706@drmicha.warpmail.net>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>	 <201005171632.48253.trast@student.ethz.ch>	 <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>	 <201005171712.22763.trast@student.ethz.ch>	 <20100517175939.GA3575@efreet.light.src> <1274122619.4780.36.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Tue May 18 09:51:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEHaC-0006Yd-I4
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 09:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab0ERHvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 03:51:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44991 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756483Ab0ERHvM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 03:51:12 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 99033F79EA;
	Tue, 18 May 2010 03:51:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 18 May 2010 03:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ttvusu4V/LLRnCPMnIVZ3k3NvtY=; b=URnPaam6C+f7hQ/EB37Hx5DwLDowqPJNRmDnCERIRXuHFRS6BYO02UKNx55+HH/9u30HursFes8g8+Z0ftHwNs8E52Ww6yH2QA4PNDVuT6QeAPqBni7mU4n9niHcHgMcbCZ7YEac24OmeZtFqk7uEQOLjPmCF/t4YpLNBuGj2/g=
X-Sasl-enc: 8Z06BtyQM1Kv4x3SiSv7qEeIjmFLgviafJRSbu2WrcMW 1274169062
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7006D4B2345;
	Tue, 18 May 2010 03:51:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274122619.4780.36.camel@dreddbeard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147275>

Will Palmer venit, vidit, dixit 17.05.2010 20:56:
> On Mon, 2010-05-17 at 19:59 +0200, Jan Hudec wrote:
>> On Mon, May 17, 2010 at 17:12:22 +0200, Thomas Rast wrote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Mon, May 17, 2010 at 14:32, Thomas Rast <trast@student.ethz.ch>=
 wrote:
>>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> There are cases though, where somebody calls *porcelain* commands in=
 their
>> scripts and there they occasionally may need this LC_ALL=3DC thing. =
I suppose
>> having a global option to turn off localization might be useful for =
such
>> users.
>=20
> Would it be that bad to define something like GIT_PLUMBING=3D1 to mea=
n "I
> am using this as plumbing"? It seems that this is the way things are
> headed with --porcelain, even if the name is backwards.
>=20
> I agree that error messages should be localised either way- if you're
> trying to parse an error message, something's always gone wrong.
>=20
> Does anyone know how large of a non-english-speaking community git
> currently has? Would this effort include adding localised git command
> names or arguments?

Note that "non-english-speaking" here really means "requiring or badly
wanting translated git". There are many non-native speakers here, and
your following reasoning

> It may also be worth mentioning that a git "commit", for example,
> doesn't have anything (other than historical reasons) to do with the
> English word "commit". A git commit is a git commit, and perhaps such
> conceptual terms should best be left untranslated anyway. It would
> certainly make it easier to answer questions in #git if people contin=
ued
> to use the same terms everywhere. Just as a weak anecdotal argument,
> when someone uses the term "revision" in #git, there's generally a la=
ck
> of understanding about what a "commit" is. "commit" means something v=
ery
> specific in git, and I would hesitate to try to translate that into
> another language as if it's just a synonym for "revision" or
> "checkpoint", or "transaction", etc

explains why many non-native speakers prefer an English git. When
confronted with the localised German git-gui for the first time, I
really did not understand the menu entries at all. And my German is
pretty good ;)

Michael
