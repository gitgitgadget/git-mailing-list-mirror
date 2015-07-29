From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Wed, 29 Jul 2015 21:40:23 +0530
Message-ID: <CAOLa=ZQfmiYGgnPmLrhHzQGFiPOFZ=76dpR5dPJ-gJZZgOEc8g@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> <vpqwpxk215y.fsf@anie.imag.fr>
 <CAOLa=ZS=bMnVDjGL0vb08t2XCTqH7tG9+QuPyz3D9wb7hCbpaA@mail.gmail.com> <vpqio93eyqs.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTwY-0008LJ-JO
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbbG2QKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:10:54 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35091 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbbG2QKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:10:53 -0400
Received: by oihq81 with SMTP id q81so7626737oih.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/SRLhpqfXn+/ijU5VBufout65ZKJRTP6VrjWsWp0w3I=;
        b=H0Yj/gohAA5CJ3hHfvNhFLOTsF2k6B9/IguyFKo6zyMNSqT4M5KzsFt9+50yyt43Fr
         hLhsM/P2W0NU8D9hN6JrHtd8UO6Yv7qApx8YuyxzVvfkNQjdNUA3XNcWbssFTsndifdb
         EGKukJYHnIrvZl0qwaVg2sXWQjkxdz7a7enzQBJz9koSB19ZFCl1WMhYwoXF/NG7X19f
         BdT6HbVkKlbQoGCflvDKGSfuZj3d09vKd28E8Ug235ALSlm/i5L9BF0klJ0zLcHTzhG2
         /pM7UJlHVFJU6TAcYeWnM2R/964Su2mhk448C/PYxnMdQXYmSJm5+zbMQ5ejpT+4aSNX
         ALHg==
X-Received: by 10.202.186.132 with SMTP id k126mr39492947oif.60.1438186253181;
 Wed, 29 Jul 2015 09:10:53 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 09:10:23 -0700 (PDT)
In-Reply-To: <vpqio93eyqs.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274915>

On Wed, Jul 29, 2015 at 9:34 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Ah, I hate making grammatical errors, Even though I check it always gets away.
>> Anyways waiting for Junio and others to reply on this version. Could do a resend
>> for this series if needed.
>
> If you took all my remarks into account, I think it's worth a resend as
> it should make it easier for new reviewers.
>

Correct me If I missed something, but the only remark for this series
were the ones mentioned
above right? I mean branch.c being an RFC patch series and separate from this.

-- 
Regards,
Karthik Nayak
