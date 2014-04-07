From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 07 Apr 2014 23:46:32 +0200
Message-ID: <53431CB8.2050600@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 23:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHNH-0001kT-PL
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 23:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaDGVqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 17:46:36 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:44767 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbaDGVqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 17:46:34 -0400
Received: by mail-wg0-f43.google.com with SMTP id x13so49485wgg.26
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pSpkh9J/mNeI75lySBKY2v3WpbWVVrel4TAERxL1oKo=;
        b=WAulu+1xpsATzjJPpZjmgWAvf04/8HXxKDvuuXN4ErLqusCHnjbQPw1XYtLorWixHk
         neC+RA1jCnRRfth14saSZ6M/WH3AjjGodJOJ67KNAaeHRFjAbYzCroySCVEBYaszzRvu
         qRhkY1fIQrI8OJSsPgDgOIQ3ssIFxrXbp7ckfIm/xvE8WRM2D/AYpIf/qzpaL5JBl/9C
         qVA/BNpxOMSU2ZdZWHCUDA0g7CZk7qNNryYh/j8lKaGSJirew4yej6A3Tl3jyjQ6G63d
         K+jRz01YyPlGbPcZtltyrzlGV2EE9r7BAEpRo0wnwB1bXmcuyGr35CF+PhO7Vl0Cm16f
         yAAw==
X-Received: by 10.194.236.232 with SMTP id ux8mr44776734wjc.46.1396907193014;
        Mon, 07 Apr 2014 14:46:33 -0700 (PDT)
Received: from [10.0.1.101] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id bc51sm87757eeb.22.2014.04.07.14.46.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Apr 2014 14:46:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <534180BC.308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245907>

On 6. 4. 2014 18:28, Jens Lehmann wrote:
> Am 02.04.2014 21:56, schrieb Ronald Weiss:
>> On 2. 4. 2014 20:53, Jens Lehmann wrote:
>>> Am 01.04.2014 23:59, schrieb Ronald Weiss:
>>>> On 1. 4. 2014 22:23, Jens Lehmann wrote:
>>>>> Am 01.04.2014 01:35, schrieb Ronald Weiss:
>>>>>> On 1. 4. 2014 0:50, Ronald Weiss wrote:
>>>>>>> On 31. 3. 2014 23:47, Ronald Weiss wrote:
>>>>>>>> On Mon, Mar 31, 2014 at 8:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>>>>>>> As Junio mentioned it would be great if you could teach the add
>>>>>>>>> command also honor the --ignore-submodule command line option in
>>>>>>>>> a companion patch. In the course of doing so you'll easily see if
>>>>>>>>> I was right or not, then please just order them in the most logical
>>>>>>>>> way.
>>>>>>>>
>>>>>>>> Well, if You (or Junio) really don't want my patch without another one
>>>>>>>> for git add, I may try to do it. However, git add does not even honor
>>>>>>>> the submodules' ignore setting from .gitmodules (just tested with git
>>>>>>>> 1.9.1: "git add -u" doesn't honor it, while "git commit -a" does). So
>>>>>>>> teaching git add the --ignore-submodules switch in current state
>>>>>>>> doesn't seem right to me. You might propose to add also support for
>>>>>>>> the ignore setting, to make "add -u" and "commit -a" more consistent.
>>>>>>>> That seems like a good idea, but the effort needed is getting bigger,
>>>>>>>
>>>>>>> Well, now I actually looked at it, and it was pretty easy after all.
>>>>>>> The changes below seem to enable support for both ignore setting in
>>>>>>> .gitmodules, and also --ignore-submodules switch, for git add, on top
>>>>>>> of my patch for commit.
>>>>>>
>>>>>> There is a catch. With the changes below, submodules are ignored by add
>>>>>> even if explitely named on command line (eg. "git add x" does nothing
>>>>>> if x is submodule with new commits, but with ignore=all in .gitmodules).
>>>>>> That doesn't seem right.
>>>>>>
>>>>>> Any ideas, what to do about that? When exactly should such submodule be
>>>>>> actually ignored?
>>>>>
>>>>> Me thinks git add should require the '-f' option to add an ignored
>>>>> submodule (just like it does for files) unless the user uses the
>>>>> '--ignore-submodules=none' option. And if neither of these are given
>>>>> it should "fail with a list of ignored files" as the documentation
>>>>> states.
>>>>
>>>> It's still not clear, at least not to me. Should '-f' suppress the
>>>> ignore setting of all involved submodules? That would make it a
>>>> synonyme (or a superset) of --ignore-submodules=none. Or only if the
>>>> submodule is explicitly named on command line? That seems fuzzy to me,
>>>> and also more tricky to implement.
>>>
>>> Maybe my impression that doing "add" together with "commit" would be
>>> easy wasn't correct after all. I won't object if you try to tackle
>>> commit first (but I have the slight suspicion that similar questions
>>> will arise concerning the "add"ish functionality in commit too. So
>>> maybe after resolving those things might look clearer ;-)
>>
>> There is one big distinction. My patch for commit doesn't add any new
>> problems. It just adds the --ignore-submodules argument, which is easy
>> to implement and no unclear behavior decisions are needed.
>>
>> You are right that when specifying ignored submodules on commit's
>> command line, there is the same problem as with git add. However, it's
>> already there anyway. I don't feel in position to solve it, I'd just
>> like to have "git commit --ignore-submodules=none".
>>
>> With git add however, changing it to honor settings from .gitmodules
>> would change behavior people might be used to, so I would be afraid to
>> do that. Btw add also has the problem already, but only if somebody
>> configures the submodule's ignore setting in .git/config, rather than
>> .gitmodules. I don't know how much real use case that is.
>>
>> As I see it, there are now these rather easy possibilities (sorted
>> from the easiest):
>>
>> 1) Just teach commit the --ignore-submodules argument, as I proposed.
> 
> 1a) Teach commit to honor ignore from .git/config.

