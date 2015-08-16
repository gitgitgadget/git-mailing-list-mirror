From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 00/13] port tag.c to use ref-filter APIs
Date: Sun, 16 Aug 2015 13:45:57 +0530
Message-ID: <CAOLa=ZTGpg1AfkrFhspsZd60z4yow+rxG-_HZ=EaUhv_k3i-Uw@mail.gmail.com>
References: <1439661643-16094-1-git-send-email-Karthik.188@gmail.com> <CA+P7+xpWFT=NJC2VdnamjA86LcYRc4z__La91ca_yGdtFPHahw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 10:16:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQt7M-00082H-3P
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 10:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbbHPIQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 04:16:29 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33347 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbHPIQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 04:16:27 -0400
Received: by obbhe7 with SMTP id he7so90724046obb.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aUKi3m+aTAtEec3IYMtbgriiZ5z77qP4JNK6Y0GZg9g=;
        b=RTTn6+1Gne8fvyhUGE+QJ3sCO3/ZcoPTnVGEOr21zi82FpDlZeGYSqjniF6RBDIZH9
         TigtMFMmXntobGOuKAB7+mFjcDmLKSLs8jy9RP1rJe7IqLudvoH45TzNXcuEhBxkb4HT
         KZYBjGtga9zWeZhba6/Lbx/21M73V2e3kQda4kAqKmRw+u9PjJ56Eo6a4g12TMEean3+
         MABrSr967mJXzdG/TDg570PNNZ2vJ+rHXuoNPZP08IEZ9sIi4xtejJQJVgD3MgmX2CEa
         dxbBw77M3cgiAHSmmCyDMF+qVIEvH0qZFeZRaYtx9c2KzO01R8pcIwcQgpOmlOfQtQNk
         FEPg==
X-Received: by 10.60.65.68 with SMTP id v4mr38698750oes.84.1439712986775; Sun,
 16 Aug 2015 01:16:26 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 16 Aug 2015 01:15:57 -0700 (PDT)
In-Reply-To: <CA+P7+xpWFT=NJC2VdnamjA86LcYRc4z__La91ca_yGdtFPHahw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276016>

On Sun, Aug 16, 2015 at 1:08 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, Aug 15, 2015 at 11:00 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
>>
>>  align::
>> -       Implement an `align` atom which left-, middle-, or
>> -       right-aligns the content between %(align:..)  and
>> -       %(end). Followed by `:<position>,<width>`, where the
>> +       left-, middle-, or right-align the content between %(align:..)
>> +       and %(end). Followed by `:<position>,<width>`, where the
>
>
> Everywhere else in the code seems to now put position second now, but
> the documentation here doesn't say this is allowed or required.
>

Oops! you're right, that needs to be swapped.

-- 
Regards,
Karthik Nayak
