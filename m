Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16C01F453
	for <e@80x24.org>; Thu,  7 Feb 2019 07:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfBGH7k (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 02:59:40 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:37176 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfBGH7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 02:59:40 -0500
Received: by mail-it1-f172.google.com with SMTP id b5so12533533iti.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 23:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klfd4ny57bgezAXiZ0WY1FA4FTUxjN1OtCDacc+2HPY=;
        b=BhIzHSZCS7+8VKztrCVZCO3UXAAWakAA+U6NwLfwvljfQG4V3Lv0pjSejgWagrKlX9
         h3WOvTvllwFiYEhAfCedD6MhsqUj7vqnPj4r2ppcOaqyKM4FzcUL029rtZsrMZsAgvUY
         9ooUCIWvErEAeKlt1IxcJLdyCCrhQrjMpiX6g5thshCBIQWOkU4ND/vX7ts5GMDzamzj
         WGhuMHPjQTSiCcZmyaTveiUSzVE2/YpXTVAfe3soC3coC66T9yOHP/M+MhYmoxeazu2w
         V/eql9S9JXNZUuWf3q4Z0a7jxcmHD29KVJY95p66VP0HTY/4csIB6h134Vydug10LCS5
         v1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klfd4ny57bgezAXiZ0WY1FA4FTUxjN1OtCDacc+2HPY=;
        b=OxXELV54CtP68tr/HsKf2z3UkF+EDB+11XCr/xUsR5CzGFxFDIE0RLU86j+UlWnp1N
         tv0px7EjIHkzLOqFRBh5FofUnaOyqR8DEvvJaxw2GRuOSvl7zg7cD42A2sMxA3T5P8Ey
         bFxQe3/YsQHQnPH+dRH04uksec4RZ7JHjcGNEd1h4v9FvyDVyB2JybIvLCraVPRFJerp
         9ZsVtAsPcDmFUpY6ZZUuY0jl0Z+daW/1wlJLPhVmCCoP+XG/FfnFMgwxYKuCMs0pTLIF
         4EnrDvPuoprd/6CEJf/cV/KUvqv/UicS7fGrdpI2dJC6oxT5LOgqXO9j1qu49P8yFdix
         EuDQ==
X-Gm-Message-State: AHQUAubA+bNzKSZf5Pnb380ucTTwwxfRPamjQKHZ3UqIxEIjG14weUgM
        5iSDHkQ8HcaC8G68LuuRubhq3xUgbwyoHKPfjQjxoUQ=
X-Google-Smtp-Source: AHgI3IbpFG2pnY9gAMH+RsLJXaPyXjyBdBLoiTGNu1eMacZpw/P3IVDK6GhnS8vu0prIZRBg2q8OH8dtLoMPv73jyqI=
X-Received: by 2002:a5d:8c9a:: with SMTP id g26mr6749025ion.97.1549526378885;
 Wed, 06 Feb 2019 23:59:38 -0800 (PST)
MIME-Version: 1.0
References: <CAMj2QEvOzOUbLvwudAn5zoyOqc=HixsQ+SuU__rU4GZ5uDN6ww@mail.gmail.com>
In-Reply-To: <CAMj2QEvOzOUbLvwudAn5zoyOqc=HixsQ+SuU__rU4GZ5uDN6ww@mail.gmail.com>
From:   Vijay Sundar V <dops.vijayv@gmail.com>
Date:   Thu, 7 Feb 2019 13:29:27 +0530
Message-ID: <CAMj2QEsdJLsATrOvGJwGpe2fv=QzVU-6LqWJtdZArdMjFyZiYA@mail.gmail.com>
Subject: Fwd: Query on GIT merge and conflicts
To:     git@vger.kernel.org
Cc:     abdulrahmah.1989@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

I've query for which we have no solutions from Stackoverflow. Or we
couldn't find one. Would be great if you have one or can provide
suggestions with.

SO Link: https://stackoverflow.com/questions/53704320/git-merge-remote-repository-project-to-sub-directory-of-current-repository-proje

I need to merge a particular branch from one project to a different
branch in another currently running project . For which I am following
below steps

In Source Repo-A: v23-branch, I created a local temp branch and moved
all the contents to a folder and made a local commit. Then In Target
Repo-B, I added the local git path like given below. git remote add
tmpmerge <local url of Source Repo-A: v23-branch> Then did a git fetch
of tmpmerge to get the branch details of Source Repo-A. And while
doing a git merge tmpmerge/temp --allow-unrelated-histories, I get so
many merge conflicts as describe in the bottom.

Below is the tree structure I am expecting to achieve it

Source Repo-A: v23-branch
   module1
   module2
   pom.xml
   Dockerfile

Target Repo B: some-branch
   source Repo-A: v21-branch
   |-module1
   |-module2
   |-pom.xml
   |-Dockerfile
   Repo-B-Files1
   Repo-B-Files2
   Repo-B-Files3
   pom.xml
   Jenkinsfile
   Dockerfile

What I want to achieve is given below.

Target Repo B: some-branch
source Repo-A: v21-branch
|-source Repo-A: v23-branch
  |-module1
  |-module2
  |-pom.xml
  |-Dockerfile
|-module1
|-module2
|-pom.xml
|-Dockerfile
Repo-B-Files1
Repo-B-Files2
Repo-B-Files3
pom.xml
Jenkinsfile
Dockerfile

I want to merge source repo module to the destination module as
mentioned above structure because While merging contents as parent
directory overwrites some of my existing files available in the
current project like pom.xml , docker file etc. Instead of merging to
current project parent directory I want to write as sub directory with
all its log and history. But I'm facing CONFLICT(rename/delete),
CONFLICT(rename/rename) for module files... Thanks much in advance.

Thanks,

Vijay V