But commit already honors that. It honors submodule.<name>.ignore from
both .git/config and .gitmodules. It's just add which doesn't honor it
from .gitmodules, because cmd_add() function lacks a gitmodules_config()
call. Or do I miss something?

>> 2) Teach both add and commit to --ignore-submodules, but dont add that
>> problematic gitmodules_config() in add.c.
> 
> Why is that problematic after add learned --ignore-submodules=none?

First, because it changes current behaviour. Which is obviously
inconsistent currently, however I didn't find it easy to tell what's
the right thing to do.

And second, because the "-f implies --ignore-submodules=none" proposal,
which seems to be the easy cure for those accustomed to the current
behavior, seems non-trivial. Below You wrote that
--ignore-submodules=none should be implied by -f only for files
specified on the command line. OK. And what if a directory
containing the submodule is specified?

>> 3) Teach both add and commit to --ignore-submodules, and also let add
>> honor settings from .gitmodules, to make it more consistent with other
>> commands. And, make add --force imply --ignore-submodules=none.
>>
>> I like both 1) and 2). I don't like 3), the problem of add with
>> submodules' ignore setting is a bug IMHO (ignore=all in .git/config
>> causes strange behavior, while ignore=all in .gitmodules is ignored),
>> but not directly related to the --ignore-submodules param, and should
>> be solved separately.
> 
> I think the ignore config options and --ignore-submodules parameter
> are directly related, as you need the latter to override the former.
> In the long run commit should honor ignore=all in .git/config for
> unstaged submodules like add should honor the settings from the
> .gitmodules file. But we should always add the --ignore-submodules
> parameter first so that the user can override the configuration
> when needed. So I see these steps:
> 
> 1) Teach commit the --ignore-submodules option; then make it honor
>     ignore=all in .git/config in another commit.
> 
> 2) Teach add --ignore-submodules (which is implied by -f, but only
>     for the submodules given on the command line); then make it
>     honor the submodule.<name>.ignore option in another commit.
> 
> After that we'd have consistent ignore and override behavior. But
> it looks like getting -f right is not easy, so I'd prefer having
> 1) without 2) if the alternative is to get neither.

OK, I will try prepare that. However I'd more like to start with two
commits just adding the --ignore-submodules param to add and commit.
That should be easily acceptable, as there is no risk to break
anything, and it adds useful funcionality. Patching add first will
avoid having to touch add.c in patch for commit, which makes it more
clear and logical IMHO.

Then, on top of that, I'll prepare patches for add to honor ignore
from .gitmodules, and -f implying --ignore-submodules. That might need
more discussion, let's see.
