From: Stefan Beller <sbeller@google.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 16:18:40 -0700
Message-ID: <CAGZ79kYWPjRLHsG=mfA6Z7pjoYLxGtiGCvXCBcdyL5yyikS=1Q@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
	<CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
	<20160321205043.GA436@sigill.intra.peff.net>
	<CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
	<CAGZ79kabn+pA4Fs2Y4E6Mwy-dKW6SZZ+LZK7_LjhqagcVc-xDg@mail.gmail.com>
	<xmqq1t73lciw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaUY86nUiG9urgDhVGZ5yc1=63nvJGufw7K8TAc3ytmdA@mail.gmail.com>
	<xmqqlh5bjvvf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Adam <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 00:18:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai95y-0007rF-En
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 00:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcCUXSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 19:18:42 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36611 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcCUXSm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 19:18:42 -0400
Received: by mail-io0-f182.google.com with SMTP id 124so75043486iov.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4gCcgO3nJ4sQ0t3JO1+nq7p+RUl51j2wZYHXCgYH/gg=;
        b=QvhlS+Em+Oog5qppR04wWodbPR3rJqQkTm2UaY4F7G3OmGYDpBlIMMr/dszPPaHGzY
         OWhOH17QtMATtyp3YXwbfbYFM1/CfRKUtGYfHX1I1RgddmLzO2l1cD0bizyeWa8t2OaU
         gPMlhEfpA+UnYsnuYoZeQfpe6L6OBGCpXz23s0GVlyjFEqgcxbsnBxCFKUBS+gDHJtj7
         LqCfrIobTCOQCJ/okOrccvpDcS8jl2J/W92sN+CpCTY7b0aRIuRLkJd8M2CXkJP0Plju
         zSIXreAySeCAUitGEr5dIKxeYP8Y5Fs6s+wrTKpwIKxXIMVZIYEqQhU5V1XUYUGyTFvw
         Bygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4gCcgO3nJ4sQ0t3JO1+nq7p+RUl51j2wZYHXCgYH/gg=;
        b=VE5fgZFSk1tBAEZXT8zRHggiGGIh0yhIRf8R0kGoF40no6woNVPbMhPt/Hlbaux040
         udOu9kYWKf+L/PMeFtMglSVSzMpu+SmMcAJuGeghw0Vrbx69aRgpguVnxZ+DkGrv8QzG
         zMmtGvEbm2YSWyAxyN61FXwzyeBv955mlFaRw4FGSvEQfUpu6iDA7h32EnDDjSh4YjxT
         TFCZIFm3jo0Hoke/oTze8IlHuenJn0ZMIHVE7PKdkcLGf0jG/xGUdWOhCi9KJYy1EUbv
         xh9LZmXPk0yW9qcv5MLiuzYnuHnbB+TCnoNKAxfY5kKlGuNb8Swy6Y5cd+Hnv7zxhJ7q
         bbww==
X-Gm-Message-State: AD7BkJK++dVCLIuKgkLMOlGQ3+hx9FzsazIzfFljXKTgShuFWbrogFZPQAAwGkELlOrCdH3+IfCtnGWTVk0X1L9O
X-Received: by 10.107.158.138 with SMTP id h132mr29986527ioe.174.1458602321046;
 Mon, 21 Mar 2016 16:18:41 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 21 Mar 2016 16:18:40 -0700 (PDT)
In-Reply-To: <xmqqlh5bjvvf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289475>

On Mon, Mar 21, 2016 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On> 494398473714dcbedb38b1ac79b531c7384b3bc4 Stefan Beller
>> <sbeller@google.com> 1455150849 -0800 rebase -i (start): checkout
>> origin/master: fast-forward
>>
>> I do understand the "fetch --append origin fast-forward", (I assume
>> they are coming from regular fetches). But the "rebase -i (start):
>> checkout origin/master: fast-forward" seems to have recorded there in
>> error as I never rebased origin/master itself, but only other stuff on
>> top of origin/master.
>> Why would we have such an entry in there?
>
> You tell us--what did you do back then?  ;-)

I wish I knew, my memories are not as good as a disk.
It was Thursday 11th 2016, around 4:30 pm local time.
I would assume I exercised Git the "usual" way as always.

This entry doesn't appear in .git/logs/HEAD.

However
    grep -r "rebase -i (start): checkout origin/master: fast-forward"
-- .git/logs
yields
.git/logs/refs/remotes/origin/master
.git/logs/refs/remotes/origin/nd/exclusion-regression-fix
.git/logs/refs/remotes/origin/ew/connect-verbose
.git/logs/refs/remotes/origin/next
.git/logs/refs/remotes/kernelorg/todo
.git/logs/refs/remotes/kernelorg/master
.git/logs/refs/remotes/kernelorg/next
.git/logs/refs/remotes/kernelorg/next

For example I am pretty sure I never touched
origin/nd/exclusion-regression-fix and
origin/ew/connect-verbose
directly myself (i.e. checking them out or anything. The only way I
got in contact with
them is via "git fetch --all" and the remote side merging these
branches into various
other branches.

>
> It indeed looks strange.  You shouldn't be able to check out a
> remote-tracking branch, so any log for local operation would be in
> HEAD's reflog, but not in remotes' reflog.
>
> I was curious to see what kind of entries I have and I do not seem
> to have anything strange.
>
> $ find .git/logs/refs/remotes/ -type f -print0 |
>   xargs -0 sed -Ee '
>     s/^[0-9a-f]{40} [0-9a-f]{40} [^>]*> [0-9]* [-+][0-9]{4}       //
>   ' |
>   sort -u
> fetch --append l10n: fast-forward
> fetch git-gui: fast-forward
> fetch -v git-svn: fast-forward
> fetch -v paulus: fast-forward
> pull git-svn: fast-forward
> pull git-svn: forced-update
> pull -s subtree paulus: fast-forward
> pull -v git-svn ks/svn-pathnameencoding-4: storing head
> update by push
>
> Puzzled...

doing a similar thing here:
$ find .git/logs/refs/remotes/ -type f -print0 |   xargs -0 cat  |cut
-c134-|sort -u
fetch --append origin: fast-forward
fetch --append origin: forced-update
fetch --append origin: storing head
[omitting lots of other remotes which also have "fetch --append" lines]
rebase -i (start): checkout origin/master: fast-forward
rebase -i (start): checkout origin/master: storing head
update by push

As I have lots of terminals open, I suspect my confusing workflow doesn't
help either, i.e. a normal thing for me is:
term1: git rebase -i origin/master
term1: <resolve merge conflict, edit patches, etc>
term2: git fetch --all
term1: continue on <resolve merge conflict, edit patches, etc>
term1: actually finish the rebase

I tried reproducing this quickly, but I did not succeed. I'll try to
keep an eye on this.

Thanks,
Stefan
