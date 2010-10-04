From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 04 Oct 2010 11:28:35 +0200
Message-ID: <4CA99E43.1000204@drmicha.warpmail.net>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de> <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com> <1285967766.6750.2.camel@gandalf.stny.rr.com> <4CA9815D.3040801@drmicha.warpmail.net> <20101004075015.GN28679@pengutronix.de> <4CA98EF1.1050102@drmicha.warpmail.net> <20101004085050.GQ28679@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 11:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hLT-0001e1-Rp
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab0JDJ2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 05:28:25 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53136 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754371Ab0JDJ2X (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 05:28:23 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 67EEC364;
	Mon,  4 Oct 2010 05:28:23 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 04 Oct 2010 05:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6IyC1XfD6+6OgmmjbibPTp05p98=; b=JdUPQqvpUszs/Q9uP6ZQFTVIJHAGNkasGLeigACcf18RZ1N04xcX/frmMinvNWDKY4ETK8K1fRMK3SFijqVbW1Dh3dTxeuooCw8Hku2Thr1F3XJhyr3VpT0zIYAt2M1SgXkGyqQtC4xkML4ag4Qo1DUklBRgdEaU0r80K9MObU4=
X-Sasl-enc: lEd31JG/8cRyQSyVHBskOkNE4La4odtN5kfGhao1JN0O 1286184503
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8D16A5E755E;
	Mon,  4 Oct 2010 05:28:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101004085050.GQ28679@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158017>

Uwe Kleine-K=F6nig venit, vidit, dixit 04.10.2010 10:50:
> Hello Michael,
>=20
> On Mon, Oct 04, 2010 at 10:23:13AM +0200, Michael J Gruber wrote:
>> Uwe Kleine-K=F6nig venit, vidit, dixit 04.10.2010 09:50:
>>> Hello Michael,
>>>
>>> On Mon, Oct 04, 2010 at 09:25:17AM +0200, Michael J Gruber wrote:
>>>> Steven Rostedt venit, vidit, dixit 01.10.2010 23:16:
>>>>> On Fri, 2010-10-01 at 13:18 -0700, Darren Hart wrote:
>>>>>> 2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>>>>>>> Some people in #linux-rt claimed that you cannot define "--mirr=
or" with
>>>>>>> "mirror".
>>>>>>>
>>>>
>>>> I'd say "mirror" is a commonly known term for an exact copy. Moreo=
ver,
>>>> the text below doesn't explain what a mirror is either, only how
>>>> "update" behaves in it.
>>> hmm.  The --mirror option doesn't have any effect (apart from the
>>> changes in the config file) until you update.  So I think it's natu=
ral
>>> to talk about git update.  No?
>>
>> "git clone" (with or without --mirror) does a couple of things, and =
it
>> does them differently when "--mirror" is used. It mirrors each branc=
h
>> from the source repo in the target repo under the same name, includi=
ng
>> for example any remote branches in the source repo. This is complete=
ly
>> different without "--mirror", where clone does not look at the sourc=
e's
>> remote branches at all. Also, it sets up a mirroring refspec, i.e.
>> +refs/*:refs/*
> Ah, didn't notice that.
>=20
>> [...]
>> This makes me think that --mirror should be explained on top of --ba=
re.
> OK.
>=20
>> For example:
>>
>> In addition to the mapping of local branches to local branches which
>> --bare does, --mirror maps all refs which the source has under the s=
ame
>> name in the target (including remote branches, notes etc.) and sets =
up a
>> refspec configuration so that all these refs are updated by a `git
>> update` in the target repo.
> Hmm, I didn't understand this when I read it the first few times.  Th=
e
> special thing is that --mirror maps *all* refs, not *same name*.

Yep, my sentence was bad, it could be misunderstood.

>=20
> So maybe:
>=20
> 	Set up a mirror of the remote repository.  This implies `--bare`.
> 	Compared to `--bare`, `--mirror` doesn't only map local branches of

"does not"

> 	the remote to local branches of the target but all refs
> 	(including remote branches, notes etc.) and sets up a refspec

Maybe "of the source" for "of the remote"? Because remote comes up righ=
t
after in a different meaning.

> 	configuration such that all these refs are overwritten by a
> 	`git remote update` in the target repository.
>=20

I like that a lot!

> I choosed to write "overwritten" instead of "updated" to make it clea=
rer
> that it makes no sence to push into these branches from a different
> source.  Should this be noted more explicit?

"update" may be more Git lingo but I think either is fine. "overwritten=
"
makes it clearer this is not a repo to do development in...

Cheers,
Michael
