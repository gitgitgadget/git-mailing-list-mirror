Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907201F42D
	for <e@80x24.org>; Thu, 24 May 2018 19:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161173AbeEXTPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 15:15:10 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:40732 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034546AbeEXTPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 15:15:05 -0400
Received: by mail-yw0-f178.google.com with SMTP id p144-v6so929795ywg.7
        for <git@vger.kernel.org>; Thu, 24 May 2018 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6iMpxjuaGGEuY42AMf8DCkufbUTKjYhJ2yz5u9e5qn4=;
        b=CcWqk/32znU72WljqRS/QlQm7gFHwlrvvsnS/Noj+JQ42Hxhyl++BsbXQjNGdgUeLY
         /to7W05+at4s0Lb8SwZS3jd09qfCipvs7APVKj37IzGgOQWlbeDYy6F0qscbELcqApUb
         3SeBG0/7RJDlpdnu0dPwrijYAEXTaSkCmWsWPK1qydDQCOYkYgrQ5CHfC7AVUkPf0C6M
         bjxL2g2+L+a4r/ctmqQEZvdi3Cj0dmK6dRTOrBXuu4uMnvSXF/EhOms6GkvFx6M59Ptg
         +HZwTlMYfmovgIdeaXJdlSyOekiBeMCjo06hnmFMzcPALc5OVxuIT8K8dH90L+JVYxFi
         DJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6iMpxjuaGGEuY42AMf8DCkufbUTKjYhJ2yz5u9e5qn4=;
        b=XR4QgUHAAgLorl+HhTB7ukjHB6XSHI66O1B5KO/y6bl23Qfe4PdmjuIX3P14DmYfWz
         JvVMj9bFlCDARdW7AK/eQ2xEEZdp6sAnA2HCFTKd6vDYoYO7mfz+WXrWME1HWKYpMbDg
         GYjuU68+y6w7AjrEfGvV1exRGyx2NFY49DHY7jrAFE/sddFcSrZt1s93dl2GKzRLxi0P
         JbtNqTZOqfCcJPoD2/Cynq/G8JQa3bAY2H4VkAj8OsnM4T2CYhROTOSoulQ/Hh7gmwEz
         /FZUtkiXW0vy8qqxZQk6TJalCwSqDheSAQgaFraVZAJXWzDS8nvcY9H4ZKjXNsIwJN01
         RO/A==
X-Gm-Message-State: ALKqPwd4TOVadLRsl1JI0jcZFNwp49iTSymVYpg6xzfloBwxJAwtZ3ed
        xgYy2muM24IaSqPQELH6+98tMwmFGnnacBQviWr6He/W
X-Google-Smtp-Source: AB8JxZrumnxPCVG3WV3ZYw0WrC2nffwpgP74HKSNfoSoYpta6Q3T0fn8DAt2lXWrhXojDgquw4h+wetOviE6lwSL7oc=
X-Received: by 2002:a81:508a:: with SMTP id e132-v6mr1969815ywb.421.1527189304076;
 Thu, 24 May 2018 12:15:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 24 May 2018 12:15:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805240738260.6091@localhost.localdomain>
References: <alpine.LFD.2.21.1805240738260.6091@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 May 2018 12:15:03 -0700
Message-ID: <CAGZ79kbFFPMrQZLcupbp1VUk3U-ww2kV707u-ugRKzYgq5A1BA@mail.gmail.com>
Subject: Re: is the standard "[<options>]", and not "[options]" or other?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 4:45 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:

>
> but should the man pages be updated similarly? i can whip up a patch
> for that unless someone wants to comment on this further.

Yes, please!

I think [<options>] are the best, as they are pedantically correct.
[--options] is the worst, as there is not such thing as --options.

Thanks,
Stefan
