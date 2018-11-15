Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232601F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 12:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbeKOXF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 18:05:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:37863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeKOXF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 18:05:59 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQvDO-1fu0xw2QTG-00UGk5; Thu, 15
 Nov 2018 13:58:02 +0100
Date:   Thu, 15 Nov 2018 13:57:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ga=C3=ABl_Lhez?= <gael.lhez@gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
In-Reply-To: <20181115043409.GA3419@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet>
References: <pull.79.git.gitgitgadget@gmail.com> <pull.79.v2.git.gitgitgadget@gmail.com> <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com> <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com> <20181115043409.GA3419@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-589958002-1542286682=:41"
X-Provags-ID: V03:K1:3aT8YyDOYMk0J1bIFvlQmFlzWKPzhAwZ3K03wciCmRRJSbbVd0f
 fJ6LUH1Ny87dWUAIkXsurqnVp2tj1aWbMlQ35As4ZYyobQlPPnxMMVR1Dkivx5/GbaJVzeL
 2KZfGXlhoYWJFnTSB2HziPn61xwN4TK2NQy0fZsZGz2alrP6H/1c2+OdBzTNAH1DhkIjXA4
 6Ek3zpgdKD00+4pjKKC0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:js0sYrI8tM0=:+MfSHTrotaWRtzRjMInahC
 vCz8b3LlsWIrCJ3NnZmYavTDEYwjr2htpF01hum4fpsaRltUwaaUBj5bFYlkgCJ32ct+kpTGy
 zahVlmQOfPKAGJQKQxXkkCc6RIgd9k5axRVa/8ZLVqF3sgS1H9uoANLUkye7ubi/pyzBncxtx
 LwHtKY9LoXAb/F2sC27pug7A5GnZ/UeCbiTP1gfSd7j3tat6Slb15U9eIjtDR/grEP5F570s7
 lYwutjf3oL+mio/CtrfQsoPabZNiyqVtP+1txHKxZOm95jmPPBjws5XIV4eD9lFoCsPYQU8+h
 kx/guYu/uQCZKeZB0iRaZTin8o1DLeSar/Dy7u9ikC6hqMhSPuYmYLc4uPt5KhLotGoiKAd+y
 Du/gf61tWfkMZiUdtEsYtEFhotfagzaM7/Z71n85Cdu4g3YLwmVG2MS84t/+ZL6CXn/eXFIuH
 OsiiHQPWai0/l08Q2rrE6KkWpuL495iPa0IV/xF6lrTzzbl1AZ2etts4Mg3SkTHJFSYhl7XVT
 YtojFkDVLlByNAWK7FZefR2FvbR1qP+B5rnO3FFVNHeFdzVonInLBBxNU+WSX/5+VDahklUQu
 gHhdx7WCyamirksPsLiOObGj7yLjUnuV5OjQaZDkYDZXkHw4ZtVg2/DHKeYsQMwO5P+G9jKL3
 9Ww+sm7wBukJKkerVT0tQMP7npPu6z2+B95cvG7SnedgMNFcpJdnPkqhLs6xV/BoZRo84FQjA
 HN+gt51fLg+ZB7M71d5ihmIqmMS6jVpyc3+iXDklfZ8/BuiYOHUVUgcMTu/VMavgcQKCBj4eY
 HKN7NUgA3SBha23iEut4xUXprVr+w2JOdux+RdXtjWP3aE3DZ6xmUD7QFZVmCtZiklmCgikUQ
 a4AcBzb9UpPsYfel9PIXo51VHdIKXCR0qUD785Vt74MOUbepj6mMPEHYwyZYP095wBFPxmmb2
 Z75jG73yGxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-589958002-1542286682=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Wed, 14 Nov 2018, Jeff King wrote:

> On Wed, Nov 14, 2018 at 02:08:48PM -0800, Stefan Beller wrote:
> 
> > On Wed, Nov 14, 2018 at 1:43 PM Martin Ågren <martin.agren@gmail.com> wrote:
> > >
> > > On Wed, 14 Nov 2018 at 16:26, Gaël Lhez via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > > However, the `.lock` file was still open and on Windows that means
> > > > that it could not be deleted properly. This patch fixes that issue.
> > >
> > > Hmmm, doesn't the tempfile machinery remove the lock file when we die?
> > 
> > On Windows this seems not to be the case. (Open files cannot be deleted
> > as the open file is not kept by inode or similar but by the file path there?)
> > 
> > Rewording your concern: Could the tempfile machinery be taught to
> > work properly on Windows, e.g. by first closing all files and then deleting
> > them afterwards?
> 
> It already tries to do so. See delete_tempfile(), or more likely in the
> die() case, the remove_tempfiles() handler which is called at exit.
> 
> Are we sure this is still a problem?
> 
> I looked at the test to see if it would pass, but it is not even
> checking anything about lockfiles! It just checks that we exit 1 by
> returning up the callstack instead of calling die(). And of course it
> would not have a problem under Linux either way. But if I run something
> similar under strace, I see:
> 
>   $ strace ./git bundle create foobar.bundle HEAD..HEAD
>   [...]
>   openat(AT_FDCWD, "/home/peff/compile/git/foobar.bundle.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
>   [...]
>   close(3)                                = 0
>   unlink("/home/peff/compile/git/foobar.bundle.lock") = 0
>   exit_group(128)                         = ?
> 
> which seems right.

Without the fix, the added regression test fails thusly:

-- snip --
[...]
++ test_expect_code 1 git bundle create foobar.bundle master..master
++ want_code=1
++ shift
++ git bundle create foobar.bundle master..master
fatal: Refusing to create empty bundle.
warning: unable to unlink 'C:/git-sdk-64/usr/src/git/wip2/t/trash directory.t5607-clone-bundle/foobar.bundle.lock': Permission denied
++ exit_code=128
++ test 128 = 1
++ echo 'test_expect_code: command exited with 128, we wanted 1 git bundle create foobar.bundle master..master'
test_expect_code: command exited with 128, we wanted 1 git bundle create foobar.bundle master..master
++ return 1
error: last command exited with $?=1
not ok 9 - try to create a bundle with empty ref count
#
#               test_expect_code 1 git bundle create foobar.bundle master..master
#
-- snap --

So yes, we are trying to unlink the `.lock` file, and as far as I can tell that
`unlink()` call comes from the tempfile cleanup asked for by Martin. However, as
we still have a handle open to that file, that call fails.

I do not think that there is any better way to fix this than to close the file
explicitly. If we tried to just close whatever file descriptor is still open to
that file before deleting it, we would possibly cause problems in code that is
still to be executed and assumes that it has a perfectly valid file descriptor.
Besides, trying to do this kind of "automatically" won't work, like, at all,
when it is one child process that holds an open file descriptor while another
process wants to delete the file.

Ciao,
Dscho
--8323328-589958002-1542286682=:41--
