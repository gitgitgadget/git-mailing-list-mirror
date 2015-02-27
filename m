From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Thu, 26 Feb 2015 18:15:03 -0800
Message-ID: <CAGZ79kbmdrZSXAwQAWDboBjA0Y8223WWOD_-M=wBkRHWpL6_hQ@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	<xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kayaD792tvfySQFXsmk==p=V4+aw+c79RM1eCZED-yzsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 03:15:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRAST-0007kr-2A
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 03:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbbB0CPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 21:15:06 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34391 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbbB0CPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 21:15:04 -0500
Received: by iecrp18 with SMTP id rp18so24521575iec.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 18:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=krbytxpzUOr3fi9p03rc19U3OL8OkYX6E0RqTOdiAIU=;
        b=CwxXsQbcc+Kl+tBNqJnmZGcViOrumyQ4MqpMe2jQDjwXMwnnbnE3F515j0xxCeMDRF
         cRngodQLzxCVtAoPJ8ze5rwhU/IYIhvghwc616gUFlpRnBkkY3XH0sXozl9IhZok+Cgl
         tB5p3QEPJGc4v5RSDrtZOMNwYF/y8G8pgRyIUbePq8aRDPxvwyMgaMCLiNn1dzjlt2IF
         y4BaXHpTtORzm0QJ/WOu1mpLM3ByMfVlQf8GrP/ET4ek0/PzAoo7f7FsD/34IzJxlkSv
         8Pr5ktFeBvD8iVBAxwIdLPsvIx/N0CVLah2VYso8bFuOYSxe26jE4AwvwfCV50b8hR76
         yJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=krbytxpzUOr3fi9p03rc19U3OL8OkYX6E0RqTOdiAIU=;
        b=kLnwd2EdrDTdhI09trWS9B9rCE1rXz8j6vdPHpWYPJYQtxx7oANUmIQG3/DIJpjeAN
         uI6cpj00rY7FUn6RrSQ5MoV/3/bT58Pr1o9oayH0k2urKrPmhA4DyAzlm4XuAo8Q9yFK
         wqr2KJ89rjDARyt50yehupXtE4QTrhR45HLz66d4aLmMOu9w2FVmLtrdB1ZxQk/DbGFS
         W3yU2oiNsmqSBD77qVm8m2JxIYM7+EgBnXOFlgVcDQCT60/jzdz3ViAovEAcgwAfDw3X
         s46U0Y9H0fXM6rXAmO5pLMNmH3UhNLufstkPqXRtRDtEYiMRaO89pMEbxw8/auLjwhO/
         yYrQ==
X-Gm-Message-State: ALoCoQlzJLmAqHBH4XQxGxEwWlYiWJvi4hcpUhPJ+FxzpK18cfviRXySUwXUk3FBht75sA85eE5r
X-Received: by 10.50.254.4 with SMTP id ae4mr1373172igd.10.1425003303138; Thu,
 26 Feb 2015 18:15:03 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 18:15:03 -0800 (PST)
In-Reply-To: <CAGZ79kayaD792tvfySQFXsmk==p=V4+aw+c79RM1eCZED-yzsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264489>

 On Thu, Feb 26, 2015 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I agree with the value assessment of these patches 98%, but these
> bits can be taken as the "we have v2 server availble for you on the
> side, by the way" hint you mentioned in the older thread, I think.

The patches are not well polished (In fact they don't even compile :/),
but I think they may demonstrate the ideas and though process. And
as it turns out we'd not be following that spirit of ideas but rather want
to have a dedicated v2.

That said I did not want to spend lots of time to polish the patch for
inclusion but rather to demonstrate ideas, which can be done with
substantial less quality IMHO. Correct me if I am wrong here!

Thanks,
Stefan
