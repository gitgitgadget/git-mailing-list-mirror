From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] fast-import: disallow "merge $itself" command
Date: Wed, 27 Jun 2012 16:22:31 -0500
Message-ID: <20120627212231.GM12774@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzhC-0003x0-2o
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510Ab2F0VWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:22:38 -0400
Received: from mail-yw0-f42.google.com ([209.85.213.42]:36940 "EHLO
	mail-yw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860Ab2F0VWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:22:37 -0400
Received: by yhfq11 with SMTP id q11so1737540yhf.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ash69qR2UVNgHQ0udUmK18ldmX30JGGdZodLH1Q7+Ks=;
        b=xE32ZAOHswqKBa4dGP5t3/M1T+bRnw/6gOPzCdpcGKM2ELsD6DQJSuMh8nTWehaLqK
         gyjXuCfijY1A4Mc2YOleiF/G+NSKg2hSVvaJl1RcavE0yOhs/3VsC6y2xeRxFVq3oj50
         rrRIdqjD7j7ffgDwMm+jtxjerH5gFofnQvDIVwfKH5mQbJiUMjOI+YDtT/+sSWz6qfiu
         2eIMj0JUgacDk3/8a0S59ir/Ydsr8Kc1khcLSs3ha/Qwvr78LHlknb8FF3gjnPp8+V4C
         pCbeKkCupCqo2vvwAmaWo7FSe63viCQ7JZdzxX92RiGRv44unwXEZyXTcbcXQ2Jemxxq
         jepA==
Received: by 10.236.173.135 with SMTP id v7mr24862572yhl.19.1340832156431;
        Wed, 27 Jun 2012 14:22:36 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a64sm149753631yhe.11.2012.06.27.14.22.35
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 14:22:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340818825-13754-4-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200757>

Dmitry Ivankov wrote:

> "merge $itself" may be used to create commits with previous branch tip
> being repeated as n-th parent or even moved from being 1-st to be just
> n-th. This is not a documented use case and doesn't look like a common
> one.
[...]
> Just deny "merge $itself" for now. It was a bit broken and btw "from
> $itself" was and is a forbidden command too.

Lovely.  Thanks for a clear patch and clear explanation.

For what it's worth, this one is
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I'll think more about the other two and get back to you.
