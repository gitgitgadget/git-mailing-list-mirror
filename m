From: Stefan Beller <sbeller@google.com>
Subject: Re: Windows download broken?
Date: Wed, 16 Mar 2016 10:23:24 -0700
Message-ID: <CAGZ79kaz2xPUO+zUK9LSqwWPK0aYPirwjgwzKmZgGbscxq6anw@mail.gmail.com>
References: <CACwWb3Dm8CfhZKvfNz-4Pj=tytf3zroFxnbbTq9DM+xm4EPEig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Levente <leventelist@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:23:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFAR-0006cq-DO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060AbcCPRX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:23:27 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37971 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbcCPRX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:23:26 -0400
Received: by mail-ig0-f175.google.com with SMTP id ig19so50046426igb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 10:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=avhZ42r7j1R/Kd8Zyr9WMIGDvlmkXgVtsYVuqNLuQ9U=;
        b=dCpNSJHrYPeqaDlXLGT2Ba3EjJLsCc375DuWg5W9PF7KADH7epluBmc6znmNkxddjF
         KOPyhvV4f8Lw5lmBGawPNT7+lMGuhA786llSFnCdnlNrjD7Se7Ae3np4jVba/TqPkZaR
         8C5eOdjV1a8nCmfL91HviSWJZgRalP7aMcdDQAxvBp629aQQ9/UgMgLeTISMmjsUMuUg
         d3A33ECUbegRvxSZjThNtMfkoRgSqUUIg1ccrJ4GXSj4wjbAdLcoOsijUaASDGz8BAeE
         LhJmd5/+cq6OaIMuSPnk63CkYyu3HlbDBDf3ACZrNPcEnj1gWtTBTjK3j1kKggu8UgRd
         5xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=avhZ42r7j1R/Kd8Zyr9WMIGDvlmkXgVtsYVuqNLuQ9U=;
        b=P2698irnXPtFY+ayNpwBiI07jvN1O2GMq437luhTkzebrPfMWiR9W3zFu1hZByx2lQ
         kke6TqhEudMpDqQnx7D2bTvPD1jtpHHtBk8AT+Un9c7nFSDx+LiUj9R71p+WNMnt05Xz
         ALHPv+C/WxtEGMnUFYt11ezVMsyjx57GCAHczUvzgvlGdyDqnrD+xHUyrGAZf3U2GZel
         3Q9mFLBzLCPXaad8c1kwdru4MWV3+m8dQRNO8gcr65QwpCo3QgCOGSlnuiKLegK1gwPK
         5rJD7kPmoVFo/2414wJ6yTxy5BPegvYfmf558CHAeA7fTX6MFUfXZH2w407JESsd7ftx
         K92Q==
X-Gm-Message-State: AD7BkJKBrZQgFbEBb/8ln0w1xgO8UWKBIzA1K6ta4sAVfEPeJlBlGPpvaxJni7P7DDAw9XfkpEluopMnDva41a8A
X-Received: by 10.50.117.33 with SMTP id kb1mr2219804igb.93.1458149004989;
 Wed, 16 Mar 2016 10:23:24 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 10:23:24 -0700 (PDT)
In-Reply-To: <CACwWb3Dm8CfhZKvfNz-4Pj=tytf3zroFxnbbTq9DM+xm4EPEig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288999>

On Wed, Mar 16, 2016 at 7:06 AM, Levente <leventelist@gmail.com> wrote:
> It seems that this link is broken:
>
> https://github.com/git-for-windows/git/releases/download/v2.7.3.windows.1/Git-2.7.3-64-bit.exe
>
> Regards,
> Levente

I think Git for Windows is discussed mostly in the GitHub issues.
Anywhere, cc'ing Johannes, who does Windows releases.

Thanks,
Stefan

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
