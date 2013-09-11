From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/3] Fix MSVC compile errors and cleanup stat definitions
Date: Wed, 11 Sep 2013 18:16:05 +0200
Message-ID: <CAHGBnuOFYS-9+h0H3VD5X-EbZKX9nENaZfAZbLUm9zwDtr-3SA@mail.gmail.com>
References: <522FA959.80108@gmail.com>
	<xmqqa9jjuypf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJn5T-0004bx-6F
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab3IKQQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:16:10 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:40211 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab3IKQQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:16:07 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so7447756lab.26
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vu0RjJrrRIBhQzj8kkbi6muO2dyfEaKfWCkuyChz+xg=;
        b=OHreQ6gFHCjApogVNvjaW/LuTJYxN+dH2uK+MT7Z0Lw74FtilQgSMNN8YrkV8rwnpq
         n1BFMpwrQhjZtOzJeQDiZjFNAjfuT070lzwvZzRLSXmZEN4Ft09DlYrfrC9JLTnJLYZK
         rwHDj47qx+HF4IsI8T4QiMKDJDxa0KCHK9TikV7tpX5WHBz1lRbw5xmbYkF21yu7dOku
         Y3yb50yVzc2KxeiSyO7ULfJcFNTxuUZ6yRU+q4R2xJTiglE4k6tl92t+ZeyrDf9PjpGZ
         S6xGhD922qGN5Gh4Vg/Yj6R+j2eVgZVj9oTUvjTX8Xlc1cpClzDtEVN4zISWXBbnJGLB
         eGaA==
X-Received: by 10.112.72.229 with SMTP id g5mr3370970lbv.10.1378916165883;
 Wed, 11 Sep 2013 09:16:05 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Wed, 11 Sep 2013 09:16:05 -0700 (PDT)
In-Reply-To: <xmqqa9jjuypf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234576>

On Wed, Sep 11, 2013 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> A few minor fixes for the MSVC build.
>>
>> Also here: https://github.com/kblees/git/tree/kb/fix-msvc-stat-definitions
>>
>> Karsten Blees (3):
>>   MSVC: fix compile errors due to missing libintl.h
>>   MSVC: fix compile errors due to macro redefinitions
>>   MSVC: fix stat definition hell
>>
>>  compat/mingw.h   | 21 +++++++++++++++++----
>>  compat/msvc.h    | 15 ---------------
>>  config.mak.uname |  1 +
>>  3 files changed, 18 insertions(+), 19 deletions(-)
>
> I won't be a good person to review, suggest improvements on, and/or
> judge these patches.  I'm Cc'ing regulars who work on mingw port for
> their help and Ack.

Acked-by: Sebastian Schuberth <sschuberth@gmail.com>

-- 
Sebastian Schuberth
