From: Subho Banerjee <subs.zero@gmail.com>
Subject: Re: Git.pm
Date: Fri, 27 Apr 2012 01:40:07 +0530
Message-ID: <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNV1O-00077W-7X
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab2DZUK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 16:10:29 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63316 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab2DZUK2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 16:10:28 -0400
Received: by vbbff1 with SMTP id ff1so2834vbb.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ifaYKf0FPMfg5/9smET6q95g0+ncNNxdvMHhmIZJYWc=;
        b=ttzLTuNGj1+PtZ5YYPp7uJT0/F9q69I6Ln8FFWKh1T96VApDxKWcGkhcQyWYZpB0JR
         PvNtsMEYXgMYal5Czi9qbXobN3ewr5xUf+KYmfPhU6z6+vDuIsoz8vR0nwBQ2syT7v2R
         /IikwInO3gkKGen6zvBNHHkSJ6aoOBbplPTun4vxI/8OU9wbiHo6Q1CVZUvMtGIZ2zag
         sWHVvyFGDQtUH4r918zTjzRo0SxsmzXnUaGhwCCOUtOJyeLaP7XMk8eu8i+5euyh9yDy
         e+VaalgYbA2T+uu8KcUUmBJQCx+Fpi3th17+zu+OlYRjI/KpfWIkaFbJTyjVyKkvswxY
         O+uw==
Received: by 10.52.100.228 with SMTP id fb4mr7473928vdb.62.1335471027867; Thu,
 26 Apr 2012 13:10:27 -0700 (PDT)
Received: by 10.220.189.137 with HTTP; Thu, 26 Apr 2012 13:10:07 -0700 (PDT)
In-Reply-To: <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196402>

Hello,
I will take care that I dont break those. Should the tests in the t/
folder of the codebase be enough to make sure everything is working as
it should be even in the Git perl module? Also is there anything like
a public build server which actually catalogs which tests are
currently failing so that I know what has gone wrong after my changes,
or are all commits supposed to pass every test?

Cheers,
Subho.

On Fri, Apr 27, 2012 at 12:28 AM, Tim Henigan <tim.henigan@gmail.com> w=
rote:
> On Thu, Apr 26, 2012 at 12:15 AM, Subho Banerjee <subs.zero@gmail.com=
> wrote:
>>
>> ---> I see in the code that it says that the API is experimental. Is
>> there any absolute need for backward compatibility, or can I try to
>> redesign the API somewhat extensively?
>
> A quick grep of the code in 'master' shows Git.pm used in the followi=
ng:
>
> =A0 =A0- contrib/examples/git-remote.perl
> =A0 =A0- git-add--interactive.perl
> =A0 =A0- git-cvsexportcommit.perl
> =A0 =A0- git-send-email.perl
> =A0 =A0- git-svn.perl
> =A0 =A0- t/perf/aggregate.perl
>
> There is also work in progress on 'pu' that relies on Git.pm.
>
> Breaking any of these scripts would be bad. =A0You may be able to
> refactor them at the same time Git.pm is modified, but it would be
> wise to contact the authors before making any major changes.
