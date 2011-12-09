From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t3401: use test_commit in setup
Date: Fri, 9 Dec 2011 13:57:52 -0600
Message-ID: <20111209195752.GA21260@elie.hsd1.il.comcast.net>
References: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1323449952-14161-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <CALkWK0k-dL3xZ+dyqdACj7man-Q2QrAPZCCMhXiX0WNGZHv6Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6a4-000860-NJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1LIT6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:58:00 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58513 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab1LIT57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:57:59 -0500
Received: by ghbz2 with SMTP id z2so2826208ghb.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y8tibASpv8UvIM0Z8o/+rSwO2ys6OxTPBq8oVw4ie4w=;
        b=Sh7/734ZP/CEPotOBriNlcMKRy2K3OOEgdw0RK0bFnChO0S02X56FanUTPKPMk/LmV
         lJ/gg7yCrzYM/gkvR2c6dUDLw2fWH7KDjEaE2al2xwFG2zl9sTuHIVbSZi3QQ9xr8qLq
         lmjlNcHvzPxoU24W7JHPY899AZXpMtVN9Y41s=
Received: by 10.236.183.133 with SMTP id q5mr14204366yhm.38.1323460679005;
        Fri, 09 Dec 2011 11:57:59 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c10sm16695543yhj.2.2011.12.09.11.57.57
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:57:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0k-dL3xZ+dyqdACj7man-Q2QrAPZCCMhXiX0WNGZHv6Fw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186676>

Ramkumar Ramachandra wrote:
> Martin von Zweigbergk wrote:

>> Simplify t3401 by using test_commit in the setup. This lets us refer
>> to commits using their tags and there is no longer a need to create
>> the branch my-topic-branch-merge. Also, the branch master-merge points
>> to the same commit as master (even before this change), so that branch
>> does not need to be created either.
>
> The terms "tag" and "branch" here have no significance, so
> de-emphasizing them to "ref" is probably a good idea.

Wha?  No, "tag" refers to refs under refs/tags/, and "branch" refers to
refs/heads/, just like usual.

I like the patch, for what it's worth.
