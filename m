Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66563211B5
	for <e@80x24.org>; Thu, 31 Jan 2019 20:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfAaUev (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:34:51 -0500
Received: from mout.web.de ([217.72.192.78]:58861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726848AbfAaUev (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548966888;
        bh=+0YrjEKOEe4J4rMWS3bNjr2G3Jrnd4dCJLn1Wnzm0uQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IJr5NPl/Uu+/vF9zXNtQBwcn+5u7tYDXuJLYGK7eXaqgjY9tD0tFdFdkhGWThvsuI
         VTu960DdTass9PWMNY1BnzK5ou8/2/vLn1IPGiBnvWyr2HkyvkWCKCLFsxiGU8mz1S
         6xbsiobKlt1AOyeImdezGp5J2BH3wwf7LmCDR+0I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsGF-1hAYt11W1z-0153F4; Thu, 31
 Jan 2019 21:34:48 +0100
Date:   Thu, 31 Jan 2019 20:34:47 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Angelo Melonas <angelomelonas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible minor bug in Git
Message-ID: <20190131203447.aovalz2vzsjpdjdv@tb-raspi4>
References: <CAHYHVP+ty7i7a_abT-th_HR2X-8X6mLmpHPR_3VXv5LpWUsrhQ@mail.gmail.com>
 <CAHYHVP+Dvbq_aOMy1_Kq0LHJsd4r+4GiP3N3R4A9ouAoJ4gw9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYHVP+Dvbq_aOMy1_Kq0LHJsd4r+4GiP3N3R4A9ouAoJ4gw9g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:aHkIeXotoz/u6kZIKuhCsQrBe3lXiJ4ZOC3yE4TsA49ES6pifvq
 ObA7jVdjvH3DpWlVrwF79ndmaKBdKpR4F2d9ak+nb4D/WFZOvTZ3kiAJQHutc2RfgMM7RNN
 +MOp1LpDxqw1V7BgdvRR3k4wt43JYpARjh6SeGmyDs3PfZ6yGSKPRaA4nUL7nIp3HlLWHH6
 40cyHhMyqJ9OTveWyhtgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wj184x0bxB8=:r4zEkyq8gtgbN37gSqZu7j
 ZlAj81qzkWf9c7jX2uNxbSoocJKerYB3I8m9I1TvQfCDlufyE8RvsU8BozqtztYphPLXfQApG
 wk5xb5fysnj6syYx/7xnYMJS1wb2ftCsgi05u9IpXvehD2hi+nGzeWQRSzgItXN1jgf8HV9Vm
 epR2f7RjMbI6JlWguncTSom0nA0VjMWL96GFRiTLD1WXixEIEp294fTVipn1qnNcEE0tI+GoI
 LciS15ghCWZhRcmqaU5SGKIz4KeULVWRee0MscLuu+tZSnnP4MwnC1rPSxOUwS/ZmIDz4kHSN
 Np6kF2CGYYV3sXAbzrUvy61KqhAtV4YqjvI+eKeuAN9gr6uKv5nb2HyOlLUPBDL7S+P0qrO85
 CEN4nQbyliVVp1csdP9gIz4SJ5V2eRIWq+zkGlCjtrHBI6uW22tRcTCRCIYyMC2x/EdypTfU3
 YudexyJ/flw6qQAMuuuED2yLldvmIMtAqh9KOcx2Cp6lipvmwCqEnGg9XmuSLwXaKCgpfCuEf
 61d70MmYFlcAtZTVrke3DGhGV2iUvMT540YsABIWHnnOxKxsPp1WowLSm/EM+KIs/hb2zpnIS
 fO3fkBOgrp8IUg9d6iK3hExjOrTPd5lbE4bvZZlVvITwcXXZFcWsb5z2PifHZXmM7kec9HTEO
 clJWEKsXuve19+Q10Z24o+VOxWlejoFGK2ARW9tWbHhUSKAEQJp1ja0jIjCxKjapnYARuT8Zc
 mFh36KaRafYFi6J5Rca/42mQPpkcNBZcfQWX+Tp+tcefn7601V6xYPBjzXExXJvbfqjca69wj
 IKLLox+TXrVdnMnUUBLAT+yeUYl0G4rAavZsJzmcreH8ByzvWdRNvle71f7hG8GiX7ifm65ja
 TU6CypBjEHFXnA4xl5xbjWLQ4eNCE4FNxGqb+wfBJsWsMEe5VHE8uDO68M+ri3
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 09:29:28AM +0200, Angelo Melonas wrote:
> Just to clarify, I made a mistake above. Instead of "untracked", I
> meant "unstaged".
> I apologise for the confusion.
>
> On Thu, Jan 31, 2019 at 9:01 AM Angelo Melonas <angelomelonas@gmail.com>=
 wrote:
> >
> > Good day,
> >
> > I found a potential bug in Git for Windows. The bug can be reproduced
> > as follows:
> >
> > 1. Modify a file so that it shows up as "untracked" when executing the
> > "git status" command.
> > 2. Attempt to "git add" the file, but change the case of a single
> > letter. The command executes but no warning or error is displayed.
> > 3. Execute "git status" again and it still shows the file as "untracke=
d".
> >
> > Please let me know if I am mistaken. I also have a screenshot
> > demonstrating the "bug" which I cannot attach to this email, but which
> > can be requested.
> >
> > Have a great day.
> >
> > Kind regards,
> > Angelo Melonas

See the example below, Git tracks AA.txt, so you must run
git add AA.txt

After a commit, you can tell Git that the file was renamed:
git mv AA.txt Aa.txt
(and then a commit)



=2D-----------------------------

user@mac:/tmp/tt2> git init
Initialized empty Git repository in /private/tmp/tt2/.git/
user@mac:/tmp/tt2> echo AAA > AA.txt
user@mac:/tmp/tt2> git add AA.txt
user@mac:/tmp/tt2> git commit -m AA.txt
[master (root-commit) f102760] AA.txt
 1 file changed, 1 insertion(+)
  create mode 100644 AA.txt
  user@mac:/tmp/tt2> echo BB >AA.txt
  user@mac:/tmp/tt2> mv AA.txt  Aa.txt
  user@mac:/tmp/tt2> git status
  On branch master
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working direc=
tory)

        modified:   AA.txt

no changes added to commit (use "git add" and/or "git commit -a")
user@mac:/tmp/tt2> git add AA.txt
user@mac:/tmp/tt2> git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   AA.txt

user@mac:/tmp/tt2>
