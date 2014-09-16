From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 1/3] t1503: test rev-parse --verify --quiet with
 deleted reflogs
Date: Mon, 15 Sep 2014 20:06:17 -0700
Message-ID: <20140916030615.GA2286@gmail.com>
References: <1410808059-1459-1-git-send-email-davvid@gmail.com>
 <xmqqk3544ire.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 05:06:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTj6J-0003oR-1O
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 05:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbaIPDGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 23:06:38 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34126 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbaIPDGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 23:06:25 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so7692149pdj.6
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3Bg06i06bX2KILUQb8gCBWf1kd3kYZBBWVxz9C1+EJo=;
        b=FSWZYQoelfKXwONTkSyESAqKCwOnMCYzSriE3Wtl4tnC4Ag7z6mZY9zxLvTDtD9wQX
         WpGcGS9PXxfEicFHsTvA69sW7AU+cVnh6yQ+eYwFHnpTxGr7jgHfuiRyX9p8Fefklb1z
         xMAi32X9d/N/8g60h3iYN38iak0IUcqhlRWsQMbrTi3Gx9M4jUM9lJzTHDRC35SSJFWN
         rSbB+qZqI3X4f9bbhx1ZtRswbtgV4iA5FDBikdbcwYWfPjXYyF6Bxm/VJWPLc0ylY9PT
         KO2m19JDK+xzfwjh/x9lkZmaswBU2Zecr0MTG71cBhs6QTqj7q6mIFttsXfrkIJSr/9a
         ED7A==
X-Received: by 10.66.65.130 with SMTP id x2mr44243271pas.79.1410836784702;
        Mon, 15 Sep 2014 20:06:24 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id v1sm12676758pdg.28.2014.09.15.20.06.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 20:06:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqk3544ire.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257123>

On Mon, Sep 15, 2014 at 03:32:37PM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Ensure that rev-parse --verify --quiet is silent when asked
> > about deleted reflog entries.
> >
> > Helped-by: Fabian Ruch <bafain@gmail.com>
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > Differences since last time:
> >
> > This goes back to the original approach of using "git update-ref"
> > plumbing instead of "git branch" when testing deleted reflogs.
> 
> Is this 1/3 (the first one in the series) supposed to pass without
> no other patches, either in the series or something outside?
> 

It depends on the patch I sent not too long ago that makes
rev-parse --quiet actually quiet.

I'll rework this series to do the test_must_be_empty cleanup
first and include the prerequisite patch when I re-roll shortly.
-- 
David
