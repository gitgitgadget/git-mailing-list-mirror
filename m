From: David Aguilar <davvid@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 31 Aug 2013 20:46:46 -0700
Message-ID: <CAJDDKr4ryTtS9U-ZMky5YvWTSOKPk1n80Ot=h6rwzExOvsSTcg@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<vpqli3kqqkp.fsf@anie.imag.fr>
	<521f998d25eb4_174378fe7481879@nysa.mail>
	<521FA90A.9040903@web.de>
	<CAMP44s3m_7UffHfie8=_izPt5tCw+9SXPa4sqoHuphuVyTHqcw@mail.gmail.com>
	<52219F6E.6090605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 01 05:47:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFycv-0001Ne-JK
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 05:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab3IADqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 23:46:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46304 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3IADqr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 23:46:47 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so3883208pab.15
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YgBUgx87j7JE9Lf78o9yBUMk6ESsyGjQZ92/08RbhRc=;
        b=M4Ook5HoowvCnV6Jz75mj5pyfezhEpK+3qTQ1glopKv7rFr7QuXhD//yu6I0cWqowL
         wJDGOfN+QdlqKk2SjQmQH//HF7HYvUCkCwYhT4QR8vHLIdYDFOrH06UzL/qmWKpw9xRY
         owNDFNztlVQx+90f0lVE/VY3boVG9QISgx1YWYlJyYDT7Uk5jEbDd+emqufP6yFqpBmt
         /JzBOCDxwB0wmFMm7dFGLF10xUFUSJi796U5WeJgbrEZmme0IKeJfqjYA0h98k8ciOWr
         8GkZ/BC5igmd05hPgWWY/8ISocKB+olZeTjXx9ttNXf/XPB1NedmINcq3LRGKfF0LlZ8
         yUig==
X-Received: by 10.66.144.102 with SMTP id sl6mr8813846pab.96.1378007206134;
 Sat, 31 Aug 2013 20:46:46 -0700 (PDT)
Received: by 10.70.95.230 with HTTP; Sat, 31 Aug 2013 20:46:46 -0700 (PDT)
In-Reply-To: <52219F6E.6090605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233561>

On Sat, Aug 31, 2013 at 12:46 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:
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
>
> I don't see what's so ugly about it.
>
> The git command itself has a --work-tree parameter for specifying the
> location of the checked-out files, however.  It could be confusing to=
 have
> the same parameter do different things:
>
>         $ git reset --work-tree=3D/some/where reset --work-tree
>
> Perhaps a note in the documentation is enough to clear this up.

I agree that this is confusing for people not deeply versed in Git jarg=
on.
We also know that no one reads documentation.

Maybe a better word can be found?  How about "git reset --files"?
--=20
David
