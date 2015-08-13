From: Dave Borowitz <dborowitz@google.com>
Subject: Re: config options for automatic signed tags and signed pushes
Date: Thu, 13 Aug 2015 15:01:54 -0400
Message-ID: <CAD0k6qSAw_aG_kScRgJE+6jVv6z_qc_O81Zq1s29nu=NkKp0oQ@mail.gmail.com>
References: <55CA4799.7@mthode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: mthode@mthode.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:02:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxle-0004F5-35
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbbHMTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:02:17 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33970 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbbHMTCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:02:14 -0400
Received: by igui7 with SMTP id i7so89202021igu.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rjuSIj8ZyRvBmTxv44tCk6Mni50oXYRNjcTuNDoTp3U=;
        b=jVqLyyJs7FlqW45phbxiORR7wCW/b7bDWU4SAACGmVgAQJnMBDpaFDSpggK8kb3mn5
         eZKDzjV6sYN6CpiTaMuRttuoXJ/2LVNmqDxbZEtwK5Xz5eLAX6V7Wtfue655IqWZUPsr
         O5byDVqyI97TvnY7kRXfdCVDX/JSsHTodwjzR6VID4vdVgGB8YNPtoiiOhLoJ8F1sOMV
         rwQlJ4LM+4W7ELHR/9tnjvT6Y25rWh7iAGbdXHB+TWoXMB/S+DQv0dl2YVlUCXcrF9EO
         ru3q00H7/ygZKs6/8udLIc1cLaMLiImNkUj68KkTuMLswjy1AjtcV48Fu8jKAel3yr1q
         h+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=rjuSIj8ZyRvBmTxv44tCk6Mni50oXYRNjcTuNDoTp3U=;
        b=g5H/3MTrelbP8W7rf9JhJMFh/6pi9n1TgajVj17pZ8c4q4ntrQNVQdfZ02YMH1CCKY
         3ktNDZT90r4HsBE+SRl2o4OkMEJQAfQ3rp/hUhMMD4sKAF4+MBPkdNYV2eDB16dNP8ZT
         +LD41lnWA/JsXprK+a8L6um2DxavkZbyea/4lY/19UxaMXv4ytpabt+CxrdOE4XoP7df
         sBqRn5L2K/lcCOhDeLEsdYNQLbqTTfAtatquSAaSPdQAlMD6Jw99oxsfpFZFW0peMxOT
         7a+C1a81L9WOsm0RxYpbl7ZQ7mO4VbPr0ttCluxbmoPUovTX6USwoPa04Qxlkxi1jv5m
         rQUQ==
X-Gm-Message-State: ALoCoQkBG7ioltFoXabBaBtlEG+q5XAGGNWm8usNArIrv2sGIeHWkJRjH3RpGIbimp+qZ7fTXpN/
X-Received: by 10.50.27.39 with SMTP id q7mr4286633igg.73.1439492534161; Thu,
 13 Aug 2015 12:02:14 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 13 Aug 2015 12:01:54 -0700 (PDT)
In-Reply-To: <55CA4799.7@mthode.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275883>

On Tue, Aug 11, 2015 at 3:06 PM, Matthew Thode <mthode@mthode.org> wrote:
> If it doesn't already exist (not that I can find). I'd like to see
> config options analogous to commit.gpgsign for both tagging and pushing.

I agree this would be useful, and that's why I just implemented it today :)

> Not sure where else to send this request though, let me know if there's
> a better place.
>
> Thanks,
> --
> Matthew Thode
>
