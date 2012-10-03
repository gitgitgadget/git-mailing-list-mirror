From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Wed, 3 Oct 2012 20:29:48 +0530
Message-ID: <CALkWK0mP36OXZ7kXZnA-KH3HB2mCLJuvx6iX2=LQawSCgM-ujA@mail.gmail.com>
References: <k4hj91$4tt$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 17:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJQQy-0005L2-L0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 17:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab2JCPAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 11:00:10 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64811 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2JCPAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 11:00:09 -0400
Received: by qaas11 with SMTP id s11so1562005qaa.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U1HakQUfF3/cdjx465w5/HHOVilCketw/g18or6gPSM=;
        b=IFKW2e/lEAFLV+vnipeaqF/JxIwh/I2F/SzsQtdoWN/Z3soFkmhjYSN6N3UAdMLSfz
         pZQmEmvNnLXZf+nLzCzpvsQpDUenapPcb7Grjndc8UVX3pm2mIYTQ4C2ZXI3nOE36M5R
         UHI3ptj/KuAy3AL1B74BWXisCxPYvQD0VxpkzYoXvytbYjqa15kuCjDWBOJCp5QcmE4E
         1crPVvlH4TABl8RBYBzftmhcrAu4di6Mtle0krpZDjkAFEkdLz3Sy2+KZ5TiODjbNGqX
         ME63Am6bC2NHdla/Kzuh2f/Hfo5F1JXtVbUn0wMlMchokBszOdbiP9DKAJsJaUcgs1GJ
         E/Gw==
Received: by 10.224.78.141 with SMTP id l13mr7609719qak.25.1349276408686; Wed,
 03 Oct 2012 08:00:08 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 3 Oct 2012 07:59:48 -0700 (PDT)
In-Reply-To: <k4hj91$4tt$4@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206905>

Hi Geoffrey,

Geoffrey De Smet wrote:
> [...]
> The following commands are ok to do (because I have 2 unpushed commits):
>  git reset --hard^1
>  git reset --hard^2
> but these are not and should be prevented (unless forced):
>  git reset --hard^3
>  git reset --hard^4
>
>
> Is there any way to make git idiot proof by enabling that the local repo
> should always respect the history of the remote repo (unless forced)?
> Is there any way to make this a default for anyone who clones our blessed
> repo?
> No one that clones our blessed repo wants to come into the situation above.
> And if they do, they can always force it.

This makes little sense.
Which remote?  What if I have multiple remotes?  Which branch? (Many
of my branches are behind `master`).  What if I want different
histories on different remotes?  What about more advanced operations
which implicitly 'reset' like rebase?  What if I want to rewrite
history?

Ram
