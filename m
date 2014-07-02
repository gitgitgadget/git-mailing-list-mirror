From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] enums: remove trailing ',' after last item in enum
Date: Wed, 2 Jul 2014 13:08:16 -0700
Message-ID: <CAL=YDWmz+aQeDAukmH6mweX3q3Sn0g8XYzLxKKGgcQeO3BZNJw@mail.gmail.com>
References: <1404325445-17914-1-git-send-email-sahlberg@google.com>
	<20140702195805.GD5816@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 22:08:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2QpJ-00038p-Up
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 22:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955AbaGBUIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 16:08:18 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:38539 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbaGBUIR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 16:08:17 -0400
Received: by mail-ve0-f171.google.com with SMTP id jz11so11911229veb.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k6B93mJULa9vojd3pdr9dRfVtTXY9VvNXsqspSH4Mo8=;
        b=lOyb47jRuQGbeu9qwBaqF53MPmZveZ35qV6MDQHWV3MjGCCBu3Z+6R7qxzFePvNgDB
         d168goA8LJWmsqpZfB/R/R/nb8+iXZyxc4JLkP2JHIgblENDyNJOfRw2Qs/vPIGXQsil
         iuIDgQnevzgcLOnMS1lwXExQTVf7K5Fxbn8tbgKh1w6Uop86H1Yb4MWgGM+sBsUiLSqM
         B2GyKqBnDUTgtPzY1j7mMpFf+ezyD90XtY4R8D12pqBdLUhMN8RRa+SQhNgBiiCYdfXm
         vUpoCU1flHwi5dwKfBK/PCDu64CT+p68zcjMItBnhdw4U0p+R9AzbdDPp1pLPPw4niY7
         wHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=k6B93mJULa9vojd3pdr9dRfVtTXY9VvNXsqspSH4Mo8=;
        b=UoKJrt/v9t+SX9caQYkQoCq94eXf62rerp1FCpcQbVW5x6kvwFnbB7ot/MrfNug6v7
         m2MdyNS1Lcsi6abFzNZhs1oKueXI/N4WQqyU9zOC5B144y3BPqHSN4uerNNcY/fAEpLL
         jdyZf+OBpRGxqDhmQ5SBWRBzQOeMWjhMwDjQaGBB94hWRwckYGFD088JmDzlLC4r3IP3
         2M+TWcbiKdoO0sCjHy5A65ZIQ9pE3UaQ/jFlsG2ohiOFJwz9BJsvx7e1NUoplKOCJe4D
         wwOyViTjRX9s8BZwIdWIssfBI9P3kc+jaZk7QoaY0m8AnMj03P+RA+fNlLOS9sjBLBUm
         yQfw==
X-Gm-Message-State: ALoCoQkDwN25jkt569RycZ6akeXMUB+ofFuHskatYntJ0HI48mFlDL+7/7FMvVKpnIVO3mI3LTB2
X-Received: by 10.52.172.5 with SMTP id ay5mr63652vdc.38.1404331696617; Wed,
 02 Jul 2014 13:08:16 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Wed, 2 Jul 2014 13:08:16 -0700 (PDT)
In-Reply-To: <20140702195805.GD5816@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252838>

GCC can check/error for this with

--pedantic -Werror




On Wed, Jul 2, 2014 at 12:58 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/clean.c | 2 +-
>>  builtin/tag.c   | 2 +-
>>  pretty.c        | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> Is there some gcc option or other tool that can automatically detect
> this kind of problem so the regress/fix cycle doesn't have to repeat
> too many times?
>
> Looks like v1.7.2-rc0~32^2~16 (2010-03-14) and v1.7.4.2~34 (2011-03-16)
> tried to fix this in the past.
>
> Using the test from v1.7.4.2~34 also finds enums with trailing comma
> in
>
>  grep.h
>  log-tree.c
>
> Thanks,
> Jonathan
