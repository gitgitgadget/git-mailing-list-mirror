Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED644C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05C42072E
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgKDRy5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 4 Nov 2020 12:54:57 -0500
Received: from elephants.elehost.com ([216.66.27.132]:40099 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732139AbgKDRy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:54:57 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0A4Hsrin002499
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Nov 2020 12:54:53 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Alex Marginean'" <alexmarginean16@gmail.com>,
        <git@vger.kernel.org>
References: <CALG6MqwdCmwS5D_F9+q6UYzGm5ZzLL7Bi=rD7Ph2XE0uccu+xg@mail.gmail.com> 
In-Reply-To: 
Subject: RE: BUG
Date:   Wed, 4 Nov 2020 12:54:47 -0500
Message-ID: <037e01d6b2d3$9957f3d0$cc07db70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkfuQjgOyOzfuyzQ4KZI4HmvX0TqocmmxQgAAOrgA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 4, 2020 12:03 PM, I wrote:
> To: 'Alex Marginean' <alexmarginean16@gmail.com>; 'git@vger.kernel.org'
> <git@vger.kernel.org>
> Subject: RE: BUG
> 
> On November 4, 2020 11:10 AM, Alex Marginean wrote:
> > Github has changed the way they name branches, so now instead of the
> > `master` branch there is the `main` branch however, I'm having some
> > trouble with the naming
> >
> > **Steps to replicate my problem**
> >
> > 1. Create a new Github repository and make sure the default branch is
> > `main` 2. Add something to the repo, a `README.md` file should be enough
> 3.
> > Instead of cloning the repo make a new directory with your repo's name
> > `mkdir <repo_name>` and change the directory to it `cd <repo_name>` 4.
> > `git init` 5. Add the remote repo with `git remote add origin
> > <repo_link>` 6. Pull the `main` branch from the remote repo with `git pull
> origin main`.
> 
> Use git init --initial-branch=main

You could also use git branch -m master main after the git init if your version of git is too old.

> 
> This assumes a recent version of git.
> 
> >
> > After the step number 6. instead of my branch changing to `main` my
> > current branch is changed to `master` which has every file and change
> > of the branch `main`. This is a real problem because if I try to push
> > changes to `main` although my current branch shows up as `master` it
> > creates another branch called `master` on Github and the `main`
> > remains unchanged. Yeah sure I can `git checkout main` after that and
> > make my changes there but I'm not sure why it defaults to `master` and
> > copies `main` from Github into local branch `master`.
> >
> > P.S. If you were to use `git fetch origin` instead of `git pull origin
> > <branch_name> and then manually change branch to `main` with `git
> > checkout main` it would work. Also, if you were to clone the Github
> > repo using `git clone <link>` you will get the correct current branch that is
> `main`.
> 
> Regards,
> Randall
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000  UNIX
> developer since approximately 421664400
> -- In my real life, I talk too much.

