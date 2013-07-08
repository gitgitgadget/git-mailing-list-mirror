From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Mon, 8 Jul 2013 11:24:39 +0100
Message-ID: <CAOpHH-WiH8K__Wm_0WmnDpY8OKMWVz5-sOQWZ1vtb0GPJ44USQ@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
 <CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
 <loom.20130705T195116-413@post.gmane.org> <CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
 <CAOpHH-WAjjaa3oOXje3u5bBWb=vm-2wG1KYf8oKwH__XLK4R2A@mail.gmail.com>
 <CAHCaCkJDNqhd0UqnZhrA13V=J_yJBr17BuWohjMRADCPYFiQ4Q@mail.gmail.com> <CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Brucher <matthieu.brucher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 12:25:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw8dU-0002Jl-48
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 12:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab3GHKZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 06:25:11 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33645 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab3GHKZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 06:25:09 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so9559805iec.36
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8SxPbZ0eunZpZrYxneo4NsjC173rIEZhkD/IjP+rzpo=;
        b=DygDwFeHXlqQKF2rvOdsj3tOOtLgeYSdLx26xd4AzcSjSL33iOIctL0RIdSgnH9YJ8
         00YHU5HK15DmwueuLgNAZ3Ave2ySgWw2nlE8gOfkhCoLk+byMeBpBV0d+ecy8ww6SG+I
         KFTpHUmIT+akw2CDZrINhJecP7aYpaSqJlkLpO48a2ti674rzDPhGUYgFxwn+/0ExOC2
         rleiQNuYHnUlO4eAdoT4w3tmfhdDd8U17j902nHZTdq8GiMsrzjm/kjYyPe/CvqhhWh4
         TsVfM6D6KDAdNxhcWTLdrTMBR1UYUhD1gFhdrBSIckbRutBuzOnKe4/+HkAjIK9LQWSr
         hR4g==
X-Received: by 10.50.176.131 with SMTP id ci3mr25102409igc.18.1373279109448;
 Mon, 08 Jul 2013 03:25:09 -0700 (PDT)
Received: by 10.64.21.103 with HTTP; Mon, 8 Jul 2013 03:24:39 -0700 (PDT)
In-Reply-To: <CAHCaCkL=ghxktJHDEVPfn73o-6oPQnXQv1NBCwxkwsM==-bQ4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229834>

On Mon, Jul 8, 2013 at 11:09 AM, Matthieu Brucher
<matthieu.brucher@gmail.com> wrote:
> Hi again,
>
> I tried with @all, but it didn'y work as expected. It imported a bunch
> of revisions (but no files?) and ended with:
>   Reading pipe: ['git', 'config', '--bool', 'git-p4.importLabels']
>   Not checking out any branch, use "git checkout -q -b master <branch>"
>   executing git config --bool git-p4.useclientspec true
>
> And when I tried to checkout Branch/Main, it failed with
>   fatal: Cannot update paths and switch to branch 'master' at the same time.
>   Did you intend to checkout 'Branch/Main' which can not be resolved as commit?

Hi Matthieu,

Please run "git branch -a" in that repository and you should be able
to see the various branches under /remotes/p4/
Then you just need to choose a branch and run "git checkout -b
git_branch_name p4/p4_branch_name".

Cheers,
Vitor
