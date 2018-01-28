Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538E71F576
	for <e@80x24.org>; Sun, 28 Jan 2018 07:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeA1H5l (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 02:57:41 -0500
Received: from mout.web.de ([212.227.17.12]:62818 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751755AbeA1H5k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 02:57:40 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJCWU-1ee3wf3EGA-002mVq; Sun, 28
 Jan 2018 08:57:31 +0100
Date:   Sun, 28 Jan 2018 08:57:31 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Filip Jorissen <filip.jorissen@kuleuven.be>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
Message-ID: <20180128075731.GA17412@tor.lan>
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
 <87607nvzrd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87607nvzrd.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:hC9MlAm2uijx7c7BjZT3HEXKC5tpvELaMmbblY19YXJr2xXiasP
 EE7cnXCASvz7u3BjAsRY8yg+03KdRU3paBwxQzaoTb9sDeClcXJZyJoZzuvFfs868Ts0jhK
 HyImp5/z4gUNttmQWpYsO9/7rWyPVnW90xFeXkjrrUBYgoKL5nFe29eNJdLcBO7br/U7lfo
 D9o4eZfvMBDUUhlv5wOIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ybKhWXPs8e4=:yNg+r98/do+FrNRu6YYVIJ
 iBSxNIH1Iq/s4Xmi8si6dlrBzoiUlGAhyp8nJJar+punrBULTp8UriCEOT4gc3thvPTMJjc5N
 QJPtrxp10S7hNxk0lRu3LC+4C/mVm+G0SZWh/qAOfVmrBizEwdCNsHapm/RQWbuq6I1uDudue
 wYMjbtBU1fwJxC3X43+4x04d1JH1lnDRfa40UYMCOLmG006Cl6xux9DMyr3v65Yef4J1TGPdY
 jtBWnRjRO4uJn/SuHaqdF+myIIlMA1apQg0J2P2n+oPrfu6WpH+qcdESQjxHDuBQBUM7xFfvi
 C+ppgKF5mhKq0PTS48ziAe9H2coU480A7UlQ0LqrEhRJ9aIporauSadlwL4vqWWOPpQlFUZZP
 6TkEV6Q68h2Wj7lYMWpr/TQ2RXpuGDjdE9iucISVuLAdc2rlJW8Ab+d77sctNyZvMsyuJQ0jR
 tXhvMKs9Kuwc28f2WwUmz2Y6NNZ2/Hj6boWzlcBfUwZ/yuTQw6UvvFExhylzovgJYqB9P19ou
 gV1W5fIkbBwAn+t4FuF7OmaoVUT5jg+H9pcCOv0AhQBj1g2hOlBDoBU3JPNS4n/khV7LJrYSb
 X1BXgueao2kGgh4yy37X1PJt/glX9uWRq8gClqikL2VprF3x6AD7qXAufl6SA+GRJS/FHtFrD
 KLymyYKvUm8Kk9WnMUuTWBAjTebVljVWBoAb4+IOBuf9HzTxZW4YovOh/ARVdmpUNBZ0qFT5G
 H8e3Rl0qNl7V/uBt+GOvcLss7hEqOSMZ0737PQDKg7g5JIXG6xz2f+/0m9R+de7bOftSAZcmH
 NvH/pZEHfHfQbCY5Gz5Mf0NE/CMbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 08:59:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Jan 27 2018, Filip Jorissen jotted:
> 
> > I think our git repository is bugged. The reason why I say this is the
> > following. When cloning the repository, the newly cloned repository
> > immediately has file changes[...].
> 
> If you run this:
> 
>     git ls-files | tr '[:upper:]' '[:lower:]' | sort | uniq -D | grep '^'
> 
> You'll see that the reason is that you have files that differ only in
> case.
> 
> You are using a Mac, and Macs by default think that files that are
> different binary strings are the same file, since they don't consider
> case to be relevant. The file FOO, foo and FoO and fOo are all the same
> file as far as your Mac is concerned, but would be 4 different files on
> Linux.
> 
> > How can I fix the repository?
> 
> You could check it out on a OS that considers files that differ in case
> to be different files, e.g. on Linux, move them around, push it, and new
> clones should work on your Mac.
> 
> Alternatively I hear that you can create a loopback case-sensitive FS
> image on Macs.

You can even fix the repo locally.
There are 2 files with uppercase/lowercase collisions.
I show you how to fix one off these, the other one goes similar.
After that, do a commit and a push and pull request.



Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
        modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Utilities_Psychrometrics_Functions_Examples_saturationPressure.txt

no changes added to commit (use "git add" and/or "git commit -a")
user@mac:/tmp/IDEAS> git ls-files -s | grep -i IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
100644 f56cfcf14aa4b53dfc5ecfb488366f721c94c8e2 0       IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
100644 e345e1372111d034b4c5a1c75eb791340b93f55e 0       IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
user@mac:/tmp/IDEAS> git mv IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump2.txt
user@mac:/tmp/IDEAS> git checkout  IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump2.txt
user@mac:/tmp/IDEAS> git checkout IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt
user@mac:/tmp/IDEAS> git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        renamed:    IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump.txt -> IDEAS/Resources/ReferenceResults/Dymola/ideas_Fluid_HeatExchangers_GroundHeatExchangers_Borefield_Examples_MultipleBoreholesWithHeatPump2.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   IDEAS/Resources/ReferenceResults/Dymola/IDEAS_Utilities_Psychrometrics_Functions_Examples_saturationPressure.txt

user@mac:/tmp/IDEAS>
