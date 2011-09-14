From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Wed, 14 Sep 2011 19:39:12 +0200
Message-ID: <201109141939.14070.jnareb@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <201109031738.11678.jnareb@gmail.com> <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 19:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3tOy-0006TC-Cm
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 19:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab1INRhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 13:37:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44228 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104Ab1INRhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 13:37:18 -0400
Received: by fxe4 with SMTP id 4so1958655fxe.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=BW7dhCvERlkBsLwzxHunjAEBqPur6dYHzeEBllTIqHM=;
        b=Es1jK1oYMlo5aQR8ieFxMwa+rQCX+XSFZMwD3kDHdeLM3uDCKRSCojWhBSi74ERbTp
         YordXFkS1RsijPDJCrRtyOO9Cx90C4IUAuZNGJhgo5iHE+h2HCpmbXBAzC5uEB6yWoac
         bwCvaBNO7uc//Ox32YuZzjBXyEqKgQTN1Fqr4=
Received: by 10.223.5.155 with SMTP id 27mr130257fav.90.1316021836923;
        Wed, 14 Sep 2011 10:37:16 -0700 (PDT)
Received: from [192.168.1.13] (abwn193.neoplus.adsl.tpnet.pl. [83.8.237.193])
        by mx.google.com with ESMTPS id c2sm3963551faf.16.2011.09.14.10.37.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 10:37:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181367>

On Wed, 14 Sep 2011, Felipe Contreras wrote:
> On Sat, Sep 3, 2011 at 6:38 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> On Sat, 3 Sep 2011, Felipe Contreras wrote:
>>> 2011/7/25 Jakub Narebski <jnareb@gmail.com>:

>>>> I am planning doing annual Git User's Survey, and I'd like to ask =
for
>>>> feedback.
[...]
>> P.S. If I remember correctly you wanted some question about "staging=
 area"
>> terminology, or something like that. =C2=A0Do you have concrete prop=
osal for
>> question and list of answers?
>>
>> I was thinking about
>>
>> =C2=A0xx. How do you include changes in new commit?
>> =C2=A0(multiple choice, with other)
>>
>> =C2=A0[ ] commit -a
>> =C2=A0[ ] commit <file>
>> =C2=A0[ ] commit -i <file>
>> =C2=A0[ ] git add
>> =C2=A0[ ] git stage
>> =C2=A0[ ] git update-index
>> =C2=A0[ ] incremental add / commit
>> =C2=A0[ ] other, please specify __________________________
>>
>> (it is not in current version of survey, but can be added before it =
starts
>> for real)... though it is only small subset of "stage" vs "the index=
"
>> terminology. =C2=A0If you have something better...
>=20
> I am just looking at this. You should send regular updates to the
> survey, right after the initial batch of feedback, not one day before=
=2E

I'm very sorry about that.

My excuse is that I had less time during the summer holidays than
I thought, and there were time when I was not able to work on Git or
Git User's Survey.  Additionally the premium account plan, which we hav=
e
for free thanks to generosity of Survs.com admins, ends 26 October 2011=
=2E
This means that postponing Git User's Survey to gather feedback and
start it later was out of question.
=20
Also somehow I have missed your comments (or not implemented them
immediately because they lacked concrete proposal), and found them
only when sending last call request for feedback, just before starting
survey.

> First of all, "changes in new commit" doesn't sound right, should be
> either "a new commit", or "new commits".

=46ixed (to "a new commit"), thanks.
=20
> Second, you should have added what I said:
>=20
> + stage / partial or interactive commits (e.g. git add -u/-i/-p, git
> diff --cached)
>=20
> Nowhere in the survey does it as for 'git diff --cached' or anything
> that acts on the stage.

I couldn't come with a good question that would ask about that, and
I didn't want to create too long survey, with too many questions.
=20
> So now we have your question, plus this:
>  + interactive commit / per-hunk comitting / partial commit
>=20
> But that's not good enough.

Right.
=20
> People might think 'git add -u/-i/-p' is not related to a commit.
> Also, we still don't know if people use --cached --keep-index, or any
> of those. If instead of 'git add/stage' you had 'git add/stage
> -u/-i/-p' That would have been better, and no, incremental add /commi=
t
> doesn't really fit, for example, I usually do 'git add -p; git
> commit', so it's not really incremental.

I explicitly asked separately about _incremental_ and _interactive_...
but not in the new question.  I'm sorry about that.  Hopefully at
least some people will include "partial / interactive" in 'other'.
=20
> I think we should stop beating around the bushes, and ask what we wan=
t to ask:
>=20
>  =3D=3D Do you use the stage/cache/index? =3D=3D

Perhaps "Do you use the stage/cache/index explicitly, and how?".
=20
> If you don't want to ask that question directly, or you think people
> might not understand the question, we should be listing all the
> commands that use the stage, and make sure they are handled in the
> survey:
>=20
>  X git diff --cached
>  X git grep --cached
>  X git rm --cached
>  X git stash apply/pop --index
>  X git stash (save) --[no-]keep-index
>  X git add <tracked_file>
>  X git add -p
>  X git add -i
>  X git add -u
>  X git commit -p
>  X git commit --interactive (not the same as git commit -i)

If there will be "Git User's Survey 2012", let's add this question
(replacing my "How do you include changes in new commit?").

It is a pity that Git Wiki doesn't work yet; I'd rather put this
proposal in Talk page for GitSurvey2011, or in GitSurvey2012
for next year survey proposal (if there would be one).
=20
> It turns out none of them are explicitly asked in the survey. In orde=
r
> to do that, this is the only option I see:
>=20
>  + interactive commits (e.g. git commit -p/--interactive)
>  + stage (e.g. git add -p/-i/-u, git add <tracked_file))
>  + stage commands (e.g. git * --cached, git stash * --index/--[no-]ke=
ep-index)
>=20
> Or at the very least what I suggested initially:
>  + stage / partial or interactive commits (e.g. git add -u/-i/-p, git
> * --cached)

P.S. Would you be interested in running the next survey?

--=20
Jakub Narebski
Poland
