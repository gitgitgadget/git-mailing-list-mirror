From: John Tapsell <johnflux@gmail.com>
Subject: Re: git checkout -b origin/mybranch origin/mybranch
Date: Thu, 12 Mar 2009 13:18:21 +0000
Message-ID: <43d8ce650903120618h79686207vaa478c54f34e26f8@mail.gmail.com>
References: <43d8ce650903120436u261cb7e3p838e4a12e7b54d7d@mail.gmail.com>
	 <alpine.DEB.1.00.0903121240400.10279@pacific.mpi-cbg.de>
	 <43d8ce650903120448x51220ba0k660be7706acba755@mail.gmail.com>
	 <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 14:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkpF-0001w1-RI
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 14:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZCLNSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZCLNSY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 09:18:24 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:35471 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZCLNSY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 09:18:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so467138yxm.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EbvKqUaaKv7eCo8lRUilA4o+AKtkw4/NU5zRUEshoHg=;
        b=GSoM85X5AEhkm/cOqjCJ3iIgEfxtjHjffGQrKmL/9ABFzCWSx1Zde5XOjK2jY1FU2B
         MMLbpV6fEaYZlyeSFYTirfKbs+myw86aknAtutnTF572xqFqL6RiRb2N4xIvnPJPbIJZ
         u1ghY60uLrJlbw/wxOx1YDujbCd1cFXTHO/Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vUfvE/4u8N0YG+Mb9p7eWiLXGiQX4G5h1LGWeJsjA6pzqlWb6pmdXf4HG4UJEqkyuS
         jpnVAlktk73Slv9xi1IgwQjqouZcR8epkyLTs0wb5MGnSFoq/YLkiyj8qCaYDeLyfwfQ
         WtSQOiI40Ao4LiWRKjEa59rDH5uGO8nmvR328=
Received: by 10.142.215.5 with SMTP id n5mr4293622wfg.201.1236863901542; Thu, 
	12 Mar 2009 06:18:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903121357320.6335@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113068>

2009/3/12 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 12 Mar 2009, John Tapsell wrote:
>
>> 2009/3/12 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>> > On Thu, 12 Mar 2009, John Tapsell wrote:
>> >
>> >> =C2=A0 One of my collegues did:
>> >>
>> >> git checkout origin/somebranch
>> >>
>> >> =C2=A0 git complained that they need to specify the name with -b.=
 =C2=A0So they did:
>> >>
>> >> git checkout -b origin/somebranch origin/somebranch
>> >
>> > Yeah, a pilot error. =C2=A0It should have been
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git checkout -t origin/somebranch
>>
>> Maybe the error message for "git checkout origin/somebranch" =C2=A0s=
hould
>> suggest: =C2=A0git checkout -t origin/somebranch?
>>
>> > I have to wonder, though, why "git checkout origin/somebranch" did=
 not
>> > detach your HEAD.
>>
>> It did. =C2=A0But that doesn't affect doing "git checkout -b
>> origin/somebranch origin/somebranch" =C2=A0afterwards.
>
> So did the warning read something like this?
>
> -- snip --
> moving to "d36a18dc9cdf1dfce8632e42491b826387aa3230" which isn't a lo=
cal
> branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
> =C2=A0git checkout -b <new_branch_name>
> -- snap --
>
> ?

I'm really not sure what point you're trying to prove.  Yes, we all
know that the user made a mistake in thinking that the new_branch_name
should be "origin/mybranch".

What I'm suggesting is that git tries to not let the user shoot
himself in the foot so easily.

I'm saying that:

git checkout -b origin/mybranch  origin/mybranch

Is probably a mistake by the user.  We should warn the user and point
them in the right direction.

John
