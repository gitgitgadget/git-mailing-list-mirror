From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Sat, 9 Feb 2013 02:08:36 +0530
Message-ID: <CALkWK0mcOjbzCvzc-1W9RYM878Tiy8m20T41SdvqgY=qtE67rA@mail.gmail.com>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com>
 <CANiSa6hD=zX5=evziqQpXHdjUDEU80t_Du7L+Hpa11ru=5XVNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:39:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ujB-0004lY-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 21:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946980Ab3BHUi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 15:38:58 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:53260 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760255Ab3BHUi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 15:38:57 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so4535306oag.36
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 12:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=01+UCkGavBkQGyq1L79uwMr16AmqmN/u0+AeAdm2Hz0=;
        b=PaIuvW203M8mvx9qn2c45VJqkIkcJgBIQnvMOHVKVZ9yXF5rWBo8xzfa9CrPgs8o/P
         M8j6exgeapoWM+rmXyqI8dPHkr9vvSkmdG2gUCElZYB3RlZnfhuctrtrdhyKDUHJaM1F
         HpA0z4OZTSl3TV4Dp6+b/U4QCMxth/i4GO/ZssZeUqwBYakZ9P1GEr3QHKGxPpgIfwHj
         VkoHadwTAi37haSYcfARnkVeQj9ELqNYTBDou4AHLryVuFU8LjmDEfwdeySlQvGImtGB
         7TS7r2O2JPeW0to+gIydOB9ABQLzSGXl4IcQXai7tjZaXJ1PFqhIhNKm79mEsvGx0Evu
         zCTA==
X-Received: by 10.60.169.203 with SMTP id ag11mr5198427oec.124.1360355937077;
 Fri, 08 Feb 2013 12:38:57 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Fri, 8 Feb 2013 12:38:36 -0800 (PST)
In-Reply-To: <CANiSa6hD=zX5=evziqQpXHdjUDEU80t_Du7L+Hpa11ru=5XVNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215816>

Martin von Zweigbergk wrote:
> I'm curious what your use case is.

A couple of them off the top of my head: the gh-pages branch in
GitHub, restarting a project but keeping the old history around for
reference.
