From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: feature request
Date: Wed, 17 Oct 2012 05:00:01 +0530
Message-ID: <CAMK1S_iRRLFmL33UcLRowbbJqG+JoJt011yg=R3s4MegE4_JbA@mail.gmail.com>
References: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
	<CAH5451=1VU6oUzAyGXZvOW-Pk3+Os1mq1neum572venNjRfT+g@mail.gmail.com>
	<CAB9Jk9DaJnN9wmzi-4P3+PqBOobOapnU50y5zkKV9-1CNpV3Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOGaY-0006j3-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 01:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab2JPXaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 19:30:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32972 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab2JPXaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 19:30:03 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so4664933lbo.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5jlWBDaa1qsqaeFxb4TwmzvKhG58TEPQa1AJx0yRzs0=;
        b=0qqRTaw15JnAXPtyNpKM94ZO9QqeCe4G7Ke67GgK4DSV+JyPdYq2GuKfQkQbwFp44G
         qiSBamWQDcT4umDTu5RL1jGOcMn5d4eOH2YGJH4Ir/cAuwj9hAGltka9y/qG/CmLCWbg
         LOZXd13g6H0J5IcDMuCrJ8SQ/xJyU17SlAYtvMQdVCskrv1zSQn/f6SMDi4fvD8TgriU
         gnBH1yIeeYpxPVuf/nc8L7TYcLT0MviEs3efI1QryS18Bb5ve0CU3Fq61NU2fcJKYhID
         s2vTWC/iL11PArtJR4QuIE5ckAJCcGz+ADmL684nbgQR2s4KgGJ5P1AMl5WmnbLaxThv
         PPYw==
Received: by 10.152.104.107 with SMTP id gd11mr13994274lab.25.1350430201966;
 Tue, 16 Oct 2012 16:30:01 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Tue, 16 Oct 2012 16:30:01 -0700 (PDT)
In-Reply-To: <CAB9Jk9DaJnN9wmzi-4P3+PqBOobOapnU50y5zkKV9-1CNpV3Yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207886>

On Tue, Oct 16, 2012 at 10:57 PM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hi Andrew,
>
> one nice thing is to warn a developer that wants to modify a source
> file, that there is somebody else changing it beforehand. It is nicer
> than discovering that at push time.

Andrew:

also see http://sitaramc.github.com/gitolite/locking.html for a way to
do file locking (and enforce it) using gitolite.

This does warn, as long as the user remembers to try to acquire a lock
before working on a binary file.  (You can't get around that
requirement on a DVCS, sorry!)

> Take into account that there are changes in files that may be
> incompatible to each other, or that can be amenable to be
> automatically merged producing wrong results. So, knowing it could
> help.
>
> -Angelo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Sitaram
