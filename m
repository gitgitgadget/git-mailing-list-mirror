From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v15 00/48] Use ref transactions
Date: Fri, 13 Jun 2014 08:52:40 -0700
Message-ID: <CAL=YDW=MUURDOxV5q0Tg8AmwJ4Z0d16bYmw5YiKhVDrJxfWFSg@mail.gmail.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
	<xmqqoaxx4vwd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 17:52:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvTmf-00058v-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 17:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbaFMPwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 11:52:43 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:54949 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaFMPwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 11:52:41 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so2411863vcb.25
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+unasLQyyTwvWHX14W0d28FJYvO4fQL1Cqgzn6bOHt0=;
        b=VoLrTRSd+7CCIcK9rSrHd1Ezg6HJL2NaGl2pRNJldlG0lzec+/2FlTeSAFOvAiS/LZ
         tQcBec0HXRLNA7GrAKJf5gRCAw/22uZo+nHXtwV/ttQ+gSKkNymEURzLzhhccTycPkQQ
         NUtj55egCCyTiWuOp1IakTYCgi2funA/dv4VGamoElpLFGpB8/lqUoPFWB/AFsk2Vz+/
         ZJjt24Sklez/qpvof6N+d9IjSnrqa8WKZ9lDbuG3G0Pxd7sEmCi1VuhV2zYl/YXRib97
         mOAuOIF8OxJQquJ3Cc1jK7mQ1rxXlCL8PMuM0WhohFLpeOX/yjYNji3NalyQVFCnpZOd
         aOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+unasLQyyTwvWHX14W0d28FJYvO4fQL1Cqgzn6bOHt0=;
        b=a8BN//T3zTrLlugJDkrR8eUO82VITPrTJGVFU54pmn1qLdZUnODm1/DQjmknULt10y
         2AeTD73YtKVh+/Wt6aKZN27v3miY315nPYrEENMgha+XgB7Hcp7GUbQmWKwaEpv1IMRi
         3Vp+Q0+rTbYHrXg8ZZQS9zlXKL7Rvb9NRzVZcPNIfQWh6l12SaRnQuX/qN++VLwfpG0T
         DqGlq08KT4L50p09U+2AkYjlmQtqQ3G1b4LPGNU1HswV/NB+q3kTtXiDNFOBSq4ZN4++
         X/DAs3bTcrkiSlq/3JaZfRpIQ5pJe1ffF83D1njkcx8IW9KtMZ+vmKHwL5LTFQTrJXmD
         JXhw==
X-Gm-Message-State: ALoCoQncpirMtBFFduU/K5DIfjvhRpNEWcz9PDeC5AW/Ut2wltoIeezaj+c/sQi/rhGBgOX2LxK+
X-Received: by 10.52.14.9 with SMTP id l9mr1288780vdc.41.1402674760378; Fri,
 13 Jun 2014 08:52:40 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Fri, 13 Jun 2014 08:52:40 -0700 (PDT)
In-Reply-To: <xmqqoaxx4vwd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251604>

Looking at it, thanks!

I found two issues, I have just sent patches to the list for them.
You can just "fixup" these two patches in origin/pu?
Or do you want me to re-send the series?


regards
ronnie sahlberg


On Thu, Jun 12, 2014 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Final version.
>>
>> This patch series can also be found at
>> https://github.com/rsahlberg/git/tree/ref-transactions
>>
>> This patch series is based on next and expands on the transaction API. It
>> converts all ref updates, inside refs.c as well as external, to use the
>> transaction API for updates. This makes most of the ref updates to become
>> atomic when there are failures locking or writing to a ref.
>>
>> This version completes the work to convert all ref updates to use transactions.
>> Now that all updates are through transactions I will start working on
>> cleaning up the reading of refs and to create an api for managing reflogs but
>> all that will go in a different patch series.
>
> As this seems to be based on the old 'next' before it got rewound,
> it was a bit painful to rebase it on top of 'master' (so that it
> won't have to wait for other topics if we wanted to graduate it
> earlier than others).  It also had interactions with various topics
> still in flight in 'pu'.  I managed to coax it on 'pu' somewhere
> above the commit that is equivalent to 'next', but I am reasonably
> sure there are mismerges, as the conflicts were many X-<.
>
> I'd appreciate it if you can eyeball the result with
>
>   $ git show --first-parent -m 'origin/pu^{/^Merge branch .rs/ref-transactions}'
>
> when I push it out.
>
> Thanks.
