From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Sun, 28 Aug 2011 18:39:32 -0500
Message-ID: <20110828233931.GD29351@elie.gateway.2wire.net>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
 <20110308024427.GA21471@elie>
 <20110828162325.5f479ef7@fenix.utopia.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 01:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxox5-0001cb-56
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 01:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1H1Xji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 19:39:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56461 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab1H1Xjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 19:39:37 -0400
Received: by ywf7 with SMTP id 7so4309038ywf.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rKX7arOUn/ahd8FTsc8UAlrP/B2Ji1rrKMoRxOKZcNE=;
        b=OrIxRvkSJXU6z8E8DLh4t0f7RI0v0oMj8BiIUgQ67rUwdnY9DWZnfVIUD18sFwJY6V
         4/YLCqLY1o14lqM1IWyQHJM7f++z/ZLZhaqKIVo0LBTzxrP+RhwKnROMk8mPMW9c7Vc4
         N6j80hITEatr22LpRQtM+Bw3nmGDKw7g2h7PM=
Received: by 10.42.76.1 with SMTP id c1mr4187153ick.428.1314574776299;
        Sun, 28 Aug 2011 16:39:36 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-62-70.dsl.chcgil.ameritech.net [69.209.62.70])
        by mx.google.com with ESMTPS id l1sm612334icw.23.2011.08.28.16.39.34
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 16:39:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110828162325.5f479ef7@fenix.utopia.dhis.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180288>

Vitor Antunes wrote:

> Is there a way to manually force fast-import to drop an old commit that the
> frontend script decided it was no longer necessary?

Sure --- patch fast-import (I'd be happy to review such a patch). :)
