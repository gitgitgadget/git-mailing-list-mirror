From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Thu, 23 Apr 2009 11:52:14 +0200
Message-ID: <81b0412b0904230252k3e8197d3y8798d5b797a49c39@mail.gmail.com>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
	 <20090422082652.GA32698@gmail.com>
	 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
	 <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com>
	 <7v4owgyp8x.fsf@gitster.siamese.dyndns.org>
	 <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com>
	 <7vtz4fwzaz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 11:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwvct-0005tJ-7N
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbZDWJwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 05:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbZDWJwR
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:52:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:46202 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbZDWJwQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 05:52:16 -0400
Received: by yw-out-2324.google.com with SMTP id 5so280798ywb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=94Fn1PJfFZWolAD6O0jna4ip0bPomSfok/r6X+EUXvM=;
        b=gW05Td6Nx4Wmo9kC6/ArPhFUi2d7q4kcwwc6lH188TbK3YvG/fEAOSLcfmKvnq3Dmd
         +hEM0wWBAgwI1g+UnriWq3a7pCUxkWyHzyy4xv7sAhje+fp4Iqc/k6P7L7hCJZfod9jr
         /ILGkG6cNcN36OeCKIEQ/dxDXgce0c6b1AACI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CMfSPzZqgUqZ4KSzXfSxvvSQ+ejA/VqSUXsl0Hzvjv351cb/zKlAqurfq2qtW2IAov
         yNlnPPZX8r7W9ARZ7YCRl+9d4rSploQv6BLSr4gVegRO1qKvUr6eIPYtVTN1c0RHz00r
         NSqcWHeH0JQBBgtQmOEVQ72c46ufFa8kSUjOE=
Received: by 10.151.150.20 with SMTP id c20mr1543602ybo.176.1240480334339; 
	Thu, 23 Apr 2009 02:52:14 -0700 (PDT)
In-Reply-To: <7vtz4fwzaz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117324>

2009/4/23 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> 2009/4/23 Junio C Hamano <gitster@pobox.com>:
>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>> Frankly, I just always forget about it. The patches to my windows
>>>> repository are mostly just hacks to either make it pass test suite=
 or
>>>> workaround another, the platforms specific, stupidity. Not sure an=
yone
>>>> is actually interested in them (because, I repeat, they mostly hur=
t
>>>> everyone else, while making the platforms port "a little working")=
=2E
>>>
>>> What do you really mean? =C2=A0These patches add maintenance burden=
 but its
>>> benefit nobody would care about, and should not be applied?
>>
>> Maintenance _and_ run-time. It is your decision, but yes, I kind of =
hate
>> the idea of them being applied.
>>
>> In plain words: please don't apply MY patches with words "Windows"
>> or "Cygwin" in message body, unless I beg you to (and even then,
>> consider me heavily drugged).
>
> Hmm, what's the point then for me to spend time looking at them poste=
d on
> the list?
>

None. But it still would be nice if you look at them when you're addres=
sed
directly. Please understand, maybe I'm abusing the list a little, but i=
t looks
like the best place to _archive_ the workarounds for this obscure platf=
orm.
The code is of little use to general public, but in case one finds hims=
elf
in the same situation as I am in, at least Google can help out. I think=
 it
happens too rare to justify your looking at them, and especially includ=
ing
them in the mainline, but hiding the code on my laptop isn't of any use
to anyone (including me: I don't always have that laptop).
