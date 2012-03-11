From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Re: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 19:01:43 +0100
Message-ID: <CAMXnza2vD+XOstbNbt+wJgAGE7OEDpQTqGL8NWjWd0fYkWbJ2w@mail.gmail.com>
References: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com>
 <7vk42rzfab.fsf@alter.siamese.dyndns.org> <CAMXnza12HVFdmji7k-b-G43NWmobqCQEwXZXB=VxJA=tatqX-g@mail.gmail.com>
 <7vd38jxu5b.fsf@alter.siamese.dyndns.org> <gcvg.1203111617.379@landroval.ancalagon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Hochstein <thh@inter.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 19:02:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6n5v-0004nX-SI
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 19:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab2CKSCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 14:02:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44557 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab2CKSCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 14:02:04 -0400
Received: by yenl12 with SMTP id l12so1934285yen.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=I3Lx+gMg24Uhf5+JtIllobRDUoSYD/BpLGspOfIgSnA=;
        b=vU791bxgqOJVPK5m42IuUsYmlNRwL2NWuc9O3stF0/ekF1L8BWSzC2CaZ/oQGCTxg9
         TEQZMLYWnvsk6s/PQegJlL/S4M0IobTNOxjpC15C73zv3bw5NprKkIL+fZA11qPCe6+N
         DMcNXfMv5MQyNopIyfW9Z00Wsw6ojf1mlaIrbV2zkunz9sqUholNwD+ZCqMxnHTxirW8
         N0RqQCiTx/uBEJPZVzN9nbxnNq7eWH/1G2MI8v4q6mpVUGhCo8HgbBVTIwc7hWZiqzld
         umw5krqX3ycA1HhkrgLSNf0SN2D22NR9BMufs0VcIEU8fBN8JNrqSG3/OQYqDYzOhvvC
         f9yg==
Received: by 10.182.89.65 with SMTP id bm1mr5057563obb.52.1331488923181; Sun,
 11 Mar 2012 11:02:03 -0700 (PDT)
Received: by 10.60.20.104 with HTTP; Sun, 11 Mar 2012 11:01:43 -0700 (PDT)
In-Reply-To: <gcvg.1203111617.379@landroval.ancalagon.de>
X-Google-Sender-Auth: _xatcGa705RyGB-6HqsUEltt1zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192818>

Hello Thomas,

On Sun, Mar 11, 2012 at 16:17, Thomas Hochstein <thh@inter.net> wrote:
> Junio C Hamano wrote:
>
>> suvayu ali <fatkasuvayu+linux@gmail.com> writes:
>>
>>> ... is that discussion on progit talking about
>>> something else?
>>
>> Sorry, I do not read or write progit, so I do not know offhand what
>> it says in the section you read and I cannot judge if it was you who
>> misread, or if it was book that misspoke.
>
> The book says:
>> You can also use Git attributes to tell Git to use different merge
>> strategies for specific files in your project. One very useful optio=
n
>> is to tell Git to not try to merge specific files when they have
>> conflicts, but rather to use your side of the merge over someone
>> else=E2=80=99s.
>>
>> This is helpful if a branch in your project has diverged or is
>> specialized, but you want to be able to merge changes back in from
>> it, and you want to ignore certain files. Say you have a database
>> settings file called database.xml that is different in two branches,
>> and you want to merge in your other branch without messing up the
>> database file. You can set up an attribute like this:
>>
>>| database.xml merge=3Dours
>>
>> If you merge in the other branch, instead of having merge conflicts
>> with the database.xml file, you see something like this:
>>
>>| $ git merge topic
>>| Auto-merging database.xml
>>| Merge made by recursive.
>>
>> In this case, database.xml stays at whatever version you originally =
had.
>
> That seems to be incorrect, as far as I understand the gitattributes
> man page.
>

Thank you for confirming the error. I have opened a ticket on the progi=
t
repo on github. If you are interested, you can follow it on the page
linked below.

<https://github.com/progit/progit.github.com/issues/5>

Cheers,

--=20
Suvayu

Open source is the future. It sets us free.
