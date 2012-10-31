From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 16:39:35 +0100
Message-ID: <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTaOd-0003Wa-VT
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545Ab2JaPji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 11:39:38 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44865 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757938Ab2JaPjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 11:39:36 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1538447obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pd34WISOqrl37kY5KWFN6//j/6Ar/xJEsRGNn7fidVg=;
        b=MuSwtShxWcHSfnMZ+6czjvh3Fa0PnfJdy2tP5yrwriQtT28VimvyVysJ5967e6Pgqj
         d5nCMtZdRDgbbkh/UvW52TjT15IoKhsmVx41niLskgr/d0sUc9iC1k4McxPkIoVuhnwf
         YeLLJ1lTxJqed3e46oQ3Qc73tT0jcGJYz/j4KL4t+ez+dHgHLFX6pWLPxi5uf5XPJRHa
         zRtz67MwkCyMBzx14/t/Q1MHq2YiKJmrY/gAcfgIo/swzKHQH1FBl8Sm8d/4VHFSa64Q
         3qH3e0um95PvtBbthOvShNoys5khvhBeju2RarHxz8hIRQxTuON+dlqGcpD6MnxqlBL1
         Rbjw==
Received: by 10.60.1.164 with SMTP id 4mr14646138oen.96.1351697975790; Wed, 31
 Oct 2012 08:39:35 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 08:39:35 -0700 (PDT)
In-Reply-To: <5090EFCA.7070606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208834>

Hi,

On Wed, Oct 31, 2012 at 10:30 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> [quotes heavily cut down by me]
> Felipe Contreras venit, vidit, dixit 30.10.2012 21:15:

>> On Tue, Oct 30, 2012 at 8:33 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> On Tue, 30 Oct 2012, Felipe Contreras wrote:
>>>
>>>> But you mentioned something about cooperation, and I've yet to see how
>>>> is it that you are planning to cooperate. If you say you don't have time
>>>> to spend on this, I don't see why I should worry about testing this
>>>> series of patches.
>>>
>>> It has been mentioned before that the communication style including all
>>> these snarky and nasty comments is not helpful.
>>
>
> For the record, Johannes is not the only one being kept from looking at
> this series (further) by the tone of this discussion. Per hominem
> attacks are neither professional nor helpful. We prefer to discuss code
> here, just code.

Show me a "per hominem" attack coming from me. I never threw any such attacks.

Johannes is the one that complained about it, and that's the very
definition of *not* concentrating on the code, and discussing other
topics.

> The way other comment threads on this series
> unfolded made me choose to be a mere by-stander again.

This is precisely ad hominem; you are ignoring the code, not because
of the code, because of the person. This is as ad hominem as it gets.

As for how "professional or helpful" that is, it's debatable. The
Linux kernel mailing list is known for being harsh, and yet, they
manage to get more things done than any other. They truly look at the
code, just the code, they don't consider criticism to the code
personally (nobody should), nor linger on any personal beefs that only
distract from the end goal.

>>> and I've yet to see how is it that you are planning to cooperate.
>>
>> This is also a fact. You haven't provided a branch, you haven't reviewed
>> my implementation, you haven't tried it. You mentioned something about
>
> This does not become true through iteration. Max' recent post

Thee key word is _Max's_, not Johannes'. I never said nobody did, I
said Johannes didn't.

> 'On
> git-remote-hg (the "native" one)' [1] points at the msysgit wiki on
> remote-hg [2] and his remote-hg branch [3], which is based on and points
> at Sverre's original branch [4] and mine [5] which is [4] being
> regularly rebased on origin/next. The msysgit devel branch is in heavy
> use; I don't use mine often but run the test suite on every rebase
> before pushing out.

This is good information, why Johannes didn't provide it? It was easy
to copy-paste an URL. Lets suppose I did try this branch, and I come
up with a list of problems, Johannes could easily say; "I'm not
responsible for that code, I don't know what bugs could have been on
the rebase". Or something along those lines, which is potentially the
reason he didn't provide that.

But enough about Johannes, if I go on to Max's branch and give a try
to the code, make a list of issues, run my extensive tests and so on,
and make a report of the status, and a comparison with my code. Would
that make it more likely for you to stop being a by-stander?

Didn't think so. The truth of the matter is that it doesn't matter
what I do code-wise.

> If the issues that Sverre and Dscho tried to address with their git.git
> core (non-helper) patches turn out to be non-issues then I assume
> everyone will be happy, including them. You and they have thought a lot
> about these things and the way hg-git sync can work. There seems to be
> diagreement about the way fast-export/the remote helpers communicate
> which revs and refs that are to be synced and updated. This is not
> hg-specific, and I suggest to try and clarify that issue as thoroughly
> and calmly as possible. Everyone will benefit, and it will make clearer
> which tests are appropriate, and accordingly which fixes fix real problems.

I believe there is no disagreement any more, AFAICS my patches have
been accepted by Sverre and Jonathan... the commit messages is another
story. Johannes chose not to collaborate.

> Orthogonal to this, it seems that all hg-git interfaces could take
> advantage of a "git heads" feature if we resurrect the old ideas (can't
> find the thread right now).

Never heard of that.

You accused me of ad hominem, now I ask you; can you ignore any
personal biases and look at the code, and only at the code?

And finally, what do more do you expect me to do? About the code, and
only the code.

Cheers.

--
Felipe Contreras
