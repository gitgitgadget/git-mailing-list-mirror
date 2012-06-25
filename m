From: Thomas Badie <thomas.badie@gmail.com>
Subject: Re: [PATCH] git-add--interactive.perl: Remove two unused variables
Date: Mon, 25 Jun 2012 12:12:51 +0200
Message-ID: <CAFjFENo7qLTZHrEtPPBLGzp=h0w69C+7C2zfiJJmqFANmaWAgg@mail.gmail.com>
References: <4FE7889E.2020009@gmail.com>
	<7vfw9khrrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 12:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj6Hx-0006bM-0e
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 12:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab2FYKMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 06:12:53 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55849 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638Ab2FYKMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 06:12:52 -0400
Received: by qabj40 with SMTP id j40so1205078qab.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xrXw74nL5Ufzr0gntPYWrCK46kt2XsS/wU9OBAyj2hg=;
        b=SxNUEGnftVJpjRlxqVXi5n2Zibe2qmFcMNrNhnxszo8qluk7LC/2rT9cQ5je18fIWq
         9pC0MlWeX5kgy7f42v7Dw1zunzMtkUiGEVZ3vO8vKxDCPZo0wyQOUuzTs1qQl7tguZ1P
         uN6mt7VmXWQw0KE3C1Gum4jtMz1ZLBJaceJbH4V4uqSrIG+CE2kD0FRICX9LwIls43YM
         rrHAsaaREWD2w657XvycIvUM75qpOgcOqI8wVPL3h42XX39plaZCGWepGnSUdMxTV5CJ
         lOokjR+5YJY0GxKyKZ+v76oHUdUXzXHGpilrSfOS8fss3PpgYPGf4es++SyJRC0oklQC
         qtyg==
Received: by 10.224.181.6 with SMTP id bw6mr19753783qab.74.1340619171511; Mon,
 25 Jun 2012 03:12:51 -0700 (PDT)
Received: by 10.224.4.39 with HTTP; Mon, 25 Jun 2012 03:12:51 -0700 (PDT)
In-Reply-To: <7vfw9khrrt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200562>

2012/6/25 Junio C Hamano <gitster@pobox.com>:
> "Thomas \"Enki\" Badie" <thomas.badie@gmail.com> writes:
>
>> The patch 8f0bef6 refactors this script and leaves the `$fh' variabl=
e
>> unused in `diff_applies' and `patch_update_file'.
>>
>> Signed-off-by: Thomas Badie <badie@lrde.epita.fr>
>> ---
>> Hello,
>> This is my first patch. It introduces a really minor change, and I
>> also want to be sure the way I submit it is the right way. Thanks :)
>
> The patch submission is almost perfect, except that:
>
> =A0(1) the patch seems to be whitespace damaged; and
>

The only damage I see is a space on the deleted lines which doesn't
exist in the patch. Is that you're talking about ?
I need to investigate why it appears...

> =A0(2) the author of the problematic commit should have been Cc'ed
> =A0 =A0 (especially when he is still an active participant on the lis=
t)
> =A0 =A0 to give him a chance to Ack it (I'm adding Thomas for this).

My bad, I forgot to check if the commiter were still active. I'll check=
 it
for the next time.

> Thanks. =A0I like that you identified why this is a good thing by
> quoting the problematic change.

Thanks :)

>> =A0git-add--interactive.perl | =A0 =A02 --
>> =A01 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> index d948aa8..710764a 100755
>> --- a/git-add--interactive.perl
>> +++ b/git-add--interactive.perl
>> @@ -1067,7 +1067,6 @@ EOF
>> =A0}
>>
>> =A0sub diff_applies {
>> - =A0 =A0 =A0my $fh;
>> =A0 =A0 =A0 =A0return run_git_apply($patch_mode_flavour{APPLY_CHECK}=
 . '--check',
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 map { @{$_->=
{TEXT}} } @_);
>> =A0}
>> @@ -1514,7 +1513,6 @@ sub patch_update_file {
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (@result) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0my $fh;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my @patch =3D reassemble_patch($head-=
>{TEXT}, @result);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $apply_routine =3D $patch_mode_fla=
vour{APPLY};
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&$apply_routine(@patch);

--=20
Thomas "Enki" Badie
