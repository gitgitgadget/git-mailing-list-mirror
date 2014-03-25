From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 015/144] t0204-gettext-reencode-sanity.sh: use the $( ...
 ) construct for command substitution
Date: Tue, 25 Mar 2014 10:51:36 +0100
Message-ID: <CA+EOSBk0p3ZXafAMWKjvqcOYDHR3ZSFvxFJ1ixqKuouPPqZ9pg@mail.gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
	<1395735989-3396-16-git-send-email-gitter.spiros@gmail.com>
	<vpq4n2m7jz7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:51:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSO1G-0004Bm-GT
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 10:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbaCYJvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 05:51:38 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:43250 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbaCYJvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 05:51:37 -0400
Received: by mail-vc0-f179.google.com with SMTP id ij19so222871vcb.38
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eGuI5n9fY0PjQ5uRIMnULj9QmQ8EvyjZeUevd/0HLZU=;
        b=GN7ZL0vP9DCLVX4XdEzQUso4wNfaQ/BvInB1DiauiFrS508VNBzLLj9YcebJeEU/Vr
         vNTnOMfOHaPHu1btD6R/tKMkHCR8EhEjE6lCTDRXgplDFvqDGVkVsDIP5nlqbEvdyvyb
         mg4OUFWkQ/5sjPHgsiXEVysDooPAiqWRc7E78tibp3GQuv1JRnQnrpXrKIuqgGY7GgQG
         /Y0PY9zCZNYL5yUd5fMJ1T25bCY05ZqwwxYbV5O/KdM7xCwwAuDgncaFi9hsL6erfdpb
         or2ffo45MQCjyBBQ2TRtu2tMDtjKBdqqDe9eiJy/zf8acLYe60meObVJyv2nLmEXRash
         +WZw==
X-Received: by 10.52.173.165 with SMTP id bl5mr37499823vdc.13.1395741096348;
 Tue, 25 Mar 2014 02:51:36 -0700 (PDT)
Received: by 10.52.15.33 with HTTP; Tue, 25 Mar 2014 02:51:36 -0700 (PDT)
In-Reply-To: <vpq4n2m7jz7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245023>

2014-03-25 9:36 GMT+01:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> --- a/t/t0204-gettext-reencode-sanity.sh
>> +++ b/t/t0204-gettext-reencode-sanity.sh
>> @@ -58,7 +58,7 @@ test_expect_success GETTEXT_LOCALE 'gettext: Fetch=
ing a UTF-8 msgid -> UTF-8' '
>>  # How these quotes get transliterated depends on the gettext implem=
entation:
>>  #
>>  #   Debian:  ,einfaldar' og ,,tv=F6faldar" [GNU libintl]
>> -#   FreeBSD: `einfaldar` og "tv=F6faldar"  [GNU libintl]
>> +#   FreeBSD: $(einfaldar) og "tv=F6faldar"  [GNU libintl]
>>  #   Solaris: ?einfaldar? og ?tv=F6faldar?  [Solaris libintl]
>
> I don't think you wanted this to be changed.

Certainly not. The change was made by an automated script, can happen
that i missed something.

Please skip this patch.

Thank you very much for the review.


Elia
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
