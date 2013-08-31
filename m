From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 31 Aug 2013 02:53:08 -0500
Message-ID: <CAMP44s36Kyiu5VnfN9+V3BwJZSMdOdGazCPXUnxUYqLQpzUOPw@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<vpqli3kqqkp.fsf@anie.imag.fr>
	<521f998d25eb4_174378fe7481879@nysa.mail>
	<521FA90A.9040903@web.de>
	<CAMP44s3m_7UffHfie8=_izPt5tCw+9SXPa4sqoHuphuVyTHqcw@mail.gmail.com>
	<52219F6E.6090605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 31 09:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFfzo-0004Vq-ST
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 09:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab3HaHxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 03:53:11 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:57805 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3HaHxK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 03:53:10 -0400
Received: by mail-la0-f50.google.com with SMTP id es20so2252402lab.9
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KMAnmS8XdkGOqsU1p9fYuNoMSpPrHqk2JBLHD+zSfYY=;
        b=sZ3J8/j3QZKT0O4LR60q3qtj7QnQ5OhrsI8k2WMlsXJ5k/CMMqm/3dQI1qJU/k2OHS
         ypbjeE6QVblb2s4MTyTgadrXd0jjnL7sodgGD2bkRWBX66FX2WTMkZzwEC835brqImn8
         7AIBs/KFGEju6zdh5naPN/i2bbmaX8/z430KhtP1YsqfpaLtCsjfQWdeXYkJf+Xek7gf
         cnToEPempw0NVsY/L/VnFsmaasQD4AaZSokBjJW77I/v5YcelauRJCT6LeF98z2Bi5WT
         IsylQJIVdkv3pq/fZv8XIKCHGmcA7+n5cTWAuU4FSy1ZVFnslK7hLeSDPTh1ekmQ3GHz
         0HGA==
X-Received: by 10.152.115.176 with SMTP id jp16mr11504002lab.17.1377935588714;
 Sat, 31 Aug 2013 00:53:08 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 00:53:08 -0700 (PDT)
In-Reply-To: <52219F6E.6090605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233507>

On Sat, Aug 31, 2013 at 2:46 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 29.08.2013 22:36, schrieb Felipe Contreras:
>>
>> On Thu, Aug 29, 2013 at 3:03 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>>
>>> If you have a --work-tree option then parseopt accepts --work as we=
ll,
>>> unless it's ambiguous, i.e. another option starts with --work, too.=
  So
>>> you
>>> can have a descriptive, extra-long option and type just a few chara=
cters
>>> at
>>> the same time.
>>
>>
>> Right, but what do we use in the documentation? Writing --work-tree =
in
>> the 'git reset' table for example would be rather ugly. I'm fine wit=
h
>> --work-tree, but I think it would be weird to have short-hands in th=
e
>> documentation, although not entirely bad.
>
> I don't see what's so ugly about it.

Maybe not so much.

> The git command itself has a --work-tree parameter for specifying the
> location of the checked-out files, however.  It could be confusing to=
 have
> the same parameter do different things:
>
>         $ git reset --work-tree=3D/some/where reset --work-tree

I don't see what's confusing about that, one option is for git core,
the other is for the subcommand.

> In general I think that the full long option should be mentioned in s=
ynopsis
> and description, while abbreviated parameters could be used in an exa=
mple.
> The ability to understand unambiguous shortened options is a general =
feature
> and doesn't have to be explained in the manpage for a specific comman=
d.
>
> NB: It would be nice to have more commands use parseopt, for that fea=
ture
> alone.

Indeed.

--=20
=46elipe Contreras
