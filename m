From: John Tapsell <johnflux@gmail.com>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 12:08:10 +0000
Message-ID: <43d8ce650903110508o3d12f32m8202fae750d215a@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <alpine.DEB.1.00.0903111304520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhNFl-0004fO-F0
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbZCKMIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 08:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbZCKMIM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:08:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:52414 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbZCKMIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 08:08:12 -0400
Received: by wf-out-1314.google.com with SMTP id 28so3179341wfa.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kSFZ9L5B07OHy51M1JHKrjR2vAL7J7dJJwhdFIztyFE=;
        b=CzCLoVkdSdmtm657wqgnqgu9e+ho7cE7EuwWTMgbUeynVuMRjgbzjg0jg0aEUS9dLz
         8/FQZdAwheepvmAE2ScsR42Fn49bxJDofJxLEgIcVK/EWdIxcCRJzbjLodooZ9vDQWvt
         dh05zVwaaqUeFJQgQInz6xmGPhh+EomPPZTT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hydq3S+ry+O1KmJOHPfw0hSjB9e0vaV8bh6UnywIiFULQgvaTloYy3+csI0eDCgO0d
         lIgTpRsA18dMUETWk5HhukQ8pgQ65NNSMYJvtikB+VrNiAJZnmB1iZlVsNZNfuwF4pML
         cegJrcPG1q0azlkVLF8w3Oo0Fd1z3D3ArSE3Y=
Received: by 10.142.105.13 with SMTP id d13mr3644878wfc.196.1236773290368; 
	Wed, 11 Mar 2009 05:08:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111304520.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112918>

2009/3/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Wed, 11 Mar 2009, John Tapsell wrote:
>
>> 2009/3/11 Ealdwulf Wuffinga <ealdwulf@googlemail.com>:
>> > On Tue, Mar 10, 2009 at 7:08 AM, Christian Couder
>> > <chriscool@tuxfamily.org> wrote:
>> >
>> >> I will try to have a look at the end of this week.
>> >> But do you want it to be integrated with Git or do you want it to=
 be an
>> >> independant project that works with many different version contro=
l system?
>> >
>> > Hmm. Whatever works, I guess. On the one hand the code does seem
>> > naturally generic. On the other hand, it's good if users don't
>> > have to separately obtain an extra package to use it. Supposing th=
at
>> > the algorithm proves useful, would the git project =C2=A0be okay w=
ith an
>> > extra dependency, or would you want to integrate it? Right now it'=
s in
>> > python, which I understand is an obstacle to integration.
>>
>> There used to be a dependency on python. =C2=A0git-merge-recursive f=
or
>> example, before it was converted to C.
>
> Not "for example". =C2=A0It was the only dependency of git.git on Pyt=
hon, and
> the rewrite of merge-recursive was only done to break that dependency=
, as
> I had a platform where I could not install Python.

But installing perl was no problem?  (Just curious)

John
