From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Fri, 15 May 2015 07:40:53 +0200
Message-ID: <CAHGBnuNvTZ27CCquHHtC5bQFkG2k-+SDYw-6U2TRzzHyFiFwJw@mail.gmail.com>
References: <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
	<1431638653-9356-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 15 07:40:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt8Mk-0003MM-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 07:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbbEOFky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 01:40:54 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34591 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbEOFkx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 01:40:53 -0400
Received: by igblo3 with SMTP id lo3so29052895igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 22:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hoip0QESpkPKRTTvHrBhsLgehkdjWV9ollc83r+vFYo=;
        b=WjC+wW3LMyOK8+RFenL5IkN+giI80zyn3BgRRm2xvahgMkXtVdIFcSiyshwR5981AP
         RT8RHSc0nbOFGXWI+1kh3MBX4/pHHMtn0D1DvOSoRXQMcZopYkdP1XwRAI68RREuiBCj
         a3Pn3iGymQ3zM1mw7GItQ7w9SQjEDnfr/eQgweHiAW+iL6+ny0sw7Z+lX+2381ASucCY
         /D2xFK3cJx0UPvI8NFVvMIEvMmTtLLW6c48f4iuMbHr0WjBhTBLwjiVg3W9mH0WoSRnY
         VLRvdL5kRtXxx2UWN3KfQupMVa8440QbGjncAQk45G823EqPrq3FedkmNm/XdR6YZhDJ
         +uhA==
X-Received: by 10.42.126.10 with SMTP id c10mr3757046ics.66.1431668453089;
 Thu, 14 May 2015 22:40:53 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Thu, 14 May 2015 22:40:53 -0700 (PDT)
In-Reply-To: <1431638653-9356-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269125>

On Thu, May 14, 2015 at 11:24 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

>> $ echo "$PROGRAMFILES(X86)"
>> C:\Program Files (x86)(X86)
>>
>> So it seems to resolve only the $PROGRAMFILES part and appending the
>> literal "(X86)". Not sure how to tell Bash that "(X86)" is part of t=
he
>> variable name.
>
> It would be ${PROGRAMFILES(X86)}, but POSIX says that variable names =
can
> only contain alphanumeric characters and underscores, and Bash adhere=
s
> when it complains about it in Johannes' example above.  Not sure whet=
her
> there is a clever escaping that could make it work, I couldn't find a=
ny.

Right, I did already try that curly-braces-style of quoting, and
MSYS1/2 both give:

$ echo ${PROGRAMFILES(X86)}
sh.exe": ${PROGRAMFILES(X86)}: bad substitution

I couldn't find any other style of quoting that works, either.

--=20
Sebastian Schuberth
