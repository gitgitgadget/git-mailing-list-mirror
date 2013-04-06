From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Fri, 5 Apr 2013 18:45:37 -0600
Message-ID: <CAMP44s10HGpfz=r1m8QRFY4V+rAOkiRaerW1T=vHz2YpbBH6Zg@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
	<CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
	<BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRd-0001b9-Sm
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163120Ab3DFApk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 20:45:40 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35353 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163115Ab3DFApj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Apr 2013 20:45:39 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so4289188lbh.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 17:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=Suj+JTULmQGijc6f7RY/UY2z6HOd1TRYNV6DGc2n9Hg=;
        b=xQuJ5pPlQ9EuKGs1GG1qT3GVRRTFwusJRVrXTPqv/cQOYjzFVCMX3plmV9RIGAv4X6
         onjfaYey04fg+mRPjywO8qyzfah0XhBuOOKmAUS2U8/jNqj2Mbc1Kn97PHrS6PJx8yYo
         JMSKI7njvin4cP7mztYmyC+JSPi9/2uSmz0FA+l4tl1empDHW3Uy4F1zZ0iYnvXmux5R
         lCXKRTbAgWA8hkaaC0H5nLNR+Krg79dw261gtXDszbQy1Bl7zj/M4j5cwEqy8kcS4r/3
         2pcZyljml+7TPayg/LGVoD5k5pvY75Wh5HjwO8jNmknHY3pEFwFlFZGQEPzgjAGBKI+t
         V6eg==
X-Received: by 10.112.156.42 with SMTP id wb10mr7314272lbb.32.1365209137945;
 Fri, 05 Apr 2013 17:45:37 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Fri, 5 Apr 2013 17:45:37 -0700 (PDT)
In-Reply-To: <BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220214>

On Fri, Apr 5, 2013 at 4:30 PM, Max Horn <max@quendi.de> wrote:

> On 04.04.2013, at 08:42, Felipe Contreras wrote:

> Please consider that the willingness of people to collaborate with you in any way is directly related to how you treat them. That includes bug reports. The way you acted towards Jed, who was very calmly and matter-of-factly explaining things, was IMHO completely inappropriate and unacceptable

He did not provide any bug report at all, also, he was not willing to
collaborate, as he clearly stated; he won't work git-hg bridges no
more.

> Indeed, I should augment my list of reasons why people might not want to contribute to remote-hg by one major bullet point: You. And please, don't feel to compelled to tell us that Junio is really the maintainer of remote-hg and not you: Whether this is true or not doesn't matter for this point.

Oh but it does. The only reason my remote-hg managed to land in the
mainline is because I showed it was superior to the other
remote-hg[1], and that there really was no point in trying to salvage
the other code base. Maybe this turns out to be a mistake, and the
other remote-hg manages to improve and surpass my remote-hg, but it
seems rather unlikely at this point.

Similarly, you could *show* that gitifyhg is superior than remote-hg,
why it makes sense to use that instead of trying to improve this code
base, but you don't, because you can't, because it doesn't make sense.

Ultimately this is not about people, this is about the code. A
sensible person that is not emotionally attached to any code, would
simply look at the code, and if what you claim is true (that remote-hg
has many issues), this sensible person would start cherry picking
patches from gitifyhg, send them to the git mailing list explaining
why they make sense. Eventually, remote-hg in git.git would become
essentially gitifyhg (albeit better because it would have received
more review from other git developers). Codewise this would make
sense.

And this sensible person would replace me as the go-to person for
remote-hg. And he would probably have a friendly and wonderful
personality, and you can accept him as your messiah and what not. But
this wouldn't change the fact that codewise this is the best way to
proceed.

But the fact of the matter is that either a) remote-hg is perfectly
fine, or b) this sensible person doesn't exist.

>> , I find it
>> annoying that you claim to know what is important for users, as if
>> somehow knowing that gitifyhg doesn't work with the user's version of
>> mercurial (e.g. 1.8) is better than remote-hg's situation; where it
>> *actually works*, but it's not mentioned. Yeah, mentioning that it
>> doesn't work is better than working, right.
>
> I'll leave it to everybody to read what you wrote there, and contrast it with the following, and draw their own conclusions...

Keep in mind that it's not me the one that claims remote-hg is
superior because it supports 1.8, as you seem try to portray. Rather,
it's _you_ the one that claims superiority because gitifyhg *mentions*
support until 1.9 (which remote-hg also supports).

It's not important who supports the most ancient version of mercurial
that nobody uses anyway, what is important is that *mentioning* or not
mentioning which ancient version of mercurial is supported doesn't
make one project superior to the other.

But perhaps this point is too subtle for you to understand, so there:
https://github.com/felipec/git/wiki/Git-remote-hg

