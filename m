From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Retrospectively add alternates to a repository?
Date: Sun, 16 May 2010 16:55:21 +0300
Message-ID: <AANLkTin5igmPVoISyyj2DtRV6OWagDq-boBkP6Zqq_z-@mail.gmail.com>
References: <loom.20100227T004822-959@post.gmane.org>
	 <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com>
	 <20100227083418.GC27191@coredump.intra.peff.net>
	 <loom.20100227T123539-643@post.gmane.org>
	 <20100227123056.GA22382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steve Folly <steve@spfweb.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 16 15:55:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODeJZ-0005jR-6U
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 15:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab0EPNzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 09:55:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:25716 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab0EPNzX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 09:55:23 -0400
Received: by fg-out-1718.google.com with SMTP id 22so151624fge.1
        for <git@vger.kernel.org>; Sun, 16 May 2010 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qWEUhZvZEOvG6fwGp8qllWE4L0VnIjKaUBowdy2tYG4=;
        b=krWe+NWSXo3bBwHJlJ6kdKmDsncvzQImg6xDYlb90wD/Z9L66ugsX7Zp8fsA5bAAtz
         CNfi5v7oT2SBLbseyQxSnH+opkF3vVnWRqR0g4u1bX/2ZlhvBjGnq9JGk5pXVB7RbeKJ
         kPtqiU4EnhApdGobEl1N3ecX4JEyw9TmvKaqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jPuDRWSxkRy7sKTQvbVKwvgA5HlYw0NRMx0m5CYjAf2laBSQIZ1tWR1ZfMj/vkClFN
         J/DX9+nDI8DyMAIh5xx01zuQGC03vIX3lB/NuCv0pcBJEyKHbQsJ32pAcTLpE6fPmHHv
         sE7QhreCcbEypQ7OsFDRZeLzRZ6kZmRLDDECY=
Received: by 10.204.1.136 with SMTP id 8mr13573bkf.92.1274018121936; Sun, 16 
	May 2010 06:55:21 -0700 (PDT)
Received: by 10.204.60.78 with HTTP; Sun, 16 May 2010 06:55:21 -0700 (PDT)
In-Reply-To: <20100227123056.GA22382@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147190>

On Sat, Feb 27, 2010 at 3:30 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 27, 2010 at 11:43:55AM +0000, Steve Folly wrote:
>> attach =3D
>> =C2=A0 =C2=A0 echo "/path/to/mirror" > .git/objects/info/alternates =
&&
>> =C2=A0 =C2=A0 git repack -adl &&
>> =C2=A0 =C2=A0 git repack -ad &&
>> =C2=A0 =C2=A0 git repack -adl
>
> I don't think the first repack is doing anything (I showed it in my
> example only to show that it was not actually working).

That's a bug, isn't it? Has anyone taken a look into it?

--=20
=46elipe Contreras
