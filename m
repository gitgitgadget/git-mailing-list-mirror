From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git annotate with date option not working?
Date: Wed, 1 Jun 2011 14:37:04 -0500
Message-ID: <20110601193704.GA9950@elie>
References: <4DE5F655.9020400@gmail.com>
 <20110601161638.GB7132@sigill.intra.peff.net>
 <20110601164904.GD7132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chengwei Ding <waterding@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 21:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRrEL-0006QA-Dq
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758799Ab1FAThS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:37:18 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39824 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab1FAThP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:37:15 -0400
Received: by gwaa18 with SMTP id a18so60680gwa.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cOBllpREOt1kN+CPv0yvM3XZoLu4pQ/t5H35AOBv790=;
        b=iCp8x071jIRAzh+BtWYRcTP0HXC8qHfquaeUS7uNyit6vtFyySY4F4KFuraLBBI30I
         GH4FivUp8QfGAbNKW8NZs0zYKqXHlSt/c4iKYnev7oYBs6xVO1sQDugwOthPWNrfv4iY
         RI1sznFPNad4WxGXTy9sYPwEiSMrfDvh9+eJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mPMokLA3piPKNfHTzbQmk+etjcKOLxV8FpkY9uK8G0D1Sj4u8yMYUylHBtdlOnSFMv
         8WgalrzlLfWimtfxKNFz23rh1sxVPpFmAfPQSBBkOG34Jv91M+ezLDbuGt6Jzo0aT6fj
         xjsqQa4Gs4yTFwaTxsRlOqv/wuSGuXT6nFPOI=
Received: by 10.150.203.11 with SMTP id a11mr6606062ybg.202.1306957034984;
        Wed, 01 Jun 2011 12:37:14 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id p23sm338576ybc.29.2011.06.01.12.37.13
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 12:37:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110601164904.GD7132@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174897>

Jeff King wrote:

> Having said that, this would be really easy to support, and I don't
> think would have any negative compatibility consequences, as long as we
> don't support blame.date. But I don't think we're breaking anybody
> relying on "git annotate --date=whatever" being silently ignored, as
> that option has never done anything useful.
>
> The patch would look like this:

Looks obviously good to me.  Chengwei (and anyone else), would you be
interested in moving this forward by adding tests and perhaps
documentation?

Thanks.
