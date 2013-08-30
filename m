From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Fri, 30 Aug 2013 15:40:39 -0500
Message-ID: <CAMP44s2cba_UGmYJuwf9kw-OG4FQz6eRefRC0xa7pnx6ctFRjw@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
	<CAMP44s0yxaS3YeF5gprTecfa0rzLso96cE9gWM629iM0Sc5+Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Pete Harlan <pgit@pcharlan.com>, Aghiles <aghilesk@gmail.com>,
	Jeff King <peff@peff.net>, Phil Hord <hordp@cisco.com>,
	Victor Engmark <victor.engmark@terreactive.ch>,
	David <bouncingcats@gmail.com>,
	Alexey Feldgendler <alexeyf@opera.com>,
	Alexei Sholik <alcosholik@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Sebastien Douche <sdouche@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Mark Lodato
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 22:40:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFVUr-0005VT-7E
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 22:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756Ab3H3Ukl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 16:40:41 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:47478 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab3H3Ukk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 16:40:40 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so2278749lbh.37
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WQN2zEK7qlfRz6T0vwy8XuAaeG+OEs4Am+jGsXbYxQg=;
        b=ifttK7/DezXxucbnlAde5DbHDT4zOTZUzdVvPkT9rNEWOlkxyDuRrHjRUpZEXO7dYV
         QtWKsDvjbPZI5dYY4wTbYbqPjiOPFRRZ8pSIZBKsgMibQKkmGosxPLXK9IVsqC5wYsqu
         AniYaxpSW/f7VvaRNK3uYydC8mPnRINCHd//sQXTlW44wevDHOyuPW9V75ZNTzbwIkAJ
         9/YGmhgW0E2gklhAlWmzMjH3LAfkjBaRyOjDbxtHRR4rKZg9zpzxuvb/N1rifjsC9EUK
         200zbDmSBCBEnnT64e3GhjWewda25jv9U+GOc2dAkDu2NQrztP3NRmVzjzqo4STFs3xz
         CB8A==
X-Received: by 10.112.35.225 with SMTP id l1mr3230501lbj.35.1377895239324;
 Fri, 30 Aug 2013 13:40:39 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 13:40:39 -0700 (PDT)
In-Reply-To: <CAMP44s0yxaS3YeF5gprTecfa0rzLso96cE9gWM629iM0Sc5+Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233469>

On Fri, Aug 30, 2013 at 2:11 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 2:57 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> Here are the threads once again:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/197111
>> http://thread.gmane.org/gmane.comp.version-control.git/166675
>> http://thread.gmane.org/gmane.comp.version-control.git/115666
>
> I take it you still haven't read those threads, and you don't plan to=
=2E
> So I have to go through each and every comment and summarize what eac=
h
> person concluded.
>
> Hopefully you would come back to me before I waste my time, but it
> seems there's no other way to make you see the reality of what was
> actually already discussed and agreed.

So here's the summary, as I said, *everybody* is in favor of "staging
area" or something other than "index", with the exception of Drew
Northup, I've put a summary of the conclusion of each person that
voiced an opinion on the matter, and I've CC'ed them here, so they can
reiterate their opinion, or clarify it.

Junio, do you accept that virtually *everyone* is in favor of "staging
area" now?

=3D=3D Against =3D=3D

Drew Northup:
index is good

=3D=3D For =3D=3D

Jay Soffian:
staging area is better

Pete Harlan:
Aghiles:
"staging area" is good for teaching

Piotr Krukowiecki:
"staging area" makes sense

Jonathan Nieder:
"staging area" is better than "index"

Jeff King:
"staging area" makes perfect sense

Miles Bader:
"staging area" is good

Phil Hord:
"staging area" is better than index/cache

Victor Engmark:
maybe "git bucket"

David (bouncingcats):
maybe "precommit"

Alexey Feldgendler:
"staging area" translates better into Russian (than precommit)

Alexei Sholik:
"staging area" is better

Zbigniew J=C4=99drzejewski-Szmek:
"staging area" is better

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
In Icelandic "index/stage" is translated to "the commit area"

Sebastien Douche:
"stage" is better than "cache"/"index"

Thiago Farina:
"precommit" is better

Mark Lodato:
"staging" is the most appropriate

Philip Oakley:
"staging area" is OK

Matthieu Moy:
something needs to be done

--=20
=46elipe Contreras
