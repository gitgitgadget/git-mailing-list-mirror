From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Fw: sort of a bug report - git rebase dropping empty commits
Date: Thu, 7 May 2015 02:47:11 +0200
Message-ID: <CAHYJk3QOuo=p26OAnkKmrPS0SzpdJGvB=Fm=jiMMDDJo13zi9A@mail.gmail.com>
References: <1430956735.75040.YahooMailBasic@web172301.mail.ir2.yahoo.com>
	<CAJMB+NhVapp+upsk2AQQmZndaNFjaOieom7=n6mY31v0QemaYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 02:47:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq9yA-0004OM-MU
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 02:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbbEGArN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 20:47:13 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35724 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbEGArM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 20:47:12 -0400
Received: by ieczm2 with SMTP id zm2so27870543iec.2
        for <git@vger.kernel.org>; Wed, 06 May 2015 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=40V6xOk1+xIzcvxud9NN82Zq0Z+mv2EhYhyHWOQMkl0=;
        b=WjpTYmQlu7pNn6Tcf5R63FJRMagFawB5UxOCLOgnwJBgHrV5am/XI66WAjMqlgDOpa
         jU07iuUllTYMK6GZDZX771jXh+yzuEaSGjmlK7CFDQOGSiMApP0bxPJ8nPeUX7W3gxB5
         vgfw/Uowdsv3/C8FP//OlAguVk47ZQg2t78PL0ULr5Cvjat8/jSgDebr4eTIyiWAMc4e
         x82tRfV9ibiyXI8LKS7rmKZn/8ksQVE15mA5Ev4G/wKKGBgTJgWhbeJxW1DbGTWbBJEl
         8NM+Jy7amvaqDjj0xMBqSNq2AMWg3Rt+LyefPv1D6aOJuesQrX0aGNu/yiAmn6lAhqZc
         DP1Q==
X-Received: by 10.43.18.194 with SMTP id qh2mr1213721icb.36.1430959631678;
 Wed, 06 May 2015 17:47:11 -0700 (PDT)
Received: by 10.36.143.136 with HTTP; Wed, 6 May 2015 17:47:11 -0700 (PDT)
In-Reply-To: <CAJMB+NhVapp+upsk2AQQmZndaNFjaOieom7=n6mY31v0QemaYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268503>

On Thu, May 7, 2015 at 2:19 AM, Hin-Tak Leung <hintak.leung@gmail.com> wrote:
> Repost from another account. vger.kernel.org seems not
> to like postings from my other alias (which goes through
> yahoo).
>
>> (please cc - I am not a subscriber)
>>
>> Recently I have started to keep some notes in git repo's
>> with --allow-empty - i.e. the meaningful content is
>> the commit message and the date itself, not the diff.

Use the git rebase --keep-empty option?

-- 
Mikael Magnusson
