From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Sun, 20 Mar 2016 16:11:31 +0100
Message-ID: <CAA19uiSUV0C=WQAhgum9MM8r8NixMF8O0XOFxzywSJtBEcGNmQ@mail.gmail.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
	<xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
	<56E96096.4020108@drmicha.warpmail.net>
	<CANYiYbFa5i-E0dYYj2dm4pHmQwLJfj3UBc3OspQz93HTP3C3Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:11:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahf1H-0002pK-QD
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbcCTPLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2016 11:11:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35288 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755523AbcCTPLe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 11:11:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BD6AF21AD3
	for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:11:32 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 20 Mar 2016 11:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=3kcUzfw68yAsBhYhz312ICIejGA=; b=kM9iqj
	sshSIQeOIeDgFvkIyC+JReRKBX2+0cjo9h+M9a7zUBYtMBRhHgyfMzS6YyNPHmLp
	4uun7Yc2anrEywZiiLK0YDVEflWOJaNhIGFeM4G7wvndf9z4SMlqLdHJ/V32LUsz
	sVyrcxwEVRzGjZr9pO34fuAdyfFI+yqQVlprc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3kcUzfw68yAsBhY
	hz312ICIejGA=; b=qACRfVSF/jDHSTp8w1ZDZB5auwexmxGxJEAxtwPSR/5gnlZ
	5DYQ8feFfY6DIMiCfQSbG+fmcL/lk2g0eYlmoQDHAcJmwzaHJx/NqbFjmwfVx6rB
	HzyNGVAhYvL0U32GvrFHxMw/D6lM86I5h8IuW43/uXPrJmM4TKIe5myGLXB0=
X-Sasl-enc: 9N8aQTpq+gBkJo/UjGovVKgoNoJKkadB1otztbJUvJ3k 1458486692
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com [209.85.215.45])
	by mail.messagingengine.com (Postfix) with ESMTPA id 441E6680134
	for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:11:32 -0400 (EDT)
Received: by mail-lf0-f45.google.com with SMTP id v130so66546847lfd.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 08:11:32 -0700 (PDT)
X-Gm-Message-State: AD7BkJLu/jcIEo6JPmnRjEf9tEZ9F1FrKQ4b4GHV089CozaquMQtk0JBlvduokKH4Feh3lTs++Qb5i6XV+oI7g==
X-Received: by 10.25.21.22 with SMTP id l22mr9520982lfi.38.1458486691214; Sun,
 20 Mar 2016 08:11:31 -0700 (PDT)
Received: by 10.114.184.172 with HTTP; Sun, 20 Mar 2016 08:11:31 -0700 (PDT)
In-Reply-To: <CANYiYbFa5i-E0dYYj2dm4pHmQwLJfj3UBc3OspQz93HTP3C3Ng@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAA19uiSUV0C=WQAhgum9MM8r8NixMF8O0XOFxzywSJtBEcGNmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289356>

2016-03-20 10:45 GMT+01:00 Jiang Xin <worldhello.net@gmail.com>:
> 2016-03-16 21:33 GMT+08:00 Michael J Gruber <git@drmicha.warpmail.net=
>:
>> Junio C Hamano venit, vidit, dixit 14.03.2016 18:47:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> But if it makes it easier for translations teams and the i18n
>>>> coordinator to work together if I also pulled the git.pot update
>>>> myself, I'll do so.  I just didn't know (and still don't know) if
>>>> that makes things easier for you guys, or if that risks making
>>>> things more confusing, having to or being able to pull from two
>>>> trees that are not necessarily in sync down to the minute.
>>>
>>> So, please just tell me to pull it myself too, if it makes the life
>>> of i18n team and the coordinator easier.
>>>
>>> Thanks.
>>>
>>
>> I don't know about the workflow in general. I'll write up what trigg=
ered
>> my question: I was looking at the FAQ "how do I display the current
>> branch in git" and into ways to provide some ui (think "git status -=
sb",
>> the "+"-line in "git branch"), when I found the problematic output. =
The
>> multiple parentheses looked suspicious to me, but given the many lev=
els
>> of macro expansion I wasn't sure, and simply patching the parenthese=
s
>> didn't help either. It needed a combination of "make pot" and "msgme=
rge
>> ...", and the fact that the last merge of git.pot was from 2.7.0-rc
>> triggered my request to merge what we have.
>>
>> In hindsight, what happened must have been like this:
>>
>> "ahead " was marked properly for l10n and translated in the past.
>>
>> 7a76c28 (status: disable translation when --porcelain is used,
>> 2014-03-20) introduced those extra parentheses. Matthieu probably di=
dn't
>> rerun "make pot" and "msgmerge" so that he didn't notice the consequ=
ences.
>>
>> When Jian ran "make pot" the "ahead "-entry got removed from git.pot=
:
>> 5e078fc (l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed), 2014-04=
-19)
>>
>> When translators ran "msgmerge" with the new git.pot the existing "a=
head
>> "-entry got commented out, for example here for de.po:
>> 74c17bb (l10n: de.po: translate 45 new messages, 2014-04-01)
>>
>> I'm actually wondering why I didn't notice this much earlier. I don'=
t
>> know which workflow would have prevented this either. Maybe, since w=
e
>> have "make pot", we should also have "make l10n" or something to mak=
e it
>> (even) easier for non-l10n-experts to check whether they introduced =
any
>> problems.
>>
>> Strictly speaking, every source file with i18n markup should trigger=
 a
>> "make pot" (and make l10n) when changed, but there's probably a good
>> reason why we don't do that.
>
> How about this?  We can make a website (host on github) to show i18n
> changes. Homepage is just a markdown page, list no-merge commits
> which introduced i18n changes. So we don't have to change the workflo=
w.
>
> 1. A local git clone, keep update with upstream.
> 2. Give a starting point, and generate a no-merge commit list.
> 3. Scan through local git clone and generate a pot file for each
>     commit and its parent commit, and save them in cache (by hard
>     link to save disk space).
> 4. Generate diffs for each commit.
> 5. Generate the MarkDown web page through a template.
> 6. Commit the changes of the markdown page, and push to github.
>
> --
> Jiang Xin

I think this is a general question about how to track build products.
The proper place may be in a tree that is referenced from a note or
so.
Maybe I shouldn't consider git.pot a build product - I don't know, as
I honestly don't know why we treat it the way we do.
I could understand if we don't track it all, or if we regnerate it
from "make all" and track the result. We do track it but let it go
stale. There must be a good reason for that, it's just that I don't
know it.

Maybe the problem that I'm trying to solve appears rare enough to not
warrant a solution...

The question of how to track build products (such as pdf compiled from
LaTeX) properly may be a more general one, more deserving a solution.
=EF=BF=BC
Michael
