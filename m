From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 16:26:00 -0700 (PDT)
Message-ID: <m3bppgdan2.fsf@localhost.localdomain>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com>
	<32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com>
	<8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com>
	<32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com>
	<8873ae500905251035v64084e83wa1a89a562d20224a@mail.gmail.com>
	<32541b130905251054k44bdb218sde8837e87d8e8e69@mail.gmail.com>
	<8873ae500905251128h1921895dp6ef227e0e0bbec49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Asger Ottar Alstrup <asger@area9.dk>
X-From: git-owner@vger.kernel.org Tue May 26 01:26:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8jYm-0002ma-CC
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 01:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbZEYX0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 19:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZEYX0E
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 19:26:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:7639 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbZEYX0C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 19:26:02 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1267249fgg.17
        for <git@vger.kernel.org>; Mon, 25 May 2009 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=YaMfqjVcOiAqs8GmnmJYG8/8s8aTMSnxSRTStrKirQQ=;
        b=IkjELD+zwyLDLrZ3Fbn37JlqMmeqXOm1s7OSBV/TTd0ykli7kI9Dj9/Tsu/yZrKErG
         LFHunPmIY3SoJ1FHXdczKM8B1k1HVu0EYwcbLZdMtmEAVzM5U/m6sPfV4WbX78zWNVod
         PDCNC0MjyJovBydJfgrydiOcXHYxfJ0P7eywA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=U9o5khvQ/GGD+t/LId1YOWrtLK4dZ6G6T55UkIlr+2Id+oNY6qOezBcCF4p0xI0AKz
         yOMuuOv9FN+0bte0fxQFeCdbwQRJfcaussF/3BcAoGEDqIyn8EUR5oSjilSiLfS0Y/tx
         eCDujpYMMSfMQjGPrfLpvUvk+Vtvk56DLCXxw=
Received: by 10.86.60.15 with SMTP id i15mr6239133fga.5.1243293961589;
        Mon, 25 May 2009 16:26:01 -0700 (PDT)
Received: from localhost.localdomain (abvv167.neoplus.adsl.tpnet.pl [83.8.219.167])
        by mx.google.com with ESMTPS id 4sm6925042fge.13.2009.05.25.16.26.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 16:26:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4PNTsGL020361;
	Tue, 26 May 2009 01:29:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4PNTcI2020348;
	Tue, 26 May 2009 01:29:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8873ae500905251128h1921895dp6ef227e0e0bbec49@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119981>

Asger Ottar Alstrup <asger@area9.dk> writes:

> On Mon, May 25, 2009 at 7:54 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Mon, May 25, 2009 at 1:35 PM, Asger Ottar Alstrup <asger@area9.dk=
> wrote:
>>> So a poor mans system could work like this:
>>>
>>> - A reduced repository is defined by a list of paths in a file, I
>>> guess with a format similar to .gitignore
>>
>> Are you sure you want to define the list with exclusions instead of
>> inclusions? =A0I don't really know your use case.
>=20
> Since the .gitignore format supports !, I believe that should not mak=
e
> much of a difference.
>=20
>> Anyway, if you're using git filter-branch, it'll be up to you to fix
>> the index to contain the list of files you want. (See man
>> git-filter-branch)
>=20
> Yes, sure, and that is why I asked whether there is some tool in git
> that can give a list of concrete files surviving a .gitignore list of
> patterns.

I think you would want to use git-ls-files, using --exclude-from=3D<fil=
e>
option, and perhaps also -i/--ignored to create list of files to be
removed (using git-update-index) instead of list of files to be kept.
=20
>>> - To extract: A copy of the original repository is made. This copy =
is
>>> reduced using git filter-branch. Is there some way of turning a
>>> .gitignore syntax file into a concrete list of files? Also, can thi=
s
>>> entire step be done in one step without the copy? Having to copy th=
e
>>> entire project first seems excessive. Will filter-branch preserve
>>> and/or prune pack files intelligently?
>>
>> You probably need to read about the differences between git trees,
>> blobs, and commits. =A0You're not actually "copying" anything; you'r=
e
>> just creating some new directory structures that contain the
>> *existing* blobs. =A0And of course the existing blobs are in your
>> existing packs.
>=20
> Thanks. OK, I see now that filter-branch will not destroy the origina=
l
> repository. That is not at all obvious from reading the man page, whe=
n
> the very first sentence says that it will rewrite history.=20

What git-filter-branch does is to write _new_ history, and move old
history to refs/original/* namespace (that might have changed; anyway
the old history should be available via reflog).  The visible efect
is that history got rewritten.

> But the
> main point of this exercise is to reduce the size of the reduced
> repository so that it can be transferred effectively. So after
> filter-branch, I guess I would run clone afterwards to make the new,
> smaller repository, and then the question becomes: Will clone reuse
> and prune packs intelligently?

Yes, it would... well, you have to take into account that ordinary
clone over local filesystem does hardlinking of packfiles, and you
need to use file:// trick to force repack; also you might want to use
--reference to set up alternates.

But that is not necessary: if you want to push effectively _subset_
of branches, you can define remote infor in appropriate way and push
would intelligently transfer only needed objects.

[...]
> However, there is a large group of users that do not need this, but
> they DO need the entire history of the files they are interested in.
> Subversion does not provide this. Also, Subversion is simply too slow
> to handle the kind of files we need to work with. Also, we have run
> tests on the kind of files we have, and the delta compression that gi=
t
> uses is very effective for compression the pdf and openoffice
> documents we use. The big files we have are primarily image files, an=
d
> obviously they do not compress very well. Fortunately, they do not
> change much either.

You might want to turn off deltaification for binary files via `delta`
gitattribute; it might help (it might not).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
