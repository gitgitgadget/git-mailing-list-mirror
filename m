From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Wed, 14 Nov 2012 13:01:01 -0500
Message-ID: <CACYvZ7g7nCgQmcnwJYxvx5hJ+Y8rCQOBQyWYLZOt8NT5BTwTrw@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<50A2978D.6080805@ramsay1.demon.co.uk>
	<50A2B2DF.1080704@web.de>
	<m2pq3h9ll1.fsf@igel.home>
	<CACYvZ7jwjVsW4=QSbxFVL8N269DE4=tv8_WvZ0gVOw6B+WLP=w@mail.gmail.com>
	<mvmvcd8f8ml.fsf@g208.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 19:01:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYhH4-0003qC-Vt
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 19:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745Ab2KNSBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 13:01:04 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:62341 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab2KNSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 13:01:03 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so575247lag.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0kOVFCRsLhBOznTJZj1gyshZsU8mXQpr0gYG0JStUaw=;
        b=0KF8VArHiNggIk+UwH/TspBLJR1dCBc3q5IhQH+6NcADRAeQO8vimz036FD/7BPYtH
         bTg1ItJHjJdGvXSAFUBYO5U9ev6EZvuyjksi5yLZk2ljeV2TS9PM4OqjDK/WdaXUgCT5
         aC+49gfP6W53h7KCWg3WpvdtY9R+MXLsUVDZVRPfU+MTOtB4ej55VOlyPatZUHULilBx
         b92Eme38mKHPKBnPb8QXPTlSKsLsm31yJrESQXUVfCRotXR7GT43n2YhpNsosTODnHI+
         CkWTYQtTDEIVvU0enuCO/BcBJhQu7YxRHoTkKTpsx6rS8+Jyj1Vh4vjyRD1ZkZR0cFva
         D0og==
Received: by 10.112.46.35 with SMTP id s3mr10865181lbm.88.1352916061613; Wed,
 14 Nov 2012 10:01:01 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Wed, 14 Nov 2012 10:01:01 -0800 (PST)
In-Reply-To: <mvmvcd8f8ml.fsf@g208.suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209735>

>>> I cannot reproduce the problem (on openSUSE 12.2).
>>
>> You do need multiple CPU/multi-core machine, as I got it.
>
> Which is what I have.

Then try to build *vanilla* git 1.8.0, not OpenSuSE's one (with a lot
of patches inside srcrpm).
