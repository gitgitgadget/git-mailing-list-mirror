Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195DE1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfBRUlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:41:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:57053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfBRUlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:41:25 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZlZ2-1hLIdc1KxQ-00lXwi; Mon, 18
 Feb 2019 21:41:08 +0100
Date:   Mon, 18 Feb 2019 21:41:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Max Kirillov' <max@max630.net>
Subject: RE: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
In-Reply-To: <005901d4c4b9$3b9a2a60$b2ce7f20$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1902182139490.45@tvgsbejvaqbjf.bet>
References: <pull.126.git.gitgitgadget@gmail.com>        <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com> <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com> <005901d4c4b9$3b9a2a60$b2ce7f20$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Or9FDYNojalqMqAsmpw3zlGz6gxaSBhCGsOsoYJuHmGVvhNfK8W
 FKCwg95Q0D3X8qVzytWj0VtY5YDiH7ZEhC7Xp5A/3Tiikmdb5zfENqvpEBIL8SprVTG1mD+
 exUE5m7kFG1Q/WE3vCU5jG0CX70CsCywxBQsZ6ayruiux37htqkjiLdsZhfvsOk/l8ndaHl
 JCKMb0FZrCRUAJ2WaDuOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GMiaGHtL48s=:2kqdrQV0/BYZXwBDiNH7Lh
 30lHJXYsxw4qMN+ZHL8MiFOEsqq5lj90KAXM20Ve0OY3hKr33M0oq//Wv7ylXmzHK4DKwyd/k
 b2/MVhKX2xjvk1H4dXzuX51L0VDT1SkSL4+HaT6uJcT4YBrpylSJZTUVDkQICW826rn5L0S+i
 fPOF64zAQei+Q1dHuoWcS8Vx+fFFZTxJyY4vleacR/9ZTPGEpWz/LfUdWo9LfGXx5Ve8duUiX
 qPccJWhChY7YCjoyt1TWfh7pwtpVnq4Wp/CGD0lANzPxgCXdELTMInTKUe2avWJLg9j1svttB
 PVbefxC/Xk/Vbt/jkT0lBEDoCH6I0ZgIupZAt+e7eDdDEqPJGfi0vGCd5BkE3zse6jgZp974k
 LcOopPt4O4vMiBnb1mh3DULIK2gUhVVSCoHrs2n2ZWHjMGBxjGCssMxPI5tTpqqht5OcOOk5/
 BLqA2b0FR0pP96jaCJC+7Ovyt9qmLfOnTj4ds4atQkDC1a36Y0BQmFaWEKLR7ad8SVPDAdQdv
 Wi7lxccUUIc+GtW8HjabUFl81x99qjBSjrL7oLnOFjT5ozEuMnVmwt/s3BggQd/I17PSOjxe3
 JB3MhaBvaOTQWTeyKep6izYhF1Ce2cbxMoRke+iNLS7s1weWdjx95rdmJsdbctLh+qKWtTxoj
 4LVaybUxOg1GDPCUlmvkrE1xsPmk6dU3Y88RQaNl3sg+JodfTqOwq8t4p9TLruUy0s679gRMT
 nPGvmnh60B3+Bd21wV5chl30k3qS5Fc59m7LUvD5+j8jfdcdA4PUeeB5lgky2KZfyezhwYDYT
 IfItwotQJJuoF/2uGSR2vH0v6mk9jLdpA9wiP0b2xanHSTCG6tpRsl5hyIQqpy1KQ0LL/2/hu
 uwRDkyq2LAonPzojmSeGbODYHVJgUlnHFz2sDyIs0o2VefnisbPu4EktxB07/7bsu+3V3dkaF
 2be2n9fFpzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Thu, 14 Feb 2019, Randall S. Becker wrote:

> On February 14, 2019 17:39, Junio C Hamano wrote:
> > To: Randall S. Becker <rsbecker@nexbridge.com>
> > Cc: 'Johannes Schindelin via GitGitGadget' <gitgitgadget@gmail.com>;
> > git@vger.kernel.org; 'Max Kirillov' <max@max630.net>
> > Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
> > 
> > "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > 
> > > Unfortunately, subtest 13 still hangs on NonStop, even with this
> > > patch, so our Pipeline still hangs. I'm glad it's better on Azure, but
> > > I don't think this actually addresses the root cause of the hang.
> > 
> > Sigh.
> > 
> > > possible this is not the test that is failing, but actually the
> > > git-http-backend? The code is not in a loop, if that helps. It is not
> > > consuming any significant cycles. I don't know that part of the code
> > > at all, sadly. The code is here:
> > >
> > > * in the operating system from here up *
> > >   cleanup_children + 0x5D0 (UCr)
> > >   cleanup_children_on_exit + 0x70 (UCr)
> > >   git_atexit_dispatch + 0x200 (UCr)
> > >   __process_atexit_functions + 0xA0 (DLL zcredll)
> > >   CRE_TERMINATOR_ + 0xB50 (DLL zcredll)
> > >   exit + 0x2A0 (DLL zcrtldll)
> > >   die_webcgi + 0x240 (UCr)
> > >   die_errno + 0x360 (UCr)
> > >   write_or_die + 0x1C0 (UCr)
> > >   end_headers + 0x1A0 (UCr)
> > >   die_webcgi + 0x220 (UCr)
> > >   die + 0x320 (UCr)
> > >   inflate_request + 0x520 (UCr)
> > >   run_service + 0xC20 (UCr)
> > >   service_rpc + 0x530 (UCr)
> > >   cmd_main + 0xD00 (UCr)
> > >   main + 0x190 (UCr)
> > >
> > > Best guess is that a signal (SIGCHLD?) is possibly getting eaten or
> > > neglected somewhere between the test, perl, and git-http-backend.
> > 
> > So we are trying to die(), which actually happens in die_webcgi(), and
> then try
> > to write some message _but_ notice an error inside
> > write_or_dir() and try to exit because we do not want to recurse forever
> > trying to die, giving a message to say how/why we died, and die because
> > failing to give that message, forever.
> > 
> > But in our attempt to exit(), we try to "cleanup children" and that is
> what gets
> > stuck.
> > 
> > One big difference before and after the /dev/zero change is that the
> process
> > is now on a downstream of the pipe.  If we prepare a large file with a
> finite
> > size full of NULs and replace /dev/null with it, instead of feeding NULs
> from
> > the pipe, would it change the equation?
> 
> Doubtful. The processes are still around, and are waiting on read but not
> actively reading (CPU time is not going up, so we're not reading an infinite
> stream). To me, this is a pipe situation where there is simply nothing
> waiting on the pipe (maybe a flush missing?). I'm grasping are straws
> without knowing the actual process architecture of the test to debug it.

So could you try with this patch?

-- snipsnap --
diff --git a/http-backend.c b/http-backend.c
index d5cea0329a..7c1b4a2555 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -427,6 +427,7 @@ static void inflate_request(const char *prog_name, int out, int buffer_input, ss
 
 done:
 	git_inflate_end(&stream);
+	close(0);
 	close(out);
 	free(full_request);
 }

