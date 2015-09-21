From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Mon, 21 Sep 2015 09:31:51 +0200
Message-ID: <55FFB267.3040106@drmicha.warpmail.net>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
 <CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
 <vpqeghviqu1.fsf@anie.imag.fr>
 <CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
 <vpqlhc3h7e7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdvZw-0003K3-2W
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbbIUHbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:31:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51216 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752625AbbIUHby (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 03:31:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9F93620AB0
	for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:31:53 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 21 Sep 2015 03:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=XrAaBYUBVapc5naZkZJqqTpMXq4=; b=RRkJi5
	EfTdk0wgxXd5lF+IPHkiYYuicVN13PAL3c7e8UPk2AdkFIEvXCznlXaEsGm0/i8Q
	12VDkO1z5T7HxPSBJ8H2VESek4bBZfZpSXIn3Gp6mamHy/I3mjK0u+mA2EgEur4D
	Gc4kFYt90fsxdBdqCP0M3MMzDLKDhMu/FE9rE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=XrAaBYUBVapc5na
	ZkZJqqTpMXq4=; b=Z009x7hxLgLahX+DEHWbeA9KaWh8DgEv0J/TYW90gWpi8TU
	IJ2UnZ5JofNXtcm5WDoCdOBvbrIeVbUG0/IJP2XFN+1sCQ92y4y6jRm/uY+81b0o
	mRlnQWElHiqcs5vvcJ3VK+dxtTwMKyy6EQFlIo4uQIRhWfPaDsNlJJtTM3VI=
X-Sasl-enc: 09nzAJDoVswSdq5JF6InzYQfBpyv8h5ZVzjGlMsTVlaq 1442820713
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CF80E68015E;
	Mon, 21 Sep 2015 03:31:52 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <vpqlhc3h7e7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278281>

Matthieu Moy venit, vidit, dixit 18.09.2015 21:09:
> Stefan Beller <sbeller@google.com> writes:
> 
>> On Fri, Sep 18, 2015 at 10:23 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>>
>>>> On Fri, Sep 18, 2015 at 9:59 AM, Matthieu Moy
>>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>>> I'm getting it even if there's a tag and/or a branch pointing to the
>>>>> same commit.
>>>>>
>>>>> Any idea what's going on?
>>>>
>>>> Any chance you accidentally made a branch or tag named HEAD?
>>>
>>> Nice try ;-), but no:
>>
>> I was playing around with origin/master and origin/pu and
>> I cannot reproduce this bug.
> 
> I investigated a bit more. The root of the problem is "git checkout
> --detach" and the reflog. Here's a reproduction script:
> 
> 
> rm -fr test-repo
> git init test-repo
> cd test-repo
> echo foo>bar; git add bar; git commit -m "foo"
> echo boz>bar; git add bar; git commit -m "boz"
> git checkout --detach
> git status
> git branch
> rm -fr .git/logs/
> git status
> git branch
> 
> The end of the output is:
> 
>   + git checkout --detach
>   + git status
>   HEAD detached at HEAD
>   nothing to commit, working directory clean
>   + git branch
>   * (HEAD detached at HEAD)
>     master
>   + rm -fr .git/logs/
>   + git status
>   Not currently on any branch.
>   nothing to commit, working directory clean
>   + git branch
>   * (no branch)
>     master
> 
> If one replaces "git checkout --detach" with "git checkout HEAD^0", then
> the output is the one I expected:
> 
>   HEAD detached at cb39b20
> 
> The guilty line in the reflog is:
> 
>   checkout: moving from master to HEAD
> 
> One possible fix is to resolve HEAD when encountering it in the reflog,
> like this:
> 
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1319,6 +1319,13 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>         hashcpy(cb->nsha1, nsha1);
>         for (end = target; *end && *end != '\n'; end++)
>                 ;
> +       if (!memcmp(target, "HEAD", end - target)) {
> +               /* Don't say "HEAD detached at HEAD" */
> +               unsigned char head[GIT_SHA1_RAWSZ];
> +               get_sha1("HEAD", head);
> +               strbuf_addstr(&cb->buf, find_unique_abbrev(head, DEFAULT_ABBREV));
> +               return 1;
> +       }
>         strbuf_add(&cb->buf, target, end - target);
>         return 1;
>  }
> 
> What do you think?
> 
> Shall I turn this into a proper patch?
> 
> Thanks,
> 

Thanks for finding the root cause.

I think, though, that the reflog is wrong:

"git checkout --detach" should be equivalent to "git checkout HEAD^0",
shouldn't it? It becomes clearer with branches:

git co --detach master
git reflog
3b9153c HEAD@{0}: checkout: moving from master to master

I think that information ("moving ... to master") is misleading at best,
if not wrong (depending on how you read the reflog). In any case you
cannot distinguish a regular branch checkout (i.e. branch switching)
from a "--detach" checkout in the reflog, which is bad.

The same happens when you "git checkout origin/next" and you get
--detach kicking in automatically. It looks like a regular branch checkout.

So, maybe we should really fix the reflog, e.g. by amending the
information there?

status/branch figure out that they're in the detached case even without
the help from reflog, and your patch is correct as long as we don't
commit on top of the fork point. But as soon as we do that, resolving
"HEAD" will not give you the fork point, and the output of "detached
from..." will be incorrect (based on my reading of the patch and my
memory of the workings, no compile test yet, sorry).

Michael
