From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 07:16:30 -0500
Message-ID: <CAMP44s162msct=W0eV93LX15Bho=DA1baLZcgFCouSRH=z0mDQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com>
	<CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
	<CALkWK0nji4m0zJPf_s0G5jfWaAN_RTGFZ6dSxfahq2OcRsu5xQ@mail.gmail.com>
	<CAMP44s1RpgM5U0ySsof_sgEHNS1p-seQ=ciVCth9gOJMG0cpHw@mail.gmail.com>
	<CALkWK0krWM4kJ5GTnQ2SL7HoNfNMNA0-xdRVbeatAFpyKW_RtA@mail.gmail.com>
	<CAMP44s0KW4_Q6-d-3=M7GzWmHwy4H--FcemK4UF5FS0t3wnOgg@mail.gmail.com>
	<CALkWK0ncfuzuYSKjkT2uQy4dGR=TSnHoJNdhU9ownDUytysL6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 14:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USnlU-0005mJ-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 14:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967267Ab3DRMQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 08:16:32 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:50949 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966596Ab3DRMQb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 08:16:31 -0400
Received: by mail-la0-f52.google.com with SMTP id ek20so2466210lab.39
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6MlDP0IIemblUCcU5y+lde6dbweziEIkIGKeZm+wmR0=;
        b=QF/ffKXtm2C0bSBcohYi7pAYNhp3zVp7UibSR3z9pwAuYD4zXbGa1Xl7pSgVukRg9T
         m3F+Z7IP14IonyTMwWy6/wYjTwH5aUUV9anl8mvABz529mZ7pCkBC5K7CE9vYjStVY8D
         dvZ2zxZvH+zAyZqMWScSdM0Br8B80VIeZ5L8XKNAz9g0Ydu6Q1aHYR/CRX+zyPVJFz6l
         dRY1zyhcOyGqBcIpRMFCIuJo66/dKyVVTbjTL66WNQyAoHnIKac0ov/F5EKymraumM/f
         6nIMdRRPhKhpYbay6Tufyhkz2CeYCMXGZuXYY6KAQY6xryQyL9ZMsZQYRuMS70Q2PSyx
         Ls8w==
X-Received: by 10.112.139.226 with SMTP id rb2mr4755881lbb.12.1366287390239;
 Thu, 18 Apr 2013 05:16:30 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 05:16:30 -0700 (PDT)
In-Reply-To: <CALkWK0ncfuzuYSKjkT2uQy4dGR=TSnHoJNdhU9ownDUytysL6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221655>

On Thu, Apr 18, 2013 at 6:46 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Okay, one more segment needs to be responded to.
>
> Felipe Contreras wrote:
>> If remote-hg wasn't available for users, they would be hurt; if stash
>> wasn't available, if rebase --interactive didn't exist, if there was
>> no msysgit, if it wasn't so fast, if the object model wasn't so simple
>> and extensible; users would be hurt. And if users didn't have all
>> these, there would be less users, and if there were less users, there
>> would be less developers, and mercurial might have been more popular,
>> and most repositories you have to work on would be in mercurial, and
>> you might be developing mercurial right now.
>
> Flawed logic.
>
> A large number of users doesn't automatically imply good software with
> lots of features, or even a great development community.  A great
> development community leads to great software.  And great software
> leads to lots of users.  Sure, there's a feedback loop pushing users
> to become developers; but it doesn't start with users of vaporware,
> leading to more developers joining the effort to turn that vaporware
> into a great product.
>
> Life doesn't begin with users.

Nobody knows how life began, and it doesn't matter now, what matters
is how life evolves. It doesn't matter if the chicken was first, or
the egg, what matters is that if all the chickens and eggs are gone,
there won't be more.

Plenty of projects have died because they stopped caring about their
users, and without users there's no new developers, and the old
developers eventually move on, and all the literary quality of commit
messages have no eyes to see it.

I repeat: no project is more important than its users.

-- 
Felipe Contreras
