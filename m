From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 10:56:44 +0300
Message-ID: <CAMP44s3mnnhKXHUEMSX+d2L2Jyqr9_Q7F=3DvWb4MKxHpTRREg@mail.gmail.com>
References: <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<7v7gxftn78.fsf@alter.siamese.dyndns.org>
	<CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
	<20120416224411.GU12613@burratino>
	<CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
	<20120416231626.GW12613@burratino>
	<CAMP44s3OSepH_XpCcTWLN=bF0+P9fmHtyPnWdQnEocW25jHTpA@mail.gmail.com>
	<20120417073653.GB20017@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:56:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3HP-0002N9-6N
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab2DQH4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 03:56:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50254 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab2DQH4q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 03:56:46 -0400
Received: by eaaq12 with SMTP id q12so1479920eaa.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/LXT61MSCxw7Lp4qRQFG6zgr2P6I5/qP641Qo20xP4w=;
        b=ARRLCNjOrJU+ew2LVM8wQr2xHRQrdIK4yBiwjkivu7JLCpMg0e7Ethn0PB3ruE+wWT
         RfT2EnEdnUrVFvgUBe8DlaACH8uAUAPrqJlCSIvaHHjXVSAsG1giJJw2tBGCkB6zpiHn
         gbp8PNLrSs5smwyhevBK/Ve9i+EVJOhvHjAQfCIiPC8RU3Awvy902Ntstm1ZSDsiNm8W
         BcqaAqWe+y7RkbKjrnGWJlebNcpmqkx17khp3LkhulPVNRTsAbSae1Dgg3EFP+B9C8gX
         lDcerir/8SF6cfYhVb3uRt/QCx1zdGEXRdbYFrAHqdPmnC8Dvg2yYD5s2LOKrg9M00Ra
         7eMQ==
Received: by 10.213.6.195 with SMTP id a3mr1015696eba.78.1334649404694; Tue,
 17 Apr 2012 00:56:44 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Tue, 17 Apr 2012 00:56:44 -0700 (PDT)
In-Reply-To: <20120417073653.GB20017@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195740>

On Tue, Apr 17, 2012 at 10:36 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>
>> You are the one who brought the argument that even public functions
>> have the '_' prefix, so it's *your* responsibility to substantiate
>> that argument.
>
> No, honestly it isn't my responsibility to waste time arguing with
> you. =C2=A0What kind of crazy world would work that way?
>
> And I did not mean to bring up any argument. =C2=A0I only meant to br=
ing up
> the _datum_ that, at least in the context of the bash_completion
> project, that is the current convention. =C2=A0And then you started t=
rying
> to tell me that I had the facts wrong! =C2=A0You might even be right,=
 but
> you haven't shown any sign of trying to check that, by, say, asking
> someone from the bash_completion project what convention they use.

I don't understand. I'm proposing the name 'git_complete', I thought
you were arguing against it. If you were only providing random facts,
then we can just ignore them, and it would be OK, right? But I'm
pretty sure you would be angry as well if I just ignored that fact.

Sure, it would be nice to follow bash_completion project's convention
for these kinds of functions, if they had any, and might be useful to
ask them what they think. But we don't *have* to. And nobody is
arguing that we should ask them. Right? Or are you?

> I'm sick of this. =C2=A0Call it whatever you want. =C2=A0I don't know=
 why you
> think this is productive.

We don't have to agree on any name right now. I believe it's worth
waiting before deciding on a name for a public function like this, and
try to get some consensus.

But throwing arguments on the air, and they get angry when they get
counter-argued is not helpful. If we are going to discuss, lets
discuss, but that doesn't seem to be what you want. You want me to
blindly use the name you propose without saying a word? Blindly accept
your argument... follow orders?

I took your argument seriously and looked for evidence myself, and in
the absence of evidence I'm still not throwing it away, I'm assuming
it has merit and added code to make sure we don't override some user
function that has the same name. That would solve the problem you
raised, and it would help us find out if this is indeed a real issue,
or a theoretical one, and at the same time making sure people don't
rely too much on this function for the moment.

I believe this is very scientific-like; you make a hypothesis, we make
an experiment, and then we can find out the results, and only then
make a decision.

I don't know what else I can do to move this forward.

Cheers.

--=20
=46elipe Contreras
