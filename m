From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [QUERY] Why do we have git-completion.zsh?
Date: Sat, 20 Apr 2013 20:21:16 -0500
Message-ID: <CAMP44s3T7aoN_X5vvA3wb0pm1djXSvjy_DzTvG3TYKXS+ZbLYQ@mail.gmail.com>
References: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
	<20130420184539.GA8586@elie.Belkin>
	<20130420185329.GB8586@elie.Belkin>
	<CAMP44s3yCW-pHVHc9WfL1BC7BKmnXxZ1WQyPRAMnx967=74_Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 03:21:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTiy3-0002RH-BW
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 03:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab3DUBVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 21:21:19 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44756 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab3DUBVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 21:21:18 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so4642111lbi.25
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 18:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ziR3aNplBZhMW5HrU9J5nCoHU/qObi7heUNRda6bJ7A=;
        b=BjPE5o3fCquaJu32va37pwdOwiTcGNteT86wsQvC0fxOeTRYsyQlmt9ueSibJP2AYL
         FenKPJrgfCQPO0d+FpHd7YiR1XaHgVCEVwTgbHdJeVhBYO4rSQJ96t1BhESo/wapRIjC
         m/wcM0vwGv5Ggg7vPt+hjr/+5ZmDcnKBBPOOXE8o8qS5HxYSgoenjDGeSu3qbIg8d3oT
         1yic2q84PX8hcq2vpmGbHnYk9jhAw0G6LKnKRr+Hi8duZFXAbdRTOwDyqX3dQz+xa+50
         HKt0sAkaoJqu/2yVQqEl8aP5Md7y7Z7l8UflCrQGv8z/CfubuOoD6MpJid7ctyIqFlFt
         1qLw==
X-Received: by 10.112.140.100 with SMTP id rf4mr1577251lbb.82.1366507276442;
 Sat, 20 Apr 2013 18:21:16 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 20 Apr 2013 18:21:16 -0700 (PDT)
In-Reply-To: <CAMP44s3yCW-pHVHc9WfL1BC7BKmnXxZ1WQyPRAMnx967=74_Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221886>

On Sat, Apr 20, 2013 at 5:39 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Apr 20, 2013 at 1:53 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Jonathan Nieder wrote:
>>> Ramkumar Ramachandra wrote:
>>
>>>>                             However, I don't understand why we
>>>> maintain it, because there's a comprehensive first-class completer in
>>>> ZSH core [1] which I use all the time.  Shouldn't the completion folks
>>>> be contributing to this instead?
>>>
>>> Only if they want to.
>> [...]
>>> http://thread.gmane.org/gmane.comp.version-control.git/210022/focus=210024
>>
>> Sorry, wrong link.  Here's a better one:
>>
>> http://www.zsh.org/mla/workers/2011/msg00497.html
>>
>> More fundamentally, your question seems to assume some kind of shared
>> plan regarding what people work on, rather than each person choosing
>> to work on what they consider valuable without having to justify it to
>> others.  I am very happy with Felipe's work on git's completion code
>> and don't think it does any harm to efforts elsewhere.
>
> To complement the reason; the zsh folks (or perhaps it's only one; who
> works on the git stuff), absolutely prioritize "correctness" over
> speed, that means if it takes ten seconds to list all the possible
> files to complete, grouped nicely, that's exactly what they'll do,
> instead of the way the bash completion does, which lists the most
> likely files, which takes milliseconds.
>
> I found zsh's completion unbearably slow, which is ironic; git is the
> fastest DSCM on Earth, and they blow the performance away by making
> the completion dead slow, to the point where the completion is several
> orders of magnitude slower than the actual command. To me, the whole
> point of the completion is to make the work faster, and if the
> completion takes longer than me typing it, what's the point of it?
>
> And I'm not the only one, when I contributed this stuff to
> oh-my-zsh[1] I got a very positive response.
>
> I couldn't convince them of this obvious fact, so I choose git's bash
> fast completion.
>
> I have patches to improve the zsh thin wrapper to give more
> information, zsh style, in a way that is superior to zsh's git
> completion, but I'm still not happy with them, I want the user to be
> able to configure the output so it's not totally bloated like in zsh,
> and I'm still working on it. In the mean time, I want my completion to
> be blazingly fast, and at least as good as git's bash completion.

Actually, it's mostly there now:
https://github.com/felipec/git/blob/fc/zsh/ng/contrib/completion/git-completion.zsh

This greatly improves 'git <tab>' over the plain bash version, and
it's even better than the official zsh version, because you can do
something like:

  zstyle ':completion:*:*:git:*' tag-order 'common-commands porcelain-commands'

To show only the command groups you are interested on. With official
zsh, you get the whole enchilada of all the commands git has. Hardly
user-friendly.

Cheers.

-- 
Felipe Contreras
