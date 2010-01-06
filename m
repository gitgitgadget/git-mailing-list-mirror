From: Dongas <dongas86@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Wed, 6 Jan 2010 11:58:05 +0800
Message-ID: <60ce8d251001051958p726e7dadp9a8a778a0e6c1b11@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
	 <c1b8b6671001041852w4740b7d6g4b8db1221c5dc744@mail.gmail.com>
	 <60ce8d251001042030l75c5443gf173f127ad206df3@mail.gmail.com>
	 <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Russell Steicke <russellsteicke@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 04:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSN2H-0002Gu-Uw
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 04:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab0AFD6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 22:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237Ab0AFD6N
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 22:58:13 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:39792 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab0AFD6M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 22:58:12 -0500
Received: by yxe26 with SMTP id 26so16333763yxe.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 19:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iB41sq9uHeylAQFKRGFk95BM4tCWaEaXGatj6SLSOVU=;
        b=wXYibl9pIiSoakGfhSUgx+yjJonYL7HaHZnQxbUqn5bs8nAqOhf9tIR86XePnjdu2M
         7ImD6lHlp4Wt7B684nYvegcvS18OXLzHgiVpxEw6Fe/xJvYvZX3uxhDqOQ32+D+VntQv
         O84VtVNX3XIi0XInJv0CElBusjhjDIcmcGtRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TisT6VH+4CLa8E1K+7Rlt4vslODJFJFDvFXTjKGaEBAfVrf2bGrY+20Cd6WExZHIWa
         i9rc9nu30bOjxBvEc6Jg2aeqfZUn3XU50bKkagdY4qQC2R9eCph+00/6hWH1TUPBDih2
         ddZQFcn2cENTdQD1Ib9OqW0Evxy9Xcmc90ubM=
Received: by 10.91.164.27 with SMTP id r27mr8620882ago.56.1262750285381; Tue, 
	05 Jan 2010 19:58:05 -0800 (PST)
In-Reply-To: <c1b8b6671001051607j6b6398d8gf08f7615a38de64e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136237>

2010/1/6 Russell Steicke <russellsteicke@gmail.com>:
> On Tue, Jan 5, 2010 at 12:30 PM, Dongas <dongas86@gmail.com> wrote:
>> I did a few more steps:
>> root@ubuntu:/work/git-repo/free_monkey# grep -wrin 'origin' .
>> ./.git/packed-refs:2:abfae429bb4081043e84681e5ee94102085f87e0
>> refs/remotes/origin/master
>> ./.git/refs/remotes/karmic/HEAD:1:ref: refs/remotes/origin/master
>>
>> Change 'origin' to 'karmic' in above files.
>
> Ah yes, I forgot about those files. =A0I _think_ (but I'm not certain
> without digging into the code) that it's always safe to rm
> packed-refs, as that file is a cache for quicker access to the refs.
> At least it's never caused me any problems.
>
> In any case, your approach of grepping the whole of .git for
> interesting strings is a good way to learn about the implementation.

Thanks a lot for your help. :)

Regards
Dongas
