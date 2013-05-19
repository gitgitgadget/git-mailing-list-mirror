From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Sun, 19 May 2013 18:49:01 +0200
Message-ID: <CAN0XMO+jGzW7yUNytv=HJ6AQNuyzTKQ28OTEnDOnFq+w97cz-g@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<87wqqze1ub.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun May 19 18:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue6nQ-0007eZ-Me
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 18:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab3ESQtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 12:49:05 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:58327 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab3ESQtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 12:49:04 -0400
Received: by mail-wg0-f45.google.com with SMTP id n12so747475wgh.12
        for <git@vger.kernel.org>; Sun, 19 May 2013 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4RAsBUbAzO4lNsLYTHbxKSr7iMZYw+1YYemveqT7Ch4=;
        b=yliQagdBdr7Zeo1SZgtwzdGX9rst2yp7HSDAu1OL3InNbKQEktj5qnXDkUNWjdxS3Q
         BpPU32qgoU2PEudhyeGEK4THCOKrnjlHootWNgLLA9X2ubt1oVx9AVijp9P4kOw0rPXy
         9u0XBM8Yu/mArp8ym87qCB9cy7UD9LDpLsiwwhnp/1+SQISsrAy7cYtgj9IfoQiS1p1p
         HmQwoGLLiYo+1BgGiNc4t73dzJ2+I8589Lm4+H1A8/mb6sx1TcnTK8tr6jgQRNzBra3t
         Nrf990sO1mA7V36B+qOf6axP4T4ids9llGPYWjJMCH60z3VAg1qHS0eCTIm2IpkqIpsY
         0YWQ==
X-Received: by 10.180.86.38 with SMTP id m6mr6702743wiz.25.1368982142199; Sun,
 19 May 2013 09:49:02 -0700 (PDT)
Received: by 10.194.237.5 with HTTP; Sun, 19 May 2013 09:49:01 -0700 (PDT)
In-Reply-To: <87wqqze1ub.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224898>

2013/5/16 Thomas Rast <trast@inf.ethz.ch>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Hi,
>>
>> I think the discussion might work better via ML than GitHub.
>> This is the full glossary of git's de.po as it would look
>> like with (hopefully) all the changes included that have been
>> discussed here. Still without any reasoning for decisions
>> (except HEAD).
> [...]
>> +    remote branch          =3D externer Zweig
>> +    remote tracking branch =3D externer =C3=9Cbernahmezweig
>
> Hrm, before we (erm, you) do any extensive work on redoing the glossa=
ry,
> I think we should step back and agree on a direction.
>
> Remember what this thread started with:
>
> } However, an unfortunate and unsatisfactory situation has developed:
> } Christian Stimming's git-gui de.po uses a Ger translation, and Ralf
> } Thielow built core git's de.po on top of it, so it's also Ger.
> }
> } Meanwhile, and independently, Sven Fuchs and Ralph Haussmann wrote =
a
> } translation of pro-git (which is also quite mature at this point, h=
aving
> } apparently begun in 2009), and as you probably guessed by now, it's=
 G+E.
> }
> } So that leaves us at a point where "the" libre Git book (and also t=
he
> } one that happens to be hosted on git-scm.com, the official site) do=
es
> } not match the terminology used by German git.
> }
> } Like, at all.  They're not even remotely near each other.
>
> My thinly veiled opinion in the thread starter was that we should red=
o
> git's de.po from scratch using a translation similar to pro-git.
>
> I can accept that discussion takes a different turn, and thus the
> translation does something else.  But my impression in the thread so =
far
> was that:
>
> * Everyone voted for G+E.
>
> * The thread went of on a tangent, bikeshedding on some Ger
>   translations.
>
> Please tell me I'm wrong...
>
> Otherwise, assuming any agreement can be reached, IMHO the first step
> must be to write/complete a glossary that matches *current usage* in
> pro-git.  We can perhaps bikeshed about some glaring issues in the
> result, but remember that -- again assuming G+E is the conclusion -- =
any
> such change again either means a divergence between book and git (bad=
!)
> or a lot of work for the book translators.
>

Well, that's what I'm trying to do, writing a new glossary. But I took
the current git's de.po glossay as the base, because it's the biggest o=
ne
and easier to apply to de.po instead of using a complete new one.
I tried to merge [1] (link is dead) to match ProGit-Book where it's pos=
sible.
IMO it's OK if we don't match the ProGit-book in all terms (I didn't do=
 it with
intention), but it's not OK if the translations are so far away from ea=
ch other
that it becomes a problem to the users because they're using totally di=
fferent
"languages".
What I'm doing now is collecting objections and suggestions from others=
 (ML, GH)
and apply them to the glossary in order to get a version where everybod=
y
more or less agree with.

[1] https://github.com/progit/progit/blob/master/de/NOTES

> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
