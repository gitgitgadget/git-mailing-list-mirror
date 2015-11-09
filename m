From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 10:40:25 -0800
Message-ID: <CAGZ79kanRZDCCoN2A+Xb=OseXc1WfF23VNV-aE7s6q1Rr4zccg@mail.gmail.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
	<20151104064021.GB16605@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
	<20151109155538.GC27224@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
	<20151109165343.GA29179@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
	<CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Victor Leschuk <vleschuk@accesssoftek.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvrMo-00056L-CU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 19:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbbKISk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 13:40:27 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34161 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbKISk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 13:40:26 -0500
Received: by ykfs79 with SMTP id s79so51691615ykf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 10:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dp+ppRTh4aB91mvtAzx/v4KIv1YxXWlCIPRhg1X/4FY=;
        b=aoKRa+2VfTaTZjCrQSx4mf2oep8XM++u0HlB2l75vPcKVyZ1IGIB9b0fOoHzmjaJ8b
         ial9p8bN1fr/toa6iZDUJlcnwrGruxbQMvBj5tTaiKGV6dzEMZkQlLK2t1oxs/pjO8J3
         77XWhTIe2BQHHVejtBQwgyW8XyDCIGX4Usm88+KSq/H1/OnkcD587yz8D2mi5inAEsi2
         KL3rlWvhXX1KnD2tEgW9aUyys1Fa0+XxbuQZrjHXf+fvcrWuVgdBc2uFZos2StgOA/W/
         6cbtwjzXoN/g2G/eXzRoGoiazP/bR2Gw9ZfE4KS/A2CCCdkg5b8TgSu0DCKYuhWAPvZY
         EFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Dp+ppRTh4aB91mvtAzx/v4KIv1YxXWlCIPRhg1X/4FY=;
        b=aMIBwSihPkDtJg4+VI437Trukc9mkeYfcZxfMQ2n1vojZ5Wnff/SauRytj7kmtHrtP
         rmEGvk/4vLGPTRDsxsk0lpbE03lBZ5T4fVS0bBA8onOlWAw0kSCMCJLAwaCNE83mw+WS
         CMClylUTeyLkNrb7ZLAe5mrI3FmajYfatgpVfqpn53v68GuCR3xZZdAKTLVq+fMyhYv/
         i7l1COAdjbdi2KiXlMB2mlEH1lQNY92INSZInb1RBD0i2C5+UNCc5tma9eXPufUmDAhN
         PIpx86BI6zZJR1EBiImERtAivvR4VOq69y8ea98Bo3xxSa18rzXiW2ZqzbVCrmI+r9jI
         lJYg==
X-Gm-Message-State: ALoCoQlUaieQ25gozvDSBks+krlNJLWEkVlXJiCJRwvt6MZNW8x4UFJiChoYK8oLmgKWG3Rr9Q75
X-Received: by 10.129.78.67 with SMTP id c64mr29494929ywb.320.1447094425254;
 Mon, 09 Nov 2015 10:40:25 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 9 Nov 2015 10:40:25 -0800 (PST)
In-Reply-To: <CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281075>

On Mon, Nov 9, 2015 at 9:55 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So stop with the "online_cpus()" stuff. And don't base your benchmarks
> purely on the CPU-bound case. Because the CPU-bound case is the case
> that is already generally so good that few people will care all *that*
> deeply.
>
> Many of the things git does are not for "best-case" behavior, but to
> avoid bad "worst-case" situations. Look at things like the index
> preloading (also threaded). The big win there is - again - when the
> stat() calls may need IO. Sure, it can help for CPU use too, but
> especially on Linux, cached "stat()" calls are really quite cheap. The
> big upside is, again, in situations like git repositories over NFS.
>
> In the CPU-intensive case, the threading might make things go from a
> couple of seconds to half a second. Big deal. You're not getting up to
> get a coffee in either case.

Chiming in here as I have another series in flight doing parallelism.
(Submodules done in parallel including fetching, cloning, checking out)

online_cpus() seems to be one of the easiest ballpark estimates for
the power of a system.

So what I would have liked to use would be some kind of

  parallel_expect_bottleneck(enum kinds);

with kinds being one of (FS, NETWORK, CPU, MEMORY?)
to get an estimate 'good' number to use.
