From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Fri, 6 Mar 2015 07:25:45 +0700
Message-ID: <CACsJy8CKdcHSNEpRZDTtR36Xcv+SF2tUizNjXd_sAb1eUBgTzA@mail.gmail.com>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 01:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTg6A-0003tq-92
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 01:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbbCFA0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 19:26:17 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:40768 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbbCFA0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 19:26:16 -0500
Received: by igal13 with SMTP id l13so50638022iga.5
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 16:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7lbawYc/sYy4lBpDn4xaYofdYANsFftzJWVW8VqeLiM=;
        b=bWBdNKUa6s1X0lzLC/BqoHImRpdRMGBzLEUuzaKwtWplSAoiyzKvqSafK/zMUCqk9X
         lxq1YzRlpfmz8xn/nwRQl+5MHGNXL2MrzvbsL/dZ0LVw9sPUOIxo2cp9ewrxzd4Oh/YJ
         gCVRg+KDqIX4s6glvwZNigfrzw+W9qSSiWDVEQcVQvNlfVXT+DKshY7EdR/0tGqO4RdJ
         dgsPizHM257Az2VeODXz5KUu36BZO870tEGoWPyNe9weub1OslCAvvyA6a7SKAGmQ7GS
         Ai+lmaQHl4EuNA2yLn+9beqECqxpEfjY5dg1eyy1EyQMRbpC2CXPw28FSsWXUNL7Hlfv
         mXGQ==
X-Received: by 10.107.8.215 with SMTP id h84mr620747ioi.89.1425601576125; Thu,
 05 Mar 2015 16:26:16 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Thu, 5 Mar 2015 16:25:45 -0800 (PST)
In-Reply-To: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264882>

On Fri, Mar 6, 2015 at 4:03 AM, Stephen Morton
<stephen.c.morton@gmail.com> wrote:
> I'm experiencing very slow git pushes. On the order of 1 minute to push a
> trivial one-line change. When I set GIT_TRACE=1, I see that it seems to be
> taking a lot of time in the pack-objects phase.
>
> Others are not seeing this with the same repo, but I'm the only one working
> in a VM.
>
> ...
>
> Details:
> git version 2.1.4
> OS: CentOS 6.6 64-bit in a VM.
> repo size: huge. 6 GB .git directory, around 800 MB working tree.
> VM has 8 MB RAM and 8 cores.

Is it 8 GB or MB RAM?

> CPU: i7, 8 core (4 cores hyperthreaded)
-- 
Duy
