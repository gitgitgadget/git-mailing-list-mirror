From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/8] port branch.c to use the filtering part of ref-filter.
Date: Thu, 24 Sep 2015 11:31:43 +0530
Message-ID: <CAOLa=ZQHUcpOo4_cJ1JPb5CE8X_QL9cC+HFTxgO3FMvSwtUfbw@mail.gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
 <vpqsi65t0yi.fsf@grenoble-inp.fr> <xmqqbnctx7xr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 08:02:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zezbm-0001cb-KY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 08:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbbIXGCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 02:02:14 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36604 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbIXGCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 02:02:14 -0400
Received: by ykdt18 with SMTP id t18so64727595ykd.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fLsswtd0nyad/gR8+e2BJRnPTIaynJIwWbqIld4F4yY=;
        b=LHVsK3ZBUYKeLY3fJuiPJVeESm5g6JDv26igOXHwS0wyruqfJ9KjeU+V6X7Uj2/jRc
         1j6srwzNJ/HLgVR8MZbQawf7G9VvqjeB8r4jIMfOllhwl7/2eJg5jvwxFkJ1DrLLd4Zh
         XfOYOvV0BF6ae5FTswd9DCZ4IihEfOlE+yYhJY7EqMs8M1ML1hrDnBg+8YC9DyKJFU7K
         yMsJ9rIyFLwVG5qdSbA46vIpNpzJrnxUacRonC7DuHUvuoHVRVwrd9vP9dUFJmNerlSE
         k+igYGLgDmkWD+0bDF5d2foBmLOhrJLdn2iBjeUW80p6c/rpSjwJ1wGvSZuUFqQgDOK2
         4QrA==
X-Received: by 10.31.32.137 with SMTP id g131mr24322977vkg.2.1443074533164;
 Wed, 23 Sep 2015 23:02:13 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Wed, 23 Sep 2015 23:01:43 -0700 (PDT)
In-Reply-To: <xmqqbnctx7xr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278532>

On Thu, Sep 24, 2015 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> The series looks good to me. I did a minor remark on PATCH 5/8 but this
>> should not block inclusion.
>
> Thanks.  As long as the log message is telling the truth, I do not
> mind the actual lossage of the error message shown to the user.
>

That needs to be changed, I'll reply with a changed commit, thanks!

-- 
Regards,
Karthik Nayak
