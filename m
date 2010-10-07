From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu, 7 Oct 2010 20:52:47 +0200
Message-ID: <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
References: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
	<87wrptua21.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 20:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vaK-0000DR-T8
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 20:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0JGSwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 14:52:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38363 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab0JGSwt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 14:52:49 -0400
Received: by iwn9 with SMTP id 9so169832iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FN68LPmMv0uMmTvqA5Vr1PUvM1AG/Rrsh49XmomBsl8=;
        b=O+EDbCu85RmHJ9R3HW+wLsPZRCdcxUy6holGrL4KVrUJqb4rTW9wafgJoRXR7kpj9R
         a0GDqlGOtRdFExhcnXXTm3W7OznIS4gEjUYfeSCySZ6qElogaz4RHRQPsj+BeDi9k+gl
         X/leMX63T0wDf/kAeVxiU6LvR1k/jMydOa4Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fhA5AJvkeXkbMDwHYO5n4XqFVxTSZGytGPPbrCZMr9qKCCspejqqOYYCgQcN2VqVVI
         4opclU5xH3YrVRDUVy5PRJ1qxGR5EVaC90XrweBSa/HiudgyPghdPMpPOBo1lJ7r/fJ4
         yU7OYRlE419dXOH7OZ2v8t+LVr+/nz/FJOczE=
Received: by 10.231.17.10 with SMTP id q10mr1276974iba.153.1286477568769; Thu,
 07 Oct 2010 11:52:48 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Thu, 7 Oct 2010 11:52:46 -0700 (PDT)
In-Reply-To: <87wrptua21.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158430>

On Thu, Oct 7, 2010 at 20:33, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem=
@gmail.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> Also mention, that --stdin and --index-info needs to be the last
>> option supplied and indicate this in the usage string.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>>
>> We may like the usage string like this:
>>
>> [[-z] --stdin | --index-info]
>
> Yeah, that'd be definitely better IMO.

Will do.

>
> Also the usage string in builtin/update-index.c should be updated to =
the
> same effect.
>
> There is actually at least one more problem with the current SYNOPSIS=
 of
> `update-index'. Obviously the `*' on the third line of the Asciidoc
> source makes the whole `--cacheinfo' line disappear and the rest bold
> (cf. e.g. the result at
> <http://www.kernel.org/pub/software/scm/git/docs/git-update-index.htm=
l>).
>
> I guess using `...' instead of the asterisks (also on the last line,
> i.e. [<file>...], not [<file>]*) would both fix the problem and at th=
e
> same time make it more consistent with other man pages.

I wont change it in this patch, because I can't build the html docs rig=
ht now.

>
>> to make it also clear, that -z applies only to --stdin or --index-on=
ly.
>> ---
>> =C2=A0Documentation/git-update-index.txt | =C2=A0 14 ++++++++------
>> =C2=A01 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/git-update-index.txt
>> b/Documentation/git-update-index.txt
>> index 74d1d49..4441d7c 100644 Documentation/git-update-index.txt
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -18,8 +18,9 @@ SYNOPSIS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--skip-worktree | --no-ski=
p-worktree]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--ignore-submodules]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--really-refresh] [--unres=
olve] [--again | -g]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--info-only] [--index-info]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[-z] [--stdin]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--info-only]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[-z]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--stdin] [--index-info]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--verbose]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--] [<file>]*
>
> Shouldn't `--verbose' be also moved before the must-be-last options?

Sure. I noticed this myself, but the patch was already in the wire.

>
>> @@ -72,7 +73,7 @@ OPTIONS
>> =C2=A0 =C2=A0 =C2=A0 Directly insert the specified info into the ind=
ex.
>>
>> =C2=A0--index-info::
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0Read index information from stdin.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0Read index information from stdin (Must=
 be last option).
>
> I'm not a native speaker myself, but I suspect "must be THE last opti=
on"
> is more correct (including the lower-case `m' :-)).

Maybe this should be in its own sentence, like the '(Implies
--remove.)' in --force-remove.

>
>> =C2=A0--chmod=3D(+|-)x::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the execute permissions on the=
 updated files.
>> @@ -138,14 +139,15 @@ you will need to handle the situation manually=
=2E
>> =C2=A0--stdin::
>> =C2=A0 =C2=A0 =C2=A0 Instead of taking list of paths from the comman=
d line,
>> =C2=A0 =C2=A0 =C2=A0 read list of paths from the standard input. =C2=
=A0Paths are
>> - =C2=A0 =C2=A0 separated by LF (i.e. one path per line) by default.
>> + =C2=A0 =C2=A0 separated by LF (i.e. one path per line) by default
>> + =C2=A0 =C2=A0 (Must be last option).
>
> (same here)
>
>>
>> =C2=A0--verbose::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Report what is being added and rem=
oved from index.
>>
>> =C2=A0-z::
>> - =C2=A0 =C2=A0 Only meaningful with `--stdin`; paths are separated =
with
>> - =C2=A0 =C2=A0 NUL character instead of LF.
>> + =C2=A0 =C2=A0 Only meaningful with `--stdin` or `--index-info`; pa=
ths are
>> + =C2=A0 =C2=A0 separated with NUL character instead of LF.
>>
>> =C2=A0\--::
>> =C2=A0 =C2=A0 =C2=A0 Do not interpret any more arguments as options.
>
> Thanks,

Thank you.

Bert

>
> =C5=A0t=C4=9Bp=C3=A1n
>
