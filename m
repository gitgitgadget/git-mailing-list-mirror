Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909531F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 15:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503151AbfJXPZR (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 11:25:17 -0400
Received: from mout.web.de ([212.227.17.12]:39709 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503110AbfJXPZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571930709;
        bh=f1AnLfjtJyFY2xaDrYLmda7Wkps+9Zr2KOG3JEHmPKU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ANmunYp9AgdN/wqdvGtNeiwo4RtB98wN1BjVvsD3eu9fIwHmYMxFK5o6zX4+Rb6Vf
         XK2J/K1prhZrIczScCw0wH3N8HAoKrg7/iizHNa3CPcY531UVYeHf7uDNUcRSe0XSo
         Fk8FCEHw9ZXxlkv/NAiwmdxdMkMYkNMNxxPHVtlM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhFJ-1ig1JY0HOn-00J6Bi; Thu, 24
 Oct 2019 17:25:09 +0200
Date:   Thu, 24 Oct 2019 17:25:08 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Git Test Coverage Report (October 11)
Message-ID: <20191024152508.a6vr7nh62wsqzy6u@tb-raspi4>
References: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
 <20191023170049.hnzb22iiflrigyfs@tb-raspi4>
 <ebe33082-976d-7146-1450-925e4785faf1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ebe33082-976d-7146-1450-925e4785faf1@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Ud3xKryhAfaYxVBDtHpjVWkZJ4JYDUb4L37tDnwvqyat8tiMHlQ
 fqY+zooGvvpRpBBXciPEIvm2ktMYGTt+bzBz6h1kmNAI0VMh5xi8ftgj287dNGmZy/sHH2p
 7DUJgESI+VnBtxGNH7qIPLHoms7qr+GvngzUTqM4KQhLp/N3EM11O1nwnIlLB4YAvVp3DXR
 PvWHSOqqjsg4K8iblvrtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/nYRbNVHAV4=:LxwG4I24o6u/Ypp7c2kGy8
 vZ2hfmKTEBB1VgD3CsdkamSIv7LlSB0jSDLgYX0pQoasfDwe1gO/1ooEn6bDKZeiB5UFOJw+n
 xTUPKBUz8rvTsBL74ZzUzk2Cug2QwDK44edGozSHIZVm7VbtyuW6pyXaImnXEDhe+8fj7hsv+
 Tjcc/rECiAia3EKQyjvL7LjbeD0bRAaBM/5Fpuo3m+abkelJK7q4gOT5ZmLWDBAuN0jfkjjKF
 meAQFtsg40OG97IJe8tLybmkGR+ebbG9ufec8ni9yWOlg4w5N5myTCrLxxWWa0J5toq/ABIBu
 bR2m462S+CHzjjiAm9/gq9VVkpU+2DfQUjOxxi+nxGZJIvRHBhhBR7at+PyzHy+WF2B4FC3yp
 FvDjVOxt6scR1Il1iDm0SJ14KuKJcDVHrfyqb+L5WaHjSUdFZCVLg8/RcQBPU3lg782NUWuTw
 yuEPVIDeRNGCGst68XdeYNePeS67KQjPaRXBbi8+2zy8ccF1JHc2SNir3P9L0CE/ghvw2B0dA
 5192dFY6/O3fKQgF147EVF8kk/n5El3yaqZvZ+isQPuFZzVOfdc8Ps0FtiUKUX6Xrp0lWUuzb
 hbXq9yqBbnqrb0SQRFj4zpMMHF422N3XTmm+YwnmqM5qfAy/xTq9xepuNEzCgdI4S7Wh/N3KH
 kMrV42v9QHrZp0K4lGktijrs+1fxzxnNIncymkzO0dvy6zVREap2+mO92cnVZzjQfhkdoU9Q8
 85tAWeuteMN2V6cRYy1VOmgXUvR3Srn6eGoKccUN9jrOOkVPw1nfjlYLuPlCiqwGwgGPXEVr/
 Hy1Ewhry03v8cw06sCWo8VGBxyoYmFwORYG2vB4/XUDcHcdasCX48k+uD94Ts2QJXd11hIvut
 EnLyZQKjCQMZJmN90Jq1Qpxt2aV6uMjewTOO2sLJolnugNZlwl7nYOcQVFxr63UFEAYqsOYZD
 IoU6fqEhRWURSUnKY9e9JPe1H+TrIxAR6PeRAYhQfll3kIme43Zu+TFSR3ZsWAuqwvHw7b2DN
 hOpTDYrkmrDzJRVmEKlb9veMeH0++aD0WpBOaGjfHdX0m0AFcLtR5pvJGI87kd8/BFBTCbXWh
 8fZSmidywWXGdGhyCV/QvdKN4aUzAtfNHFoz47pPlV67Jh6XFadnpwPmy7CrzJ14zKWtHdd79
 xcGKDzL72916sLr7uLxnI/Co6JPcdTfZBRVdl++9ljqsLVdk+B8fraXWQNRvh/UXT9J8PCe0O
 7dDqoq/Y+YLtT5Cr3yGAJHs+/ixHcfIq+5qcQZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 02:07:20PM -0400, Derrick Stolee wrote:
> On 10/23/2019 1:00 PM, Torsten B=F6gershausen wrote:
> > On Fri, Oct 11, 2019 at 09:33:11AM -0400, Derrick Stolee wrote:
> >> Here is today's test coverage report. The usual report format is
> >> available online [1], [2]. The report listed below is a new format
> >> that groups lines by the commit that introduced them [3]. Thanks
> >> Peff for the feedback on that idea.
> >>
> >
> > []
> >>
> >> Torsten B=F6gershausen	ebb8d2c9 mingw: support UNC in git clone file:=
//server/share/repo
> >> connect.c
> >> ebb8d2c9 921) path =3D host - 2; /* include the leading "//" */
> >>
> >
> > I actually looked into this one, and my understanding is that the code=
 path
> > makes only sense for windows and is only tested on Windows in t5500.
> > (Linux/Unix/POSIX don't use UNC path names starting with "//" )
> >
> > How can we avoid those "not covered by test" warnings?
> >
> > One solution could be to use
> >
> > #ifndef has_dos_drive_prefix
> > #define has_dos_drive_prefix(a) 0
> > #endif
> >
> > in git-compat-util.h and hope that the compiler is smart enough
> > to optimize away that line of code.
> >
> > Another way could be to have #ifdefs in connect.c, so that it
> > is clear "this is Windows only".
> >
> > Or make a comment for the "cover report" saying "not covered".
> >
> > Are there any good or better thoughts on this ?
>
> One way to avoid this is to add ignored lines to the test-coverage
> repo [1]. These only work if the exact contents match on a specific
> line number, but can be a way to stop noise in the short-term.
>
> For example, I added a few lines to ignore in commit-graph.c [2],
> but I haven't added ignored lines in a while.
>
> I'm happy to take a PR including the lines you want to ignore, or
> I could take inventory of the lines in the current report before regener=
ating
> a test for -rc1.
>
> Thanks,
> -Stolee
>
> [1] https://github.com/derrickstolee/git-test-coverage
>
> [2] https://github.com/derrickstolee/git-test-coverage/blob/master/ignor=
ed/commit-graph.c

I added a PR as suggested.
One thing, that came into my mind:

Would it make sense to loosen the condition:
921:path =3D host - 2; /* include the leading "//" */

Remove the line number:
host - 2; /* include the leading "//" */

That would assume, that the line is unique within the file,
(can be checked with unique) .
It can give a more robust handling
when lines are added in the file and file numbers change,
but the content is the same.
