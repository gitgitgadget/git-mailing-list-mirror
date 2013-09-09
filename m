From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 17:59:53 -0500
Message-ID: <CAMP44s0rypiQtmQPAHA6QHvAE6HmOMmYKi1sTpze+dmifLumFw@mail.gmail.com>
References: <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908044329.GA15087@sigill.intra.peff.net>
	<CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
	<20130908052107.GA15610@sigill.intra.peff.net>
	<CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
	<20130908065420.GI14019@sigill.intra.peff.net>
	<CAMP44s3LLHL=oP2PFr4b7VD0dL4yGBOL00O_GWj8eZLrYNM3kg@mail.gmail.com>
	<20130908075046.GL14019@sigill.intra.peff.net>
	<20130909201751.GA14437@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 01:00:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAR6-0003qJ-Az
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 01:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab3IIW74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 18:59:56 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:58432 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab3IIW7z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 18:59:55 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so5453948lab.41
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HBcyNY/VsSRHYULkjslSUOfHDWDZam99D7hvgyAeDNg=;
        b=UD+L7dOrmcsgcHWEn8InuRJdKbHpD286uezLulCkKfgn1BBfdhdXbn7EL9LBKbjwxu
         nnkpbXZKTgwwlMKoy55TR7dtD4Wqt0f4y7PJ68OlIC+iXX/cXAE+5csEtQZ1Q5qznCTj
         0uu7/yNNISysCnA3raAhQZ2fNHkkCFdF43rS5lrdFOVCO8fI9ffS27tdL8MYzqBThnd7
         G9t1TOx0bpP5fHe+cLa6uzNSf4Oh4TujA2Tm0bOnyP+93NIHLD5COOIY4oMzZPn7C3Mh
         mdQzTzqCOUkcR5zMeTnByoh/wTemTxpBzXAiPNxThU69I93GeiCEv9XWcpyRk0a67gCA
         qB6g==
X-Received: by 10.112.57.49 with SMTP id f17mr4413400lbq.26.1378767593999;
 Mon, 09 Sep 2013 15:59:53 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 9 Sep 2013 15:59:53 -0700 (PDT)
In-Reply-To: <20130909201751.GA14437@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234397>

On Mon, Sep 9, 2013 at 3:17 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 08, 2013 at 03:50:46AM -0400, Jeff King wrote:
>
>> > > If you are interested, I can ask the opinion of some of the GitH=
ub
>> > > trainers. They see a lot of new users and have a sense of what k=
inds of
>> > > confusion come up most frequently, what kinds of workflows they =
tend to
>> > > see, etc. Their experience may be biased towards corporate-ish u=
sers,
>> > > though, because those are the people who pay for training.
>> >
>> > Ask. I'm sure they will tell you doing merges by mistake with 'git
>> > pull' is an issue.
>>
>> I've sent an email. I'll post the response when I get it.
>
> Here is what I sent them (I am leaving both my mail and theirs unedit=
ed
> to avoid any "telephone"-like confusion in trying to summarize):
>
>         Right now, running "git pull" will always create a merge, unl=
ess
>         the user has specifically configured it to perform a rebase.
>         Some people find this problematic, because the project may ca=
re
>         about the order of merges (e.g., so that --first-parent
>         traversals do the right thing), and some users may accidental=
ly
>         do "backwards" merges from a main branch into a topic (either
>         because they are clueless, or because they simply forgot).
>
>         There is a proposal being considered to have "git pull" do
>         nothing by default, but instead ask the user to specify wheth=
er
>         to merge or rebase (with the option of setting a config value=
 if
>         you want it to do one by default).
>
>         One concern I have is that new users may run across this
>         relatively early. For example, the first time they "git push"
>         and get a non-fast-forward because somebody else has already
>         pushed, git suggests to run "git pull". At which point they w=
ill
>         have to decide whether to merge or rebase. So what I'd like y=
our
>         opinions on is:
>
>           1. Do new users have trouble with the concept of rebase vs
>              merge?  How would they handle this change of behavior?
>
>           2. Do new users have trouble with rebases in general? There
>              are some complications over doing a normal merge, but I
>              don't know how often they trip people up in practice.
>
> And the responses I got were:
>
>         1. New users definitely have trouble distinguishing between
>         rebase and merge. Even people who have been using Git for a
>         while on a basic level are sometimes confused by this.
>
>         2. Most people we teach=E2=80=94even the ones who have been u=
sing Git
>         for a while=E2=80=94don't know what a rebase is at all. They'=
ve heard of
>         it, but they don't get it. It takes careful explanation to ge=
t
>         the concept across and explain why it is not the same thing a=
s a
>         merge.
>
>         Speaking for myself, about half of the time in the Foundation=
s
>         class I'll explain `pull --rebase` and `branch.autosetuprebas=
e`.
>         (Whether we get to it depends on class interest and ability.)
>         When we do address that topic, we always recommend that
>         rebase-on-pull is the right thing to do, since the merges Git
>         creates are just noise that makes history hard to work with i=
n
>         the ways you have pointed out. (For smart classes, I like to
>         make the analogy of Git to a distributed database, and point =
out
>         how the merge on pull is just Git's mechanism for resolving
>         split-brain writes. I explain that those merges aren't a
>         deficiency in Git; they're just what has to happen by default=
=2E
>         The fact that Git handles split-brain writes so well by itsel=
f
>         is amazing.)
>
>         My input would be to continue to have `pull` merge by default=
=2E
>         Those merges aren't great, but new users won't have any idea =
how
>         to make a decision about them at that point. As it is, it jus=
t
>         works, and it works quite elegantly. Once you start to learn
>         some things, you can tune Git up to work even more elegantly =
by
>         rebasing, but having to understand that concept and make a
>         decision on your first (or second or third or twentieth) pull=
 is
>         probably asking too much.
>
> and:
>
>         Just a few more elements to add:
>
>         * I have been teaching rebase and what it means in _some_ of =
my
>         Git Foundations classes as of late.  But "some" means there a=
re
>         a majority that do not get it.
>
>         * These are the people that get "formal" training on Git.  Wh=
at
>         about all the newbies?  They really won't have a foundation f=
or
>         what these two "flavors" mean.
>
>         * The merge is very different from what Subversion presents a=
s a
>         default.  That's a possible point in the "option's favor."
>
>         * In the end though, the "simplest thing that works" should b=
e
>         the default without a choice.  To me, a choice implies knowle=
dge
>         of the benefits of each option.  I would say that the majorit=
y
>         of our Git students do not, at the beginning of Git usage,
>         understand the difference.

Wall these concerns can be tackled with an error message that says:

"The pull was not fast-forward, please either merge or rebase. If
unsure, run 'git pull --merge'."

--=20
=46elipe Contreras
