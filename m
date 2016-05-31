From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: git add without whitespace
Date: Tue, 31 May 2016 10:03:01 -0500
Message-ID: <CAHd499AreoaqfCVGi6XiatiWQMzf+KqL=a+f3D8u53dNkg0tiQ@mail.gmail.com>
References: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
	<xmqqlh2r8ixu.fsf@gitster.mtv.corp.google.com>
	<CAHd499Drdt6GoScdksNNWLrsvG3Dex7fTYNhatL-qboCPW5RZQ@mail.gmail.com>
	<xmqq8tyr8aur.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 17:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lCX-0002cS-2u
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbcEaPDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:03:06 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36275 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbcEaPDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:03:03 -0400
Received: by mail-vk0-f46.google.com with SMTP id a6so56186928vkg.3
        for <git@vger.kernel.org>; Tue, 31 May 2016 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=R763Q14kpNIq6VW7VQaUYyIdMPB0NOvhg/tnqnIH0dE=;
        b=huTqke0P7TIJtSSJ0NF26MZNfsd09NVMnVNqapa9dU7BwlPZzsKFzsRZlrg3MBNh9A
         NUI/wkFEvfa/I7Sck+useTBR99LUJkVd8Mh9+o9L2SbJtab1DH4CE6Fb5UiSRpCsBTis
         Nb0w6n8/1QUfyHoPHikKC2Y3XtdPZqJti/3lyhkb/1DTka8IaVY5ZH/RkPFsntTF+S0O
         7GsgK8EdYF7nHoMi5/0MTciam3k8xEdUAGmJl/etqlkTXIGRm5fESm3H/j2EMZDpyYGo
         tMswy10tuXxElobS5zJxtyNKhYIi/cTFY4vRE0uhpEWrxCuON3jQujdRK5+/xlb6Ecf5
         CSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=R763Q14kpNIq6VW7VQaUYyIdMPB0NOvhg/tnqnIH0dE=;
        b=Kbb/SYjTuIXW5xR/MZfnExDMWZPr0hWNVrVVK+I3iKMkZY3ux4q2R5vpqN811oKEBs
         5ensqpo20GSHrvtwekpcJ8a7utXBEDbZKNPyo4N6/v3t4THwHdFy0LEU442Te7qnxGEC
         4xzOA9p2nQ1YmS4YEojGBh6UZh0KpiFrXAf/5/GOQUO6mZnRaBcHO+iZ6kg8PyrpvPbq
         N6jBxpZJF+1ewJED7HTH9KXd0YFlZbUwWuQLzz/QJjtInuB2v0daQSjm+Fg49h7ivCP9
         diudbyY6Lu86aEmBtQHfnOQl76/CUhATYl4m4OFfhrz2eB1OUQT6cNhy8dxnK9LWd0zA
         CTeA==
X-Gm-Message-State: ALyK8tL2ti9vfeb+TnK3+jxKltAbRQWxnDCPaPwTZ9xkoLdM/0/9RQ4LbTT/OPrOru5KRRqiozdRGwTGT5qUMA==
X-Received: by 10.31.181.83 with SMTP id e80mr15250913vkf.26.1464706981618;
 Tue, 31 May 2016 08:03:01 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.34.134 with HTTP; Tue, 31 May 2016 08:03:01 -0700 (PDT)
In-Reply-To: <xmqq8tyr8aur.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: P294mEWkjpPahKFhBvZ66HCnNnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295978>

On Mon, May 30, 2016 at 5:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> I like your solution better than mine because it utilizes the rules
>> defined in .gitattributes.
>
> A difference that may be more important is that I do not do
> generation of a patch or application of it without ignoring
> whitespaces with things like -w and --ignore-whitespace.  That way,
> if my edit is a correction of existing whitespace breakage (e.g. I
> noticed a line that is indented by 8 spaces, and I corrected it by
> replacing them with one tab), that is shown as a change by "diff"
> and kept in the result.  I suspect that your "diff -w | apply --ignore"
> will ignore that manual fix?
>
>> What does the checkout at the end do? That part confuses me (granted
>> I'm not well-versed with bash script).
>
> I correct whitespace-broken updates the user (i.e. I) made in her
> working tree file by adding a corrected version to the index, and
> then I checkout the result out of the index to the working tree.
>
> That corrects the breakage in both the index and the working tree,
> so that my further edit to the file will start from a ws-corrected
> version.

Ah, I think I get it now. I was confused, you and I are apparently
trying to accomplish two different things.

My alias stages changes EXCEPT whitespace fixes. In this case, I've
already made the whitespace corrections (by hand) in the working tree.
I want to stage the changes EXCEPT whitespace. This will allow me to
do 1 commit without whitespace, and another with just the whitespace.
So yes, my patch is deliberately ignoring whitespace because I do not
want it in the index for the first commit.

Yours seems to take exactly what is in the working tree and make
further modifications to it as it is added to the index. That is, to
correct whitespace errors as defined by the gitattributes file.

When I tested your alias, all changes in my working tree were added to
the index, where I expected the index to contain everything except
whitespace modifications.

But honestly your solution is a little better, even if it requires me
to change my process, because:
- You don't depend on external tooling to correct whitespace
- Splitting whitespace & real changes to two commits is probably
superfluous; my original goal was to make diffing the actual changes
easier, but since 'git diff -w' exists this is moot.

So I guess it's not bad practice to mix whitespace changes in with
real diffs, given the flexibility of Git (in previous VCS such as Git
and perforce I didn't do it this way). I have a similar habitual
carry-over from SVN where I do file moves/renames in separate commits
before I modify file contents. Again with Git, probably not as
necessary to do this.