Now it's mentioned that remote-hg too, supports up to version 1.9. Can
we agree now, that nobody has any advantage, either on version
support, or the mentioning of version support?

> Indeed, util.url was only added in 1.9.3. OK, let's work around that. Then local clones work. But of course in reality, most users will want to interact with a remote repository. But that's still broken:

Fixed:
https://github.com/felipec/git/commit/df0ed732b56c6c7910cc76f3e930229816e27117

And it was _you_ the one that sent the commit that broke it to the git
mailing list to be pushed.

> Right, clone() changed. And some more stuff. See <https://github.com/fingolfin/gitifyhg/commit/d3d37a7a853f3c8a1907bdaf933844128d5e7d81>.

Indeed, that might be useful, but that doesn't mean remote-hg doesn't
work with 1.8; it works perfectly fine for local repositories, and all
the tests pass.

> There also was a good reason why I stopped at that point, but I don't remember the details right now. And quite frankly, I have zero incentive to even try to remember. But anyway, I don't think it's that useful to add support for 1.8, too, since one can't get back much further anyway. And upgrading to a newer Mercurial is (a) quite easy (even if you don't have root, just install it into $HOME), and (b) using a newer Mercurial version is a good idea for other reasons, too.

If supporting 1.8 is not useful because most people have newer
versions, then mentioning support for 1.9 doesn't give any advantage.
Thanks for wasting our time on something nobody cares anyway.

>>> BTW, I just pulled you hg-next branch, and run "make test" in that. The tests in test-hg-hg-git.sh actually all failed (with remote-hg). Do I need to do something special for those to work?
>>
>> No, they should just work. Perhaps you have an old version of hg-git
>> (I have v0.4). You can check the errors with
>> GIT_TEST_OPTS="--verbose".
>
> Yup, that was it, thanks. It would be kinda nice if the test code could check for suitable versions of mercurial and hg-git (and python, I guess) and warn the user if necessary.

Yes, but how many people run these tests? And how many people have
hg-git in the first place? And how many people care about
test-hg-hg-git? I'll guess not so many, so I'm not really looking
forward to see what are the issues with older versions of hg-git.

> As for your complaints about not getting proper credit in the gitifyhg README etc.: I agree that it is very much lacking in this regard, and will work towards rectifying this (indeed, I already suggested this to the other gitifyhg devs).

Thanks.

> I'll also look into using sharness for gitifyhg test (which is based on the git test suite), as I also don't like the current test setup in gitifyhg, and indeed, the other gitifyhg devs agree. This would also make it easier to share and compare tests between remote-hg and gitifyhg if desired.

That would be really good.

> Jed and me already explained why e.g. forced push makes remote-hg an absolute no-go for me and several other people.

% git config remote-hg.force-push false

Problem solved. You don't need to work on a another project to avoid this.

> Whether you accept this or not is irrelevant -- it sadly won't change the reality I and others have to deal with at work and elsewhere.

The reality is you lack imagination. I've yet to see a single argument
that shows a problem with using a dedicated branch to push bookmarks.

> I won't reply to all the other stuff you wrote, as it just causes too much bile to raise up re-reading it, and I am not sure I could manage to reply in an even remotely neutral tone. So I'll refrain from attempting, as I am not interested in a fight between the two projects, or anybody for that matter. Nor do I see this as a competition where the "best" wins -- if somebody prefers remote-hg over gitifyhg, or the other way around, I don't care much, as long as at least one of the tools satisfy their needs.
>
> Rather, all *I* am interested is using git to access a couple hg repositories that I absolutely must access. And helping several friend and colleagues who are in the precise same situation.

So you are unable to argue why is it that gitifyhg is necessary, or
good. I take this as evidence that you are too emotionally invested to
accept the possibility that there's no good reason for the existence
of gitifyhg.

gitifyhg is not technically, or in any way, superior to remote-hg. You
should just give it up, and try to move as much code as possible to
remote-hg (is there any that will be useful?), and perhaps maintain a
branch to make remote-hg behave as you want (I already provided an
example), but on top of remote-hg. You can have your own github repo,
with your own wiki, and your own releases as you have it now. Then it
would be easier to share code, and if gitifyhg turns out to be truly
superior, it would be easier to simply merge those patches that enable
gitifyhg behavior, which you claim make all the difference in the
world.

It would be great if we could all work together in remote-hg, but
given the fact that at no point in time did you consider to "fix"
remote-hg, and that you spend considerable amounts of time claiming
that gitifyhg is superior, specially in remote-hg's own bug tracker,
rather than sending patches for remote-hg, which would prove your
point much more easily (if it was correct), I don't think you are
allowing for that possibility.

Cheers.

[1] https://github.com/msysgit/msysgit/wiki/Guide-to-git-remote-hg

-- 
Felipe Contreras
