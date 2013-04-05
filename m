From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Sat, 6 Apr 2013 00:30:51 +0200
Message-ID: <BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com> <20130402200948.GF2222@serenity.lan> <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de> <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com> <EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de> <CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWQq-0001b9-H4
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162974Ab3DEWa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 18:30:59 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:58104 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1162778Ab3DEWa6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2013 18:30:58 -0400
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.27]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1UOF9m-0001aj-F6; Sat, 06 Apr 2013 00:30:50 +0200
In-Reply-To: <CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1365201058;963898bd;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220228>

<RANT>
While I am not really interested in exchanging any further emails or any other form of communication with Felipe, as I find his vitriolic style of communication unbearable, I feel compelled to reply to a few points. I'll probably regret this... anyway, I promise this will be my last mail in this thread. Even though I fully expect to receive a barrage of hostile and aggressive replies by Felipe. So be it, /dev/null has plenty space left.
</RANT>

OK, I'll try to keep a professional tone from now on :-).


On 04.04.2013, at 08:42, Felipe Contreras wrote:

[...]

>>>> * The gitifyhg test suite is run after each push on Travis CI against several git / mercurial combinations [4].
>>>> In particular, unlike all other remote-hg implementations I know, we explicitly promise (and test) compatibility with a specific range of Mercurial versions (not just the one the dev happens to have installed right now). This has been a frequent issue for me with the msysgit remote-hg
>>> 
>>> I've personally checked against multiple versions of Mercurial. It's
>>> possible that some error might slip by, but it would get quickly
>>> noticed.
>> 
>> Really? This sounds close to some people who say things like "I don't need a test suite, I personally run some tests every now and then on my machine."
> 
> Do you see any compatibility issues reported in the git mailing list,
> or my github[1]? No? KTHXBYE. There _were_ compatibility issues, and
> those got reported, and fixed, not any more.

Please consider that the willingness of people to collaborate with you in any way is directly related to how you treat them. That includes bug reports. The way you acted towards Jed, who was very calmly and matter-of-factly explaining things, was IMHO completely inappropriate and unacceptable. Indeed, I should augment my list of reasons why people might not want to contribute to remote-hg by one major bullet point: You. And please, don't feel to compelled to tell us that Junio is really the maintainer of remote-hg and not you: Whether this is true or not doesn't matter for this point.


> remote-hg certainly works on versions older than 1.9, again

That's plain wrong. Indeed, remote-hg is using hg interfaces that were only introduced in 1.9. As such, I would be quite surprised if remote-hg worked with older hg versions, but I don't see why I should bother to test... Hmm, wait, I see a reason:

> , I find it
> annoying that you claim to know what is important for users, as if
> somehow knowing that gitifyhg doesn't work with the user's version of
> mercurial (e.g. 1.8) is better than remote-hg's situation; where it
> *actually works*, but it's not mentioned. Yeah, mentioning that it
> doesn't work is better than working, right.

I'll leave it to everybody to read what you wrote there, and contrast it with the following, and draw their own conclusions...

The reason why I did not write what exactly is wrong with remote-hg in hg 1.8 and older is that it is so obvious that I didn't think anybody would need handholding to verify it or find out the details :-). But since you "asked" for it:


$ hg --version
Mercurial Distributed SCM (version 1.8.4)
(see http://mercurial.selenic.com for more information)

Copyright (C) 2005-2011 Matt Mackall and others
This is free software; see the source for copying conditions. There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
$ git clone hg::foobar/ foobar.git
Cloning into 'foobar.git'...
Traceback (most recent call last):
  File "/Users/mhorn/bin/git-remote-hg", line 846, in <module>
    sys.exit(main(sys.argv))
  File "/Users/mhorn/bin/git-remote-hg", line 819, in main
    fix_path(alias, peer or repo, url)
  File "/Users/mhorn/bin/git-remote-hg", line 765, in fix_path
    repo_url = util.url(repo.url())
AttributeError: 'module' object has no attribute 'url'

Indeed, util.url was only added in 1.9.3. OK, let's work around that. Then local clones work. But of course in reality, most users will want to interact with a remote repository. But that's still broken:

$ git clone hg::ssh://hg@bitbucket.org/fingolfin/test-gitifyhg
Cloning into 'test-gitifyhg'...
Traceback (most recent call last):
  File "/Users/mhorn/bin/git-remote-hg", line 1138, in <module>
    sys.exit(main(sys.argv))
  File "/Users/mhorn/bin/git-remote-hg", line 1107, in main
    repo = get_repo(url, alias)
  File "/Users/mhorn/bin/git-remote-hg", line 284, in get_repo
    peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
TypeError: clone() got multiple values for keyword argument 'pull'


Right, clone() changed. And some more stuff. See <https://github.com/fingolfin/gitifyhg/commit/d3d37a7a853f3c8a1907bdaf933844128d5e7d81>. 

There also was a good reason why I stopped at that point, but I don't remember the details right now. And quite frankly, I have zero incentive to even try to remember. But anyway, I don't think it's that useful to add support for 1.8, too, since one can't get back much further anyway. And upgrading to a newer Mercurial is (a) quite easy (even if you don't have root, just install it into $HOME), and (b) using a newer Mercurial version is a good idea for other reasons, too.

[...]

> 
>>> Also, unlike remote-hg, which basically passes all the tests of
>>> gitifyhg, gitifyhg barely passes any tests of remote-hg (three).
>> 
>> Heh, bad, but OK (as I said, my message was based on an older version of remote-hg, and actually also on an older gitifyhg). Thank you for the report, I'll look into it as soon as I can (or somebody else might).
>> 
>> BTW, I just pulled you hg-next branch, and run "make test" in that. The tests in test-hg-hg-git.sh actually all failed (with remote-hg). Do I need to do something special for those to work?
> 
> No, they should just work. Perhaps you have an old version of hg-git
> (I have v0.4). You can check the errors with
> GIT_TEST_OPTS="--verbose".

Yup, that was it, thanks. It would be kinda nice if the test code could check for suitable versions of mercurial and hg-git (and python, I guess) and warn the user if necessary.


As for your complaints about not getting proper credit in the gitifyhg README etc.: I agree that it is very much lacking in this regard, and will work towards rectifying this (indeed, I already suggested this to the other gitifyhg devs).

I'll also look into using sharness for gitifyhg test (which is based on the git test suite), as I also don't like the current test setup in gitifyhg, and indeed, the other gitifyhg devs agree. This would also make it easier to share and compare tests between remote-hg and gitifyhg if desired.

I won't reply to all the other stuff you wrote, as it just causes too much bile to raise up re-reading it, and I am not sure I could manage to reply in an even remotely neutral tone. So I'll refrain from attempting, as I am not interested in a fight between the two projects, or anybody for that matter. Nor do I see this as a competition where the "best" wins -- if somebody prefers remote-hg over gitifyhg, or the other way around, I don't care much, as long as at least one of the tools satisfy their needs. 

Rather, all *I* am interested is using git to access a couple hg repositories that I absolutely must access. And helping several friend and colleagues who are in the precise same situation. Well, Jed and me already explained why e.g. forced push makes remote-hg an absolute no-go for me and several other people. Whether you accept this or not is irrelevant -- it sadly won't change the reality I and others have to deal with at work and elsewhere.


Cheers,
Max