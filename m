From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu, 7 Oct 2010 21:39:12 +0200
Message-ID: <AANLkTinJhKHxds3e+SwYHCbN4S_tcvE1P8j4mgwh+W00@mail.gmail.com>
References: <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
	<081ad1459d5b1584cbe474581bd3a01d0d58d11d.1286477945.git.bert.wesarg@googlemail.com>
	<87ocb5u75s.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:39:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3wJG-0006EF-Uv
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab0JGTjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 15:39:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60291 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab0JGTjN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 15:39:13 -0400
Received: by iwn9 with SMTP id 9so214537iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n/oyzWHLLPaDo+7ecP0kW29Bz0g/4bDDrPpoT3RF+A8=;
        b=eTe0rwfIy0DBwvolyMX2UTvJidCSRjajqHbFFXmCI0t3QVCqmNqYxwig2QbX7tdAJD
         fUao7djow+LdlBLg7HGHNs2riCJIs9BSVyabXQ6+7EkcvHRZGQvM4fbt/8O8gj3Z+bW9
         ZgaZ0Kl5N9tPkTfnLBjJK8+Pl11LGoIFyrt3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oytp6tuTtiLFvvmdsKHw0nuh3hVwDHaSsmCwtr4PypruRojJgTMHfcIPLsCNjHPYoa
         aQAjN1AQnh0trv6X/pd3fUMiI+bcgeVwlXVAOkKgY1jYV42Q4gjor1in2OpluiRe9vTy
         JF5BX0UmSoaW/9qtPGBut4ydGWIfYnUv4rB0U=
Received: by 10.231.10.134 with SMTP id p6mr1383324ibp.50.1286480352633; Thu,
 07 Oct 2010 12:39:12 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Thu, 7 Oct 2010 12:39:12 -0700 (PDT)
In-Reply-To: <87ocb5u75s.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158448>

On Thu, Oct 7, 2010 at 21:36, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem=
@gmail.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> Also mention, that --stdin and --index-info needs to be the last
>> option supplied and indicate this in the usage string.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> ---
>> =C2=A0Documentation/git-update-index.txt | =C2=A0 13 +++++++------
>> =C2=A0builtin/update-index.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A02 +-
>> =C2=A02 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-update-index.txt
>> b/Documentation/git-update-index.txt
>> index 74d1d49..022c0fc 100644 Documentation/git-update-index.txt
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -18,10 +18,10 @@ SYNOPSIS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--skip-worktree | --no-ski=
p-worktree]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--ignore-submodules]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--really-refresh] [--unres=
olve] [--again | -g]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--info-only] [--index-info]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[-z] [--stdin]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--info-only]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--verbose]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--] [<file>]*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[[-z] --stdin | --index-info]
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[--] [<file>]
>
> If you want to remove the asterisk after all, then please make it
> `<file>...', not `[<file>]'.

Sorry. That was only by accident. Updated patch will follow.

Bert

>
> =C5=A0t=C4=9Bp=C3=A1n
>
