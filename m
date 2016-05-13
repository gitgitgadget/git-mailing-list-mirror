From: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
Subject: Re: bug report
Date: Fri, 13 May 2016 20:05:16 +0800
Message-ID: <CABKuJ_SwJhjZCgL3KkHA7p2QfStW-g5oEi8qhNGXoNb721Ynhg@mail.gmail.com>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
	<CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
	<CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
	<CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
	<CABKuJ_SEK-t93sCmj6aFSAbk8muX_ocQx6ZQZV3ZrNmvVmvDQA@mail.gmail.com>
	<CAFZEwPMe2W2R2GghMnyQ4BLyvm00oHEweNSZYrqn+=9BhSazvw@mail.gmail.com>
	<CABKuJ_RrOhT+FVb9PNKhBs1ATJmLWhD757oyx+AvrCGNvT1nFw@mail.gmail.com>
	<20160513081014.GA18307@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 13 14:05:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1BqS-0004og-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 14:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbcEMMFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 08:05:22 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34016 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcEMMFR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 08:05:17 -0400
Received: by mail-oi0-f45.google.com with SMTP id k142so166940882oib.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lT7tka7knO7PEvoLFv8CvlORypi59VuONTmyKXgGhcw=;
        b=HiZt7fnHby51JCRRey1degPQIhRAIBA4ddvG991ciIXc/cPe72XZPkykw6yEPXkeqJ
         NbNXSBINpjBtyGeiGfN9Y0kiLhoNFUjB2lLg8snnFvErEWHp2Hs3un0L+FxqRNR0HSm9
         IeF8+D9d9r5JGXqmHrJ7Ukyotoj60tJvYsnTSIACWImC6HCjf98hclpyXjm2AKbVt90x
         yiUppLAFWU2Zm1xi4fyDIRQs9rpRBQBDBU55Xqok9wKDaTFCNLEJstlGDa/lF6LhYmDX
         j0Q7Xq/Flbu/qwEUT4xlNdSed5GeviaZg6PBFOOCq9Z6HaCxYkDWJrHLQPJ/3Gjw2Gnf
         5tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lT7tka7knO7PEvoLFv8CvlORypi59VuONTmyKXgGhcw=;
        b=Zd6mmGUMxagO0rmD+Wk09nbxZ+OypbvwHJ3rk9NjeAt7cUI8cc9RpPsKvwA2KGbkYX
         1FhzSZB9EHx5WS29Fp74EcrXt7y3m25/5UvC8nzlFGJESSBGmnAu3cTYA9cqw2p5dVjD
         q9mHD7nk1Yl8H2E7DWHJGGf+2fgxYR4IRAVtUo/D3ubQRUW7M23xzrTMUMXJrdUqBNtg
         3NWdqcHby0BHaRy3mAJFREfc4mtAF1XHheJ0CPonhVkg/PTmXI8n0B6E2++vCk8V+c19
         yCnvzsZ6tJbKHnys1sqrUDdVbCmyEJVCS1pRnBs9ujjzh2FuYSov7kL1XVnkkeDnYAfo
         ZYBQ==
X-Gm-Message-State: AOPr4FWpz2Yu1BR2emSOtpRVR7gEDSgaDzjIyFkAa3j9U+25J+1eMF/bJtXyC99ZnJ424JPJLCyPNIY+Fcg4Hg==
X-Received: by 10.157.7.66 with SMTP id 60mr7998170ote.187.1463141116368; Fri,
 13 May 2016 05:05:16 -0700 (PDT)
Received: by 10.202.46.8 with HTTP; Fri, 13 May 2016 05:05:16 -0700 (PDT)
In-Reply-To: <20160513081014.GA18307@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294526>

Thanks for your explanation

>
> The moment where I think you'd like to be notified is when we skipped
> doing anything with patch 1. You'd prefer it to say "woah, the other
> side of the rebase did the same thing as us".
Actually this is the problem where I want to be notified.

> But rebase does not do that by default, because the intent of rebase is
> that you are rebasing your work on an upstream which might be accepting
> part of your work as patches. So it is a feature that rebase says
> "already applied upstream -- let's ignore this one".
>
> I don't think there is a way to ask rebase not to ignore such
> already-applied patches. But I'm not sure if there should be, for two
> reasons:
>
>   1. You should consider just using "git merge" to merge the two
>      branches. That preserves more information about what actually
>      happened, and would find a conflict in a case like this.
>
>   2. Even with merging, you cannot assume that the end result is sane.
>      In your example, there is a textual conflict. But you can easily
>      come up with other examples where a merge is textually sound, but
>      has some semantic conflict (e.g., you update the signature of a
>      function but a colleague adds another call to it using the old
>      signature).
>
>      You have to examine and test the results of merges for sanity. And
>      likewise with rebases.
>
> -Peff
>
> [1] Actually, rebase does not even try to replay the first patch. When
>     it generates the list of commits, it ignores any whose "patch-id" is
>     the same as a commit on the other side. But the end effect is the
>     same.
Your explanation looks reasonable to me.

Thanks a lot for your time and patience. And @Pranit Bauva too.

By the way, many thanks for maintaining this outstanding software Git.


-- 
Benchao Li
School of Electronics Engineering and Computer Science, Peking University
Tel:+86-15650713730
Email: libenchao@gmail.com; libenchao@pku.edu.cn
