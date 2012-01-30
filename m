From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 15:51:48 +0200
Message-ID: <CAMP44s2OQY3Pym5uqxvEE_yYa0xLboT=mjv+DFCDo8_xobGO3w@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
	<20120130025014.GA15944@burratino>
	<CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com>
	<871uqh3a8s.fsf@thomas.inf.ethz.ch>
	<25ea208e-353d-48f7-a849-143689fb2be6@email.android.com>
	<CAMP44s2ooo1uArhhtJkX3S9N=iE4MNJivMSvr3hsOkxFmJupFA@mail.gmail.com>
	<87pqe1nx9a.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <jch2355@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 30 14:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrreJ-0001CZ-Vz
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 14:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab2A3Nvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 08:51:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37251 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541Ab2A3Nvu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 08:51:50 -0500
Received: by lagu2 with SMTP id u2so2200569lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7z7PY+Lx5Ec0LJiN56RJUJoDUXUiEUBGQ7btBBcA8hI=;
        b=qD5c8qBiEus/hQADwxlsA1MLc7GFJWnK6YOOYbjb0EMaI4j3hNv5G+WRXAOhLLgYdD
         i28O2EUQoOIo7Xp7DlrQM0aMDLm5/Wn3LWNoCyprVyY5sfcJrtv5LgwkpiLvJYF4GzCN
         paPkR86zXgFienj05tZ6UWfXf45mLGaHxCtxQ=
Received: by 10.152.131.40 with SMTP id oj8mr9243365lab.24.1327931508833; Mon,
 30 Jan 2012 05:51:48 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 05:51:48 -0800 (PST)
In-Reply-To: <87pqe1nx9a.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189360>

On Mon, Jan 30, 2012 at 3:19 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, Jan 30, 2012 at 10:22 AM, Junio C Hamano <jch2355@gmail.com>=
 wrote:
>>> Thomas Rast <trast@inf.ethz.ch> wrote:
>>>>Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> No reason. I hope they read the mailing list, otherwise I'll rese=
nd
>>>>> and CC them. A get_maintainers script, or something like that wou=
ld
>>>>> make things easier.
>>>>
>>>>I simply use
>>>>
>>>> =C2=A0git shortlog -sn --no-merges v1.7.0.. -- contrib/completion/
>>>>
>>>>(In many parts the revision limiter can be omitted without losing m=
uch,
>>>>but e.g. here this drops Shawn who hasn't worked on it since 2009.)
>>>
>>> Or "--since=3D1.year", which you can keep using forever without adj=
usting.
>>
>> Perhaps something like that can be stored in a script somewhere in
>> git's codebase so that people can set sendemail.cccmd to that.
>
> Umm, that seems rather AI-complete. =C2=A0You should always compile t=
he list
> by hand.

Why? Take a look at the Linux kernel; having tons of contributors,
many still haven't learned the ropes, and looking at MAINTAIERS, plus
the output of 'git blame', for potentially dozens of patches is too
burdensome, which is why they have 'scripts/get_maintainer.pl' that
does a pretty good job of figuring out who to cc so you don't have to
think about it.

> Ok, this got rather long-winded. =C2=A0But I think the bottom line is=
, trying
> to put this in sendemail.cccmd is trying to script common sense.

It's still better than nothing.

I once wrote a much smarter script[1], but it never go into the tree.

The output I get is this:
"Shawn O. Pearce" <spearce@spearce.org>>
"Jonathan Nieder" <jrnieder@gmail.com>
"Mark Lodato" <lodatom@gmail.com>
"Junio C Hamano" <junkio@cox.net>
"Ted Pavlic" <ted@tedpavlic.com>

Note: seems like there's a bug with git blame -P:
% g blame -p -L 2730,+33 contrib/completion/git-completion.bash | grep
author-mail

And if this script is such a bad idea; why do you think sendmail.cccmd =
exists?

I think we should have a simple script that at least does something
sensible, at least in contrib, but I hope we could even have a
standard git-cccmd that all projects could use.

It looks like my ruby script never had much of a chance getting
anywhere, so would it be accepted in another format? perl? python?
bash?

Cheers.

[1] http://thread.gmane.org/gmane.comp.version-control.git/130391

--=20
=46elipe Contreras
