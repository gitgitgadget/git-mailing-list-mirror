From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 14:57:04 -0500
Message-ID: <CAMP44s3=gRwORdxYiXnioufg8Ag3tmuZth5_-+NbJWV_v1FDxA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
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
	Drew Northup <n1xim.email@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF8LA-0006F0-SW
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab3H2T5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 15:57:07 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:54934 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab3H2T5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 15:57:06 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so791334lab.38
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SyqGsVPqXUf9eauIKEMK/7Kl3xkHqIgeHOB/+2c0Nc8=;
        b=y0H3/m4jgFA+6q+HssqOdzQWADmWgNZbjbUllD6BSl339xCzXeQZtvUjdZ/n2c7G9G
         BfflSDI6/NDUIUyQDxNimx99ME+lFMjG7hVmJ/DbBWCLE4xUIqA6OaAQ4fWiKda1PPpx
         JRc0HHQor1MjB74naE0X8XXGYLcjx3b2OLVZDevtaGGOcR7Su16HJIBfiZf1vLQIK+Tl
         ZDs9C63sTJf95htyYxQ/Coa/m0ZIbbBHB79ddavw41sor5bEYnfEjaVwq46o/1LPdS4x
         b6+BVKEttpqMDN5kJMtuvmRriLpylhao2tJhBx7Xvv4pEDG6cYYIzz7P8I883pKGNTa9
         FSYA==
X-Received: by 10.112.74.20 with SMTP id p20mr3054228lbv.36.1377806224471;
 Thu, 29 Aug 2013 12:57:04 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 12:57:04 -0700 (PDT)
In-Reply-To: <xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233352>

On Thu, Aug 29, 2013 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It has been discussed many times in the past that 'index' is not an
>> appropriate description for what the high-level user does with it, a=
nd
>> it has been agreed that 'staging area' is the best term.
>
> "add" is the verb,

Add changes to what? The user needs to know that.

> not "index" (which is a noun that refers
> to the thing that keeps track of what will be written as a tree to
> be committed next).

How Git creates trees is irrelevant to the high-level user, all that
is relevant is what happens from the users's point of view, and from
the user's point of view he is adding changes to an area that contains
the changes that will be part of the next commit.

*Everyone* has agreed that the best name for that is the "staging area"=
=2E

> And it will stay that way.

We'll see about that. If it stays that way, it's because you are not
listening to what *everyone*, including users, developers, and
teachers of Git, are saying.

> IIRC, when this was discussed, many non-native speakers had trouble
> with the verb "to stage", not just from i18n/l10n point of view.

Well, you recall incorrectly.

There was *A SINGLE* non-native speaker that complained, about
"stage", not "staging area", =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, an=
d he even said
he had already translated index/cache to "the commit area"[1].

Again, *everyone* has agreed that index needs to be renamed, and
"staging area" is the best option.

Do I really need to go through all the discussions and list each and
every person that participated in them, and show to you how everyone
agreed? Can't you just go and read them again? There was a single
person that didn't like the term "staging area", but he accepted that
index is definitely not the right term (Drew Northup).

Here are the threads once again:

http://thread.gmane.org/gmane.comp.version-control.git/197111
http://thread.gmane.org/gmane.comp.version-control.git/166675
http://thread.gmane.org/gmane.comp.version-control.git/115666

[1] http://article.gmane.org/gmane.comp.version-control.git/197217

--=20
=46elipe Contreras
