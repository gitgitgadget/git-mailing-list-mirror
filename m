Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAC51F858
	for <e@80x24.org>; Thu, 28 Jul 2016 23:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcG1XSA (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 19:18:00 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37763 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcG1XR6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 19:17:58 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so128469235wmg.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 16:17:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+Wt7yk1BL3DneUC1C9ONwUteQvmc0qDm8zmURnWvIxg=;
        b=Hh570X6MQSo3Ryd4SYyZYfZFlwHMZxn1ydYn5IhhkCkV7AzFUbmoDQVdQRgsWuQqpj
         EtRyn8vtH8cmuNnWdbk9XfmZZ30w94r/ojU12/Euy7sTJ01M6s2dg4j/emvNsGqnusye
         GWXALb1px7A2Dbop9kJMdKrcXUNS2mCLTwBXO32pkg94szRVWDWPIXYYJw1ChkQfLnvI
         KhkKSZVDuA9wEHxVkGpHeNL6xdzlWDPBYj4bJrVaXvkZExfHr5yrs/Ha6PY3Ac2sMi4c
         1uDGPI+n50s+QDVlUi/66HrHLa9jxcbcnof6C8eeypOLBsGKJVBeWeNyEVTkmz1effog
         fF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+Wt7yk1BL3DneUC1C9ONwUteQvmc0qDm8zmURnWvIxg=;
        b=NRJDSuM20OjYfi5aivqMtpxUC2x1IUwCxw1M2huR9JFH1jSj+eAyTMytYBoo1GHmHW
         bIrTRS3yzNEz83dSO3IxbXpapfwYMXfDbao8yaN+jujL5JAZGsds+ZLU0dtODM+gDE4T
         r8k20eihhNiIkwNjV7+qtC7/gC62K4xgBx8RWek0jeB+hJ5hlmxCN/MAscad+mJVaPhE
         hYIlRR2ldVXLUyMr1P/kTvuN8/fbjlLaNT3i2jpkPXhKcnu6ctUmjggCLMWQl8k8q42W
         1KL9g69GzSsRmjHW5dDPe7WC6xcwugayCERudGaFt/CAWQr4B3ktJXWx1yzZQ9WLQX60
         NsVA==
X-Gm-Message-State: AEkooutt5FW0nZlxmgS2vtYsHYMtNMeAILPO/21snAsGiHYXTvnuBv3PtbTJzL2Ddtj2tidR8LYFkRIIqcCVtA==
X-Received: by 10.194.149.133 with SMTP id ua5mr34985895wjb.79.1469747876565;
 Thu, 28 Jul 2016 16:17:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.130.74 with HTTP; Thu, 28 Jul 2016 16:17:27 -0700 (PDT)
In-Reply-To: <xmqqzip1pew5.fsf@gitster.mtv.corp.google.com>
References: <CAA787r=FH7Sa4qy2A-dy+wug81ZkqOW2KmSuWBE8_3whmNj1pw@mail.gmail.com>
 <xmqqlh0lsoq6.fsf@gitster.mtv.corp.google.com> <CAA787rmDb+1=4RCscvo1rZWSt=tUQSm5wrFet-=PhRKZcf9x5A@mail.gmail.com>
 <579A5D97.7080708@gmail.com> <CAA787rm+qLig6mzHw0NjNDt-6HF_77FOwmg5dBBOdwbqo3wP6A@mail.gmail.com>
 <xmqqzip1pew5.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Date:	Fri, 29 Jul 2016 01:17:27 +0200
X-Google-Sender-Auth: WG4mxxni907pVftttNom5FGLfdg
Message-ID: <CAA787rnugsnAqK6iH_UZMQRhdpnjJ6NN0x8aaVn7e9GAE88=jQ@mail.gmail.com>
Subject: Re: git-testadd: Execute a command with only the staged changes in
 Git applied
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 29 July 2016 at 00:38, Junio C Hamano <gitster@pobox.com> wrote:
> Øyvind A. Holm <sunny@sunbase.org> writes:
> > Jakub Narębski <jnareb@gmail.com> wrote:
> > > I wonder if using `git worktree` instead of `git clone` (well,
> > > local clone uses hardlinks, so it is not that costly as it looks
> > > like) would be a better solution.
> >
> > That's an interesting idea. Have to test it out. This is the result
> > from the current master in linux.git:
> >
> > With clone:
> > ...
> > With worktree:
> > ...
> >
> > Both tests were run with cold cache ("echo 3
> > >/proc/sys/vm/drop_caches" as root). It seems as there's no
> > >difference, and that git clone is as fast as it can get without
> > >breaking physical laws. And we probably shouldn't do that. :)
>
> I expect that writing the 55k+ files in the working tree would
> dominate the cost.  Local clone would make some hardlinks in .git
> (including ones in .git/object/*) but the cost of that would not be
> too high as long as the repository is well packed; "git worktree"
> would reduce that part of the cost from "git clone", but both incur
> the cost of "checkout", i.e. actually populating the new working tree.
>
> Does the test directory even need to look anything like Git?  In other
> words, would it suffice if it resembled the result of running "git
> archive | tar xf -"?  I suspect that it would not make much
> difference, either, for the same reason, though ;-).

Using git archive saved 1.6 seconds:

  $ mkdir testdir; git archive HEAD | (cd testdir && time tar x)

  real    0m8.881s
  user    0m0.440s
  sys     0m2.740s
  $

But when .git is missing in the subdir, git apply doesn't work. Can't
think of any way to get that to work without involving patch(1) and
friends, and then the binary diffs goes out of the window.

But I'm quite satisfied with 10.4 seconds with cold diskcache and >55K
files. Very impressive, actually.

- Øyvind
