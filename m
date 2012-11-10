From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: t9350-fast-export.sh broken on peff/pu under Mac OS X
Date: Sun, 11 Nov 2012 00:11:50 +0100
Message-ID: <CAMP44s0dQ8EeCkHo8Lh3odG3qQoeLFModec+7doLeTHnZoJ_pg@mail.gmail.com>
References: <509E66B0.3040308@web.de>
	<CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com>
	<7v4nkxozep.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 00:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXKGC-0004js-5g
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 00:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab2KJXLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 18:11:52 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44356 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2KJXLv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 18:11:51 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5196436oag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 15:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CurLvfuH3ZsEqG3To4GrvAuZdHvVhyiS6eEbcxO7P+E=;
        b=L3g/nVG2Gm/9STFZ9AwoGGYHTt9J1X2FezMsO9c1pUWJAGvXqv7xQA8dzAvI1g0Vd6
         sRW5Ok2qtS4hyCNgnJjSEzORxL7uwZn8RRHSrToCf8fZZYrMud6Keeb9La+HAOsxaB5N
         TJqRD9dznMcZ6/zki/+M2OtgBpkLoFTuaFP7aLJFnMmd7l3hbKWAJACu5Qggu+Bl0oZe
         zseV9throxFR1eJUKzS8wKGvVIpgOv7oxXBAInEC46TyXfA7pyu8JnLjP0YC8F4aZMNi
         LHm93L4M3XSIJoUxmdz7j8ekaeWJHptFvTsdvHEJQzqQbtXqdyzODfW2tlNYBDEOqkqo
         +Q5Q==
Received: by 10.182.116.6 with SMTP id js6mr11797184obb.82.1352589110735; Sat,
 10 Nov 2012 15:11:50 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 15:11:50 -0800 (PST)
In-Reply-To: <7v4nkxozep.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209312>

On Sat, Nov 10, 2012 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sat, Nov 10, 2012 at 3:37 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>>> The short version:
>>> echo -n doesn't seem to be portable.
>>> The following works for me:
>>
>> Right, I was supposed to change that to:
>>
>>   true > marks-cur &&
>
> Please make it like so:
>
>         >marks-cur &&
>
> No command is necessary when creating an empty file or truncating an
> existing file to empty, and no SP between redirection and its target.

That hangs on zsh (presumably waiting for stdin).

--=20
=46elipe Contreras
