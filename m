From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Wed, 14 Sep 2011 19:14:13 +0300
Message-ID: <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com>
	<CAMP44s0N6pCUe_nop66yTwWitP6LhJXsnaVNwYH46OaxRbdVKg@mail.gmail.com>
	<201109031738.11678.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 18:14:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3s6T-0000II-9G
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 18:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1INQOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 12:14:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49215 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab1INQOT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 12:14:19 -0400
Received: by bkbzt4 with SMTP id zt4so1679063bkb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kQqYMHQXTMzRXX75HLJAacknxn/klZeco/8/tTQGZOU=;
        b=BZ3/Uq6YES7J7/izA2HNWcPTzsa9psSTujS2yYD6hxsbCV2bFVHhWw3eDzFlsyyNSj
         /i3MocOJeCh6AStw1G3ZY9mRroBZOTfCY3UYyj7aL1mCMfRNVeIjGfrm/bED1pdeQBiX
         VAI7CkHK545XFvq2ksJvq6ENZlYECFLnJbtKE=
Received: by 10.204.156.4 with SMTP id u4mr31444bkw.68.1316016853606; Wed, 14
 Sep 2011 09:14:13 -0700 (PDT)
Received: by 10.204.40.194 with HTTP; Wed, 14 Sep 2011 09:14:13 -0700 (PDT)
In-Reply-To: <201109031738.11678.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181365>

On Sat, Sep 3, 2011 at 6:38 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Sat, 3 Sep 2011, Felipe Contreras wrote:
>> 2011/7/25 Jakub Narebski <jnareb@gmail.com>:
>
>> > I am planning doing annual Git User's Survey, and I'd like to ask =
for
>> > feedback.
>>
>> Do you have an updated version somewhere?
>
> You can preview test version of survey at
>
> =C2=A0https://www.survs.com/survey/VEBXFGJ9B0
>
> Note that all answers in this test channel will be deleted!
>
> Up to date version was sent to git mailing list as
>
> =C2=A0[RFCv2] Questions for "Git User's Survey 2011"
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/180643
>
> and can be found on Git Wiki:
>
> =C2=A0http://git.wiki.kernel.org/index.php/GitSurvey2011
>
>
> P.S. If I remember correctly you wanted some question about "staging =
area"
> terminology, or something like that. =C2=A0Do you have concrete propo=
sal for
> question and list of answers?
>
> I was thinking about
>
> =C2=A0xx. How do you include changes in new commit?
> =C2=A0(multiple choice, with other)
>
> =C2=A0[ ] commit -a
> =C2=A0[ ] commit <file>
> =C2=A0[ ] commit -i <file>
> =C2=A0[ ] git add
> =C2=A0[ ] git stage
> =C2=A0[ ] git update-index
> =C2=A0[ ] incremental add / commit
> =C2=A0[ ] other, please specify __________________________
>
> (it is not in current version of survey, but can be added before it s=
tarts
> for real)... though it is only small subset of "stage" vs "the index"
> terminology. =C2=A0If you have something better...

I am just looking at this. You should send regular updates to the
survey, right after the initial batch of feedback, not one day before.

=46irst of all, "changes in new commit" doesn't sound right, should be
either "a new commit", or "new commits".

Second, you should have added what I said:

+ stage / partial or interactive commits (e.g. git add -u/-i/-p, git
diff --cached)

Nowhere in the survey does it as for 'git diff --cached' or anything
that acts on the stage.

So now we have your question, plus this:
 + interactive commit / per-hunk comitting / partial commit

But that's not good enough.

People might think 'git add -u/-i/-p' is not related to a commit.
Also, we still don't know if people use --cached --keep-index, or any
of those. If instead of 'git add/stage' you had 'git add/stage
-u/-i/-p' That would have been better, and no, incremental add /commit
doesn't really fit, for example, I usually do 'git add -p; git
commit', so it's not really incremental.

I think we should stop beating around the bushes, and ask what we want =
to ask:

 =3D=3D Do you use the stage/cache/index? =3D=3D

If you don't want to ask that question directly, or you think people
might not understand the question, we should be listing all the
commands that use the stage, and make sure they are handled in the
survey:

 X git diff --cached
 X git grep --cached
 X git rm --cached
 X git stash apply/pop --index
 X git stash (save) --[no-]keep-index
 X git add <tracked_file>
 X git add -p
 X git add -i
 X git add -u
 X git commit -p
 X git commit --interactive (not the same as git commit -i)

It turns out none of them are explicitly asked in the survey. In order
to do that, this is the only option I see:

 + interactive commits (e.g. git commit -p/--interactive)
 + stage (e.g. git add -p/-i/-u, git add <tracked_file))
 + stage commands (e.g. git * --cached, git stash * --index/--[no-]keep=
-index)

Or at the very least what I suggested initially:
 + stage / partial or interactive commits (e.g. git add -u/-i/-p, git
* --cached)

Cheers.

--=20
=46elipe Contreras
