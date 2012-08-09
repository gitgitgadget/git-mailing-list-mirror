From: Andrey Pavlenko <andrey.a.pavlenko@gmail.com>
Subject: Re: fast-import error: fatal: 'refs/heads/master' - not a valid ref
Date: Thu, 9 Aug 2012 12:22:22 +0400
Message-ID: <CAHSUVA4muWPh7jYNJNsPP4=_g0z98QQmz6fzraVkKfyDgE_rcw@mail.gmail.com>
References: <CAHSUVA5y1nZG69JbvC-wbmHhjyBGLx8Z2TM3htEyuCsWj=A+aw@mail.gmail.com>
	<20120808175433.GA12772@sigill.intra.peff.net>
Reply-To: andrey.a.pavlenko@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 09 10:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzO0m-0007Sm-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 10:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab2HIIW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 04:22:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57728 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934Ab2HIIWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 04:22:24 -0400
Received: by weyx8 with SMTP id x8so112767wey.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lpxtJoMkGAgyv2jtRTRIZBTTNuagUsI0CjE1Ft6U2As=;
        b=T3zt1UhY+/e0wCCJzu0Qh7Xw6yFsH638OlSTeCczkNo3b7Yf/RIJxsf43+xt3L6b9F
         53an2CUTX3gzvllitClrIxS7gfCciFCT+Y/0f7t/qMUlHSF8vgIiZkXO4DYQ838guCf2
         BfWKS0i9JN5QULrvdBx1Dh+3imMOKjb2qgsWWXnZ8x611aeCvDRyzbxEa4d6fBp9eDYI
         thc/zGu/+L65txoZEk8JajNDNb6k51nZtJYmKaR2Kbv/6phk1oYF9sqK6opHYxbIpScb
         eTCIL+Fo43/YeIAtAJdGQi5kYfexPv/Y6+oO4V+UOG3jr9FuDb4bcZNo7R11ClHSqimu
         dJsQ==
Received: by 10.216.135.147 with SMTP id u19mr10853417wei.12.1344500542625;
 Thu, 09 Aug 2012 01:22:22 -0700 (PDT)
Received: by 10.216.152.164 with HTTP; Thu, 9 Aug 2012 01:22:22 -0700 (PDT)
In-Reply-To: <20120808175433.GA12772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203155>

git --version
git version 1.7.11.3

On Wed, Aug 8, 2012 at 9:54 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 08, 2012 at 11:25:02AM +0400, Andrey Pavlenko wrote:
>
>> I'm developing a remote helper which uses the fast-import stream for
>> fetching. When I perform cloning git prints error message - "fatal:
>> 'refs/heads/master' - not a valid ref", however the clonning completes
>> normally. Each my fast-import commit command starts with "commit
>> refs/heads/master" header.
>>
>> What does this error message mean and how can I fix it?
>
> What version of git are you using? The only command which produces that
> exact message is "git show-ref", and it is not called by current
> versions of the cloning process (but it used to be in old versions).
>
> -Peff
