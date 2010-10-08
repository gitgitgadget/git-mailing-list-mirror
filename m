From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Fri, 8 Oct 2010 08:47:54 +0200
Message-ID: <AANLkTimWOWHfLtiP8BkQ8ORMhjiyiAZm7Gn+OmQ2USfT@mail.gmail.com>
References: <AANLkTinJhKHxds3e+SwYHCbN4S_tcvE1P8j4mgwh+W00@mail.gmail.com>
	<337062f16e5b354be20b0af53a63f5c540ab0eb8.1286480355.git.bert.wesarg@googlemail.com>
	<7viq1dwg8v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 08:48:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P46kK-0007ZZ-LD
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 08:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0JHGrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 02:47:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47415 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0JHGry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 02:47:54 -0400
Received: by iwn6 with SMTP id 6so297492iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e/t3MmIqn6lNSfOASU1rvmDW3Tfs1WL69QGS0lSSraw=;
        b=bN9EBmEx4jNlE7WYf6xg1JRccLx5hj4hbZ+MMVwummns12IbW8PMGYIugA10bcGY7W
         bQEU29K4cAs03bmYzL22tabTmynQ1bVjsZ1IGLswIERMO8Go78Cwx1QLPrfT3SPLJxBz
         kYBvolC0w/GtrE+Lir2uXAhSW2lDzf08z3Tdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KAtaSOvdpuMTXFafRrfa9Ex5OmAPZCG+se2aARxLZE4F5X7vUErwv89wQn/22EeAZo
         AT8+XCnKpMabkjKZ9aN8GPmAo4CEhfxxadCFpWd2smIF/z2b6+x+x1QRCaSqJakcATu2
         wxbChm2C7cHLzIeoMbHbXw29orv3pwcbAwC/k=
Received: by 10.42.140.202 with SMTP id l10mr188681icu.426.1286520474206; Thu,
 07 Oct 2010 23:47:54 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Thu, 7 Oct 2010 23:47:54 -0700 (PDT)
In-Reply-To: <7viq1dwg8v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158475>

On Fri, Oct 8, 2010 at 04:49, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-=
update-index.txt
>> index 74d1d49..0999950 100644 Documentation/git-update-index.txt
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -18,9 +18,9 @@ SYNOPSIS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--skip-worktree | --no-ski=
p-worktree]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--ignore-submodules]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--really-refresh] [--unres=
olve] [--again | -g]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--info-only] [--index-info]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[-z] [--stdin]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--info-only]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--verbose]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[[-z] --stdin | --index-info]
>
> Hmm, this requires | to bind tighter than [] around -z, but that is a=
 bit
> counterintuitive.
>
> Also, you can put -z much earlier, e.g. "update-index -z --add --stdi=
n",
> and your version gives a false impression that we do not allow that.
>
> Writing it as "[-z] [--stdin | --index-info]" would be much easier to
> read, even though it won't convey that -z will be no-op unless we are
> reading from the standard input, either with --stdin or --index-info.
>
> I actually think we can easily lift the "must be at the end" limitati=
on
> from both codepaths.
>
> Move the --stdin codepath to a separate helper like read_index_info()=
,
> remove the limitation, and add a new limitation that --stdin/--index-=
info
> can be given only once (as the reader will read thru EOF and the seco=
nd
> call to the reader won't help us). =C2=A0And do the reading after pro=
cessing
> all the command line stuff (i.e. move read_index_info() call after th=
e
> option parsing loop), to allow "update-index --stdin --add hello.c" t=
o add
> new paths read from standard input and also hello.c was given from th=
e
> command line.
>
> Wouldn't it make much more sense to spend brain cycles to write and r=
eview
> such a patch, rather than documenting an unnecessary limitation?
>
> Hmm?

As the subject suspects, the main intention was to document that -z
applies also to --index-info. The reminder is only falloff while
fixing this inconsistency in the documentation.

So, yes we should have spend more time to remove this limitation that
they need to be the last option.

I will prepare a patch which handles only the -z/--index-info
documentation issue.

Bert
