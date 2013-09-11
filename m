From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 11 Sep 2013 05:53:44 -0500
Message-ID: <CAMP44s2dmn48T=c6aSLrWeTY=CKf5AYnAv7gA8bLjLMyb9-MTA@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
	<CAMP44s0YaQo7xAkPcV3xVTcYQStUVuyY=we-=KMgtZ-xgZzz1Q@mail.gmail.com>
	<vpq4n9tjd5z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 11 12:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJi3f-0007rV-Vc
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 12:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab3IKKxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 06:53:47 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:38997 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3IKKxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 06:53:45 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so7418362lab.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bdnz35RQghQTCz5Uh81XAiu+VGZUzPzWkzgRJTFwixI=;
        b=SCqrVcoVsfPtoEyT6A0TWsOD0ySmzHRuO/Dg9L3Nc4ighmGkm9l3vDWoO9Ei3qWImm
         J8uBkL8qWyn+a1Pu84LUdpHFGqY0Y9HfgukCYPUkahhDUPmH73ZMI0X0LG4Qvf68jU9Z
         bXtm/qwVBRNWzJgBoJ2ASV9gXXxorEOt7FhrtE305VpvQ5gVsxiXq0qH4hZ8zdJYcX0W
         ifQyPWzXyv0El6jZL/KaC9q1fD+s8K+k0qEK7qC0TvFa/rrqCdHLtzIHo42O0x2xZgEk
         LpxIllg3a8NV/GSFPCQgmOFPatm9IL45rBvm96tSQtJgXSsDEeo8qc+Z0GBLDnG1ADuK
         Oz4w==
X-Received: by 10.152.37.41 with SMTP id v9mr780507laj.9.1378896824620; Wed,
 11 Sep 2013 03:53:44 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 11 Sep 2013 03:53:44 -0700 (PDT)
In-Reply-To: <vpq4n9tjd5z.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234556>

On Tue, Sep 10, 2013 at 3:26 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The problem is the newcomers, and the newcomers will most definitely
>> not activate a configuration option to tell them that they are doing
>> something potentially undesirable.
>
> I teach Git to 200 newcommers each year. All of them run "git pull" the
> first day, but believe me, very few of them want to know what a rebase
> is at that time.

And who says they have to? This is a straw man argument.

May of them don't want to know what the staging area is, that's why
they run 'git commit --all', and just like that they can run 'git pull
--merge'.

>> By the time they learn about pull.mode, they probably already know
>> what a rebase is. So what is the point of the configuration in the
>> first place?
> [...]
>> That doesn't mean anything, you are assuming the user will do 'git
>> pull --rebase', and there's no rationale as to why they would end up
>> doing that.
>
> So, you insist in asking the user to chose between rebase and merge, but
> you also insist that they will not chose rebase? So, why ask?

Because as you said, they don't know what that is.

>> 'git commit' by default "prevents" users from creating commits without
>> first adding changes to the staging area, and since it's a concept
>> unique to Git, it's fair to say that none of the newcomers understand
>> why 'git commit' is failing, the error messages is not particularly
>> useful either.
>
> I don't particularly agree that not defaulting to --all was a good idea,
> but that's another topic.

It the same topic, the project already made a choice, and precisely
because of the same reasoning that 'git commit --all' is required,
'git pull --merge' should be required.

> But the error message is rather clear:
>
>   no changes added to commit (use "git add" and/or "git commit -a")

And we can do the same:

"Read more with 'git pull --help' or do 'git pull --merge'."

-- 
Felipe Contreras
