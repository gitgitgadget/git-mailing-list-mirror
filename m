From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Sat, 1 Oct 2011 00:29:10 -0500
Message-ID: <20111001052910.GA6502@elie>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111001022544.GA31036@LK-Perkele-VI.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 07:29:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9s8k-0007tF-Ky
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 07:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab1JAF3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 01:29:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48635 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1JAF3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 01:29:22 -0400
Received: by iaqq3 with SMTP id q3so2548949iaq.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ftGU1mlFsBc2WKasi+lghujwmu0CJXiteR2SdrqAm54=;
        b=LPQH9gQFanmu5W6hVn1tFhMkbgyOathwUZUFz/4HUhXI0GTgUb9ToyXGVbXmgeCDL0
         kx4DFV0BBfFhfBkkXDEzZAv4+VFHA4xAJQN7fjpL91aGvPMeAfNSQ8rTNJocbagJoKyl
         veWuQ0iO/jfil+DZyMRam1kzNIkVL+HbTAwzA=
Received: by 10.231.29.101 with SMTP id p37mr18613858ibc.81.1317446961884;
        Fri, 30 Sep 2011 22:29:21 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id by18sm12210443ibb.1.2011.09.30.22.29.21
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 22:29:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111001022544.GA31036@LK-Perkele-VI.localdomain>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182536>

Ilari Liusvaara wrote:

> What about sticking code to return an error to git daemon instead of this?

The code has even been written:
http://thread.gmane.org/gmane.comp.version-control.git/145456/focus=145573

Testing and other improvements would be very welcome.
