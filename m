From: =?UTF-8?Q?Juli=C3=A1n_Landerreche?= <maniqui@gmail.com>
Subject: Re: a more helpful message on "git status" output
Date: Fri, 18 Jul 2014 16:47:15 -0300
Message-ID: <CAKQhN+p5FpX-GEZeX0t-Y1Sq6+fdfRpE+ACqhKgdLWGFRj0ToA@mail.gmail.com>
References: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
 <xmqq38dympo8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:47:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8E83-0002xm-TG
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762124AbaGRTrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 15:47:36 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39381 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762056AbaGRTrf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 15:47:35 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so4008181oag.35
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wIzw6ceLvuKFVfp90pxc/1/a7bJvu57zzE87ccrwYX0=;
        b=0syvpgSDI4065vjWTMg2RATYa/YtGxnLHTB3pEl+HYIPITaFW2cVZCN8QNUOzxB8nq
         6+g8upPcpfqp6Tlm911gcGU8NDayqC6WeAKwsHis6506d8RqeF1lBuwWcdszd7IQd5UD
         6BfzFiAdBOTDUG6grKxNwfciD53vOArHQK7JpehG1Ffbyk/64aJjD8mZp++er3J7/iiG
         oUeFS/fJS+hDHXAsZJ79mKix0B58rsHi3jTUba3zrJGcg4jGvyQF3PO16ig2wgwqRBl6
         REdIkMgt2nR4PYfo8ySbZOJwvnuf7tQXjIr09a1iLhO+IfwWPjabnUhLdVV6WgY8Edv4
         JsTw==
X-Received: by 10.182.181.42 with SMTP id dt10mr10184370obc.69.1405712855092;
 Fri, 18 Jul 2014 12:47:35 -0700 (PDT)
Received: by 10.182.50.132 with HTTP; Fri, 18 Jul 2014 12:47:15 -0700 (PDT)
In-Reply-To: <xmqq38dympo8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253843>

> By running "git pull", the user may obtain yet newer commits from
> the upstream, which very likely will happen in an active project, or
> "git fetch" launched by "git pull" will return without doing
> anything after noticing there is nothing new.
>
> As long as the updates to the upstream is also a fast-forward, it
> will still fast-forward you, but to an even newer state of the
> upstream.
>
> There is no harm done[*1*] by suggesting "git pull" over "git
> merge", no?

OK, I'm mostly convinced.
A more verbose, educational output could read:

  (use "git pull" to fetch newer commits from upstream and update your
local branch)
  (use "git merge" to update your local branch)


> [Footnote]
>
> *1* There is a bigger problem with this message, especially when the
> user sees it on 'master', but your message is about the case where
> you are strictly behind and that bigger problem will not be an
> issue, so I won't discuss it further.

No idea what's this "bigger problem with this message". Care to expand?

Thanks.
