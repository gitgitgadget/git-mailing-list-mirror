From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/4] difftool--helper: Make style consistent with git
Date: Thu, 18 Aug 2011 02:08:12 -0700
Message-ID: <20110818090810.GA15416@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-2-git-send-email-davvid@gmail.com>
 <CAHGBnuPRsh0WDVSFr0X1Y+nb=94pJVv8=evFQCjdcd_y9ux97A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 11:08:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtyaQ-0006TN-Ei
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 11:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab1HRJIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 05:08:22 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:34772 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab1HRJIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 05:08:21 -0400
Received: by iye16 with SMTP id 16so3594933iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mTE+nS0MzQZGnrtCzmGhWiBBwzu9d5XVU8y4YfMAMuQ=;
        b=Pg7Q5IzdidkYMLu5mEtzZKr/HHG2avdzolBq+rDcT8k5m7Z+UAshXSic3nCzcg1Riz
         2gbZ6Y9YYKVBZn7uT3cC8GSBvr9r1hLIGB9z+hOIhai6R5Xn6f9ITTRZGCB+wKFMUDzK
         RCte2oBDTNFqXCc/2MQ913IXdl3YFCIhY0NEQ=
Received: by 10.231.49.78 with SMTP id u14mr1100149ibf.75.1313658500648;
        Thu, 18 Aug 2011 02:08:20 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v16sm863197ibe.34.2011.08.18.02.08.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 02:08:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHGBnuPRsh0WDVSFr0X1Y+nb=94pJVv8=evFQCjdcd_y9ux97A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179583>

On Thu, Aug 18, 2011 at 09:49:33AM +0200, Sebastian Schuberth wrote:
> On Thu, Aug 18, 2011 at 09:23, David Aguilar <davvid@gmail.com> wrote:
> 
> > Use the predominant conditional style where "then" appears
> > alone on the line after the test expression.
> 
> I support your effort to unify the style, but for my personal taste it
> has gone the wrong way :-) Even if "then" on its own line was the
> predominant style in the merge scripts, I would have voted for putting
> all "then" in the same line as "if" as I find this easier to read and
> comprehend. But then again it's obvious that such a change would
> polarize ;-)
> 
> -- 
> Sebastian Schuberth

I am fine reworking it either way.
There's not a specific note about it in
Documentation/CodingStyle.

If someone wants to make the final call I can patch the docs
and rework these patches as needed.

Thanks,
-- 
					David
