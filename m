From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 15:06:10 -0500
Message-ID: <CADo4Y9hFgd5vU-EY6x4=hUyVDmANmgw6mH0u2=7Me=yFO5n2kg@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com>
	<CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
	<CAJsNXTkDdHTMqmXCynT2nEYyuTmSF53RVtG2V+v7b+qcsYYufg@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, git@vger.kernel.org
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 21:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnyFU-000430-0x
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878Ab2ASUGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 15:06:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60115 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487Ab2ASUGL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 15:06:11 -0500
Received: by vbbfp1 with SMTP id fp1so253005vbb.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 12:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=MDZsrllA8te4lJkAYtPWJpwJc8TZI/lDn/3dbssmnWY=;
        b=uP1PHo9/nh+CvR3m4gizOLM6VOYe/EadQdouZnMKollH8d9xDAwu/iIklL7tqfhU0D
         pshoRLDXIkkpu2N9wM0CAdsrguEmVsHt8m1zDtMuKGDJseT8nxKuSlz0bcBEzaFRYJ7r
         sQze0IGyqSPaF6FaYdN381tsvqBZUOpLnBmCs=
Received: by 10.52.177.40 with SMTP id cn8mr326622vdc.43.1327003570421; Thu,
 19 Jan 2012 12:06:10 -0800 (PST)
Received: by 10.52.64.231 with HTTP; Thu, 19 Jan 2012 12:06:10 -0800 (PST)
In-Reply-To: <CAJsNXTkDdHTMqmXCynT2nEYyuTmSF53RVtG2V+v7b+qcsYYufg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188831>

> Suggestion #1: =A0Just put $Rev$ into the file and be done with it un=
til
> the team moves over to Git (at which point you can figure something
> else out).
>
> Suggestion #2: =A0In your release process, put something like `sed -e
> "s/@@id@@/$(date +%s)/" source-dir/config > release-dir/config`
>
> -PJ

Ideally, this value only increments with a change in a certain director=
y.

I think using either $Rev$ or a data+time value conditioned on a file
changing in a directory might work.  Thanks!

Mike
