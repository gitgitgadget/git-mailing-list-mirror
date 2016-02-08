From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Add Cc,Tested-by list while 'git commit'
Date: Mon, 8 Feb 2016 13:25:00 +0100
Message-ID: <CAP8UFD3-rBUxM=6F41-6BCiRhfO5BFO5_ds4xBfYt6_QeceAmQ@mail.gmail.com>
References: <CAD6G_RQyTYPzFBb5Sm9zzAXAe48Ln08Jd7W0aecUN-hYoVy+gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jagan Teki <jteki@openedev.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 13:25:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSksQ-0006TS-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 13:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbcBHMZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 07:25:03 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33557 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbcBHMZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 07:25:01 -0500
Received: by mail-lb0-f171.google.com with SMTP id x4so82972846lbm.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 04:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VsE4mvT2bk47PKHvE0Na8XMtb1fAvGqTFkXJJm+Gbrs=;
        b=BWSrlOo1CLYuZe5w0F3XPJrlkm/6kYCtnVs7+u03UM1Ka2+3f1jkqzkbZyrlyT1a7X
         lpMcPjxQ/53rUSxoEjB4oV9Sd/9ep+jJMpDe/KL+Phse3FHSz3yrMKW1cCiFxhxNDbpC
         J4Xpl0LPq3UjZKS2GsRg0orVckcjtAqMmCNnVJoGeMEZWIIOkJ/Xd1leGPY8NgQDzhrd
         rOYQGG6nb1+tuyAOG4xs24OMBqPGHMGu4UakWcYbsxnaWN4KYRI8yBPUFje0g4/7IYhf
         6LA1GpuFYqWuOrilG4lq4bq9HaWkC/Pu+8ivV0f51Hqkyh2bGs6PwNzchtcet98MJe0y
         aEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VsE4mvT2bk47PKHvE0Na8XMtb1fAvGqTFkXJJm+Gbrs=;
        b=NI7Cxo85iNdmoXi5nS+FgZ8/1SP1v+FBP5BQYaKLOazv23SXJoRYpjSnd43vBA1UT6
         FpNVAEwAbDPbSvtqCTV/wlyuPZco2vbgvoa62Ah3+zsVxSUIW7Kmd0hZSQEKFjceLX9k
         kgT/xS+WthP6BKA7eGJExLneeYz6Nafovhuf0IzAoe7t7SQWrRbqp5nfQZy+L1rx9vPW
         9mKMFDnZiH/Uy38L5U7TFYeGw96K8ww0poQ78c7jJ33d7Te+7OKMEU5w4Xf4Tf8O0Bjn
         C61yQubuYhAEqKf17kD+PQQUQkbc+q/MgBcsrNrRdCat8VKRxoIBXlwdnBvrYgUc50XD
         6j3A==
X-Gm-Message-State: AG10YOTtjkU8cqncPsyjZJFtZ7siGKYyjJOq0DcpcGOgVPmCO33vVhZwlWv/2MUqMdha6oo5qAmIfqPN57HXgA==
X-Received: by 10.112.168.5 with SMTP id zs5mr11963438lbb.56.1454934300291;
 Mon, 08 Feb 2016 04:25:00 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Mon, 8 Feb 2016 04:25:00 -0800 (PST)
In-Reply-To: <CAD6G_RQyTYPzFBb5Sm9zzAXAe48Ln08Jd7W0aecUN-hYoVy+gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285760>

On Sun, Feb 7, 2016 at 4:23 PM, Jagan Teki <jteki@openedev.com> wrote:
> Do we have any git config options to add Cc and Tested-by list like
> Signed-off-by is fetched from git config.
>
> example:
>
> $ git commit -s
>
> Cc: Arjun Ani <arjun.ani@abcd.com>
> Tested-by: Jagan Teki <jteki@openedev.com>
> Signed-off-by: Jagan Teki <jteki@openedev.com>
>
> Please share if we have any inputs to solve this.

You may want to take a look at 'git interpret-trailers'.
