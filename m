From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Wed, 7 Mar 2012 17:10:48 -0500
Message-ID: <CABURp0rOFgwLu0pX0W5txOH=CH6Yb4NchYLaj91m1nMve_zjDg@mail.gmail.com>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org> <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5P51-0001y5-CI
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030692Ab2CGWLZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 17:11:25 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46496 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030652Ab2CGWLL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:11:11 -0500
Received: by lahj13 with SMTP id j13so7820665lah.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RWSkNma780MRL15ClnkzDgl8MugPhaSbIFHEF+1NpV4=;
        b=W+F9hUDdEQbVM3CUUXnSw2VjGS01OhfQ58hm4xqz6Sjhd5guWdTgY3Otwe/74fogTa
         ktkPwzXKJXbic4k2Qw7G30olh3Tt3amgUfkfcaGwe2V9r29uSr5WHncatP1D8tQlRpZs
         y0hgZ87HuptCeta1UiH70YTWFPPqxftCPQO7w0cxwElg6UwzmxfcW+bQFPQThE6wZvLd
         ZEAWlcPJcFoJISyReoFDh1mJaqvyCE8CNFlb8nyDs/8tbTpJbVOeOJwES1rVT2oRdWWO
         ClmfPIuhwVQ6blcHTKALI+H/sXfh/k3r+o20tuGv9DdzGPqyN8kOR0mu5l6RBsr+m9Rh
         TroA==
Received: by 10.112.24.4 with SMTP id q4mr1347823lbf.80.1331158269535; Wed, 07
 Mar 2012 14:11:09 -0800 (PST)
Received: by 10.112.8.133 with HTTP; Wed, 7 Mar 2012 14:10:48 -0800 (PST)
In-Reply-To: <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192491>

On Tue, Mar 6, 2012 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Vincent van Ravesteijn <vfr@lyx.org> writes:
>
>> From: Vincent van Ravesteijn <vfr@lyx.org>
>>
>> This adds the 'remaining' command to the documentation of
>> 'git rerere'. This command was added in ac49f5ca (Feb 16 2011;
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>) but
>> it was never documented.
>>
>> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
>> ---
>> =A0Documentation/git-rerere.txt | =A0 10 +++++++++-
>> =A01 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere=
=2Etxt
>> index a6253ba..b75d34b 100644
>> --- a/Documentation/git-rerere.txt
>> +++ b/Documentation/git-rerere.txt
>> @@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted=
 merges
>> =A0SYNOPSIS
>> =A0--------
>> =A0[verse]
>> -'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
>> +'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'statu=
s'|'gc']
>>
>> =A0DESCRIPTION
>> =A0-----------
>> @@ -53,6 +53,14 @@ useful for tracking what has changed while the us=
er is resolving
>> =A0conflicts. =A0Additional arguments are passed directly to the sys=
tem
>> =A0'diff' command installed in PATH.
>>
>> +'remaining'::
>> +
>> +Like 'diff', but this only prints the unresolved filenames. This
>
[...]
>
> =A0 =A0 =A0 =A0'remaining'::
>
> =A0 =A0 =A0 =A0Print paths with conflicts that are not resolved.
>
> Should be sufficient, I think.
>
> In fact, wouldn't this be more or less equivalent to "ls-files -u"
> without anything other than name part?

No.  When using  --no-rerere-autoupdate, git does not add autoresolved
files to the index; it fixes them only in your working directory.
'ls-files -u' still lists them as unresolved.  'rerere remaining' does
not list these autoresolved files.  'mergetool' uses this command to
avoid asking the user to resolve files which git rerere already
resolved for her.

ac49f5ca8 has a pretty complete description, though it may be a bit
too wordy for the the up-front synopsis.
2f59c9470 has a more complete justification.

Phil
