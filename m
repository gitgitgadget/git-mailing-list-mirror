From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Trivial fix: Make all the builtin usage strings to use 
	the same pattern.
Date: Mon, 21 Sep 2009 17:05:35 -0300
Message-ID: <a4c8a6d00909211305h6c29d88bi9ddf9a7003f5c937@mail.gmail.com>
References: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
	 <pN7ragma8Ra75P8lN7iHuXE6FyUXHXFlnHUVFZqJV4WM7w5mCkVHcQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Sep 21 22:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpp9H-0002Wh-C7
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 22:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbZIUUFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2009 16:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbZIUUFe
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 16:05:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:52543 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbZIUUFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 16:05:32 -0400
Received: by fg-out-1718.google.com with SMTP id 22so991561fge.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6aOXSHD2aC3M7TKeqkPygZeUkgB2roDJmQ0ttvRQu4I=;
        b=jDJApiTb+iHDq5LHFszALe1+tiHrzsqCZL8fLTA9Wzg6UUu0VpBYUuasnKjguKSgNb
         qFagtFIpZCElH14y7crKo0lac426R7KkujhqluUz1vgPgjWtO1zML0UcvfvN3768JB5z
         HmC9qbK5Uw5dqWRLLChdHPZtBJSK6NntrsTvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iexBIit0sCACxAmjj3WX/1zNdLCtaTE8DwQqecJFhyuauNDArV5WRlEqLwe3xytHWt
         9X8eq8Ye2g/dauWBMhJCBEbLpqcBrjvGL7udOcQsWvDR7ulIJnt1aObNPUmFcM24QNt8
         lI2beIzzzmR/rh0Q/xLBo4w1Bl847JWtzijFA=
Received: by 10.86.232.5 with SMTP id e5mr104769fgh.27.1253563535488; Mon, 21 
	Sep 2009 13:05:35 -0700 (PDT)
In-Reply-To: <pN7ragma8Ra75P8lN7iHuXE6FyUXHXFlnHUVFZqJV4WM7w5mCkVHcQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128909>

On Mon, Sep 21, 2009 at 12:28 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> Thiago Farina wrote:
>> They follow the pattern of file name:
>> File name pattern: builtin-command-name.c
>> Usage string pattern: builtin_command_name_usage
>>
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>> ---
>
>> diff --git a/builtin-blame.c b/builtin-blame.c
>> index 7512773..4adae84 100644
>> --- a/builtin-blame.c
>> +++ b/builtin-blame.c
>> @@ -21,10 +21,11 @@
>> =A0#include "parse-options.h"
>> =A0#include "utf8.h"
>>
>> -static char blame_usage[] =3D "git blame [options] [rev-opts] [rev]=
 [--] file";
>> +static char builtin_blame_usage[] =3D
>
> Should this one also use 'const'?
It can use const here. I will do this change in the next patch.
>
>> +"git blame [options] [rev-opts] [rev] [--] file";
>>
>> =A0static const char *blame_opt_usage[] =3D {
>> - =A0 =A0 blame_usage,
>> + =A0 =A0 builtin_blame_usage,
>> =A0 =A0 =A0 "",
>> =A0 =A0 =A0 "[rev-opts] are documented in git-rev-list(1)",
>> =A0 =A0 =A0 NULL
>
>> diff --git a/builtin-count-objects.c b/builtin-count-objects.c
>> index 1b0b6c8..fbe0972 100644
>> --- a/builtin-count-objects.c
>> +++ b/builtin-count-objects.c
>> @@ -65,7 +65,7 @@ static void count_objects(DIR *d, char *path, int =
len, int verbose,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> -static char const * const count_objects_usage[] =3D {
>> +static char const * const builtin_count_objects_usage[] =3D {
>
> This one is different from the others. =A0I assume 'char const *' is
> the same as 'const char *', though I'm used to seeing the latter
> form. =A0If we're going for consistency, maybe this should be changed
> too. =A0Ultra minor nit-pick. =A0I noticed it, so I mentioned it, but
> its your choice.
To maintain the consistency I will follow the latter form, since all
others are using "const char *".
Thanks for catching the ones that I missed. I will update them in the
next patch.
