From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sat, 24 Oct 2009 22:12:36 +0300
Message-ID: <94a0d4530910241212s5d644eb6u66c6f96feafcaf10@mail.gmail.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
	 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
	 <7v3a587kc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 21:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1m8Y-0000LR-3l
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 21:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZJXTMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Oct 2009 15:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbZJXTMd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 15:12:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:53233 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZJXTMd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2009 15:12:33 -0400
Received: by fg-out-1718.google.com with SMTP id d23so635927fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9g9SOY0Aqu/oYo8FBMXWQDHIo22imWdX+yLliOAXnEg=;
        b=R0pE++FxJD5NZbsBisEz0ylLeBpgTOIzjY/y4tKKdOOdEum86w3OUTCiqFDVOo20PV
         +2e2sWZp4Cvrvd4E8kSjG+BjBbm94musvhySWHgfwFUEjIha0Ub8ne5FQm21I5fxiF7+
         cg3lzHrC4ygW+lxXrqy5gT0MKaTTX9/Js+hYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FxalnuRnpkz+4QR/Bge+QZGSVfTzaY49TsosiCfeO7cZZUsUcPc8OqadUvJeeR5+O1
         agAN7OHvwG8Q9kL2WUWhE7vLEY+HQPLzd8hwu1DWOmm5Hc2Nc3oKB+5pBjEaqfudobqC
         JZXnNDWkY5Pha9P3Byyu89YeIcGGVJDEHcVK8=
Received: by 10.86.192.34 with SMTP id p34mr6927891fgf.28.1256411556302; Sat, 
	24 Oct 2009 12:12:36 -0700 (PDT)
In-Reply-To: <7v3a587kc2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131172>

On Sat, Oct 24, 2009 at 8:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Is this meant to replace the previous one that is already queued: a0c=
0ecb
> (user-manual: use 'fast-forward', 2009-10-11)?

Yes.

> It seems that these mostly match a mechanical token replacement
> "s/([fF])ast forward/$1ast-forward/g" in the Documentation area,
> but I suspect there may be some manual fixes.
>
> Token-replace is much harder to review than to produce, as the result=
 of
> such mechanical substitution needs to be examined to see if each chan=
ge
> makes sense individually.

I manually replaced each instance, and reviewed the patch myself. Most
of the changes are essentially the same, except a few instances:

"Fast forward" -> fast-forward
=46ast Forward Only -> Fast-forward Only

> I suspect the patch would have been much easier to the reviewers it i=
t
> stated somewhere in the log message:
>
> =C2=A0(1) how the mechanical change was produced;

There wasn't such.

> =C2=A0(2) what criteria was used to choose between leaving the mechan=
ical
> =C2=A0 =C2=A0 change as-is and rewording them manually; and

If it wasn't straight forward. I considered the following straightforwa=
rd:
fast forward -> fast-forward
fast forwarded -> fast-forwarded
fast forwarding -> fast-forwarding
fast forwardable -> fast-forwardable
non-fast forward -> non-fast-forward
=46ast forward -> Fast-forward
=46ast forwarding -> Fast-forwarding

> =C2=A0(3) where these non-mechanical changes are.

Mentioned on the second comment.

> Here are the list of paths I looked at (during this sitting which did
> not go til the end of the patch):
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>
> OK
>
>> diff --git a/Documentation/git-http-push.txt b/Documentation/git-htt=
p-push.txt
>
> OK
>
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>
> OK, except for two hunks below I am not absolutely sure.
>
>> @@ -60,7 +60,7 @@ EXAMPLES below for details.
>> =C2=A0Pushing an empty <src> allows you to delete the <dst> ref from
>> =C2=A0the remote repository.
>> =C2=A0+
>> -The special refspec `:` (or `{plus}:` to allow non-fast forward upd=
ates)
>> +The special refspec `:` (or `{plus}:` to allow non-fast-forward upd=
ates)
>> =C2=A0directs git to push "matching" branches: for every branch that=
 exists on
>> =C2=A0the local side, the remote side is updated if a branch of the =
same name
>> =C2=A0already exists on the remote side. =C2=A0This is the default o=
peration mode
>
> Hmm, is non-fast-forward a yet another compound word?

Yes. AFAIK.

>> @@ -342,9 +342,9 @@ git push origin :experimental::
>
> Likewise.
>
>> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-rea=
d-tree.txt
>> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-=
receive-pack.txt
>> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.t=
xt
>> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-sen=
d-pack.txt
>> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitc=
ore-tutorial.txt
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glos=
sary-content.txt
>> diff --git a/Documentation/howto/maintain-git.txt b/Documentation/ho=
wto/maintain-git.txt
>> diff --git a/Documentation/howto/revert-branch-rebase.txt b/Document=
ation/howto/revert-branch-rebase.txt
>> diff --git a/Documentation/howto/update-hook-example.txt b/Documenta=
tion/howto/update-hook-example.txt
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manu=
al.txt
>
> OK, except for this hunk I am not sure about.
>
>> @@ -2115,7 +2115,7 @@ $ git checkout release && git pull
>>
>> =C2=A0Important note! =C2=A0If you have any local changes in these b=
ranches, then
>> =C2=A0this merge will create a commit object in the history (with no=
 local
>> -changes git will simply do a "Fast forward" merge). =C2=A0Many peop=
le dislike
>> +changes git will simply do a fast-forward merge). =C2=A0Many people=
 dislike
>> =C2=A0the "noise" that this creates in the Linux history, so you sho=
uld avoid
>> =C2=A0doing this capriciously in the "release" branch, as these nois=
y commits
>> =C2=A0will become part of the permanent history when you ask Linus t=
o pull
>
> It may be Ok not to emphasize this word but that is not about "fast
> forward" vs "fast-forward". =C2=A0It is more about "in this context, =
this word
> does not have to be emphasized" kind of copy-editing which does not h=
ave
> to be limited to the case where the "word" is 'fast-forward'.

I couldn't parse that. From what I can see "Fast forward" was
emphasized because the author thought the words didn't make much sense
separated. Now that the word is fast-forward, there's no need to
emphasize.

Cheers.

--=20
=46elipe Contreras
