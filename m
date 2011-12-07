From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] Re-roll rr/revert-cherry-pick
Date: Wed, 7 Dec 2011 02:17:34 -0600
Message-ID: <20111207081734.GG11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:17:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYChE-0001AC-O8
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab1LGIRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 03:17:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53857 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab1LGIRk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 03:17:40 -0500
Received: by iakc1 with SMTP id c1so564673iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fXajysRu6djLXUwAV+dfEEnpvyjcZz+PsC1AtArrN2A=;
        b=DxmuDf/AiDtlgY8lgLFi0fGhb9Ou+J/YCttZoKG44MgQPJ6N543o8H7dSCbCc2OWDc
         3CN882Hwv2c9t3G5YJJx+tJMPP0r0iei1ZAzgAK11ooEYMSpUEphVaaPJc/LEJAxLzoa
         LKbHmw8fR2aCp50Nqg6mlikZkI8lXqP+2/hLs=
Received: by 10.42.136.196 with SMTP id v4mr18018125ict.3.1323245859485;
        Wed, 07 Dec 2011 00:17:39 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id zs7sm2227332igb.0.2011.12.07.00.17.38
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 00:17:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186443>

Ramkumar Ramachandra wrote:

> This is a re-roll of rr/revert-cherry-pick, with Junio's suggestions
> ($gname/186365) implemented.

Thanks for this.  I am worried that some of my comments in previous
reviews (especially about change descriptions) were not addressed,
which could mean one of a few things:

 - you didn't notice them
 - they were wrong
 - you noticed them and they were describing real problems, but it
   wasn't worth the time to fix them

Fine.  But I would like to know which case they fell into, so I can
learn in order to do a better job reviewing the future and know my
time is well spent.

The series makes various changes, all essentially good, which leaves
me all the more motivated to figure out how to get this sort of thing
in smoothly without making life difficult for people in the future
tracking down regressions.

Ciao,
Jonathan
