From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 16:02:29 +0100
Message-ID: <CAHGBnuOT1ttzSuzCt4GDxJ7iap6VM1Sbyuve2FGR7pdf2z40bg@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
	<CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
	<CAHGBnuP6nyTCGGNntvWVYAtxNX9xgt6=F3HheiEUcPU_9TP-1g@mail.gmail.com>
	<CAMP44s2KdHPH-UaSwdiJtT8WNo7uT9K_ArXwqHhCryPRsX1qjA@mail.gmail.com>
	<CAHGBnuNWtgH_aYxv0gX44AkGTRo6vsKdd4w1cViLGD9O9RLaNQ@mail.gmail.com>
	<vpqsivkywdx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 29 16:02:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbAoX-0000An-6J
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 16:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3J2PCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 11:02:32 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:38018 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3J2PCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 11:02:31 -0400
Received: by mail-la0-f46.google.com with SMTP id hp15so6569253lab.33
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1lH9/SduyxJ0O2YmlTzOiV+Nz6jg/lcjIPwttiSD//A=;
        b=rsbzp72Nkl1BtA9QFd+gm+nG/fu3WL1egHzUpOG5utPM+F2ihqpyGmFkNgbbc41rC5
         13TVC5B9WVXtVq++cFmdsHwCheyMlbPaQSrLoZRqicigREYr0kbDEeusmXOx8ftFZJxY
         n7rwZ770mvv6Zsmgz3YBVlJQA3i1PqFFCh2Dv9tfveD0AfuOABAxDTDlBwvYVGyPATxB
         NQxAH0Pu5Fwo6NI54Buuy118wD0ISYzDnO8DGcJLdcV4YZ2b33LkdmRWh6zbNaSzcO2+
         TtY4JtV6GHzIsPEs50uFDDDqdObviVMhd7HN0ZQcOEemLTGmc30LgLbZWWD1BpMxa1lk
         359A==
X-Received: by 10.112.167.3 with SMTP id zk3mr404246lbb.23.1383058950040; Tue,
 29 Oct 2013 08:02:30 -0700 (PDT)
Received: by 10.114.201.134 with HTTP; Tue, 29 Oct 2013 08:02:29 -0700 (PDT)
In-Reply-To: <vpqsivkywdx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236931>

On Tue, Oct 29, 2013 at 3:39 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

>> I'm not sure what you're trying to point me at. It's clear that from
>> an implementation view you need to blame HEAD^ if you need to know
>> which poeple should review your changes in HEAD.
>
> I agree that the situation when providing only HEAD is really
> disappointing...
>
>> But IMHO that is an implementation detail that should be hidden from
>> the user.
>
> ... but it's not just an implementation detail: git-contacts takes a
> range of commits, so you can ask for people to Cc for a whole patch
> series for example.
>
> If I understand correctly, "git contact $ONE_COMMIT" does
> "git contact $ONE_COMMIT..HEAD" implicitly, and this is weird when
> $ONE_COMMIT is HEAD.

It's not only weird if $ONE_COMMIT is HEAD, but for any single commit.
At least I would expect "git contacts $ONE_COMMIT" to list the poeple
interested in the single commit $ONE_COMMIT. Instead, what it seems to
do is list the people who are interested in the commits *after*
$ONE_COMMIT.

-- 
Sebastian Schuberth
