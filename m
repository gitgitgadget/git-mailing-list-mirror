From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 23:07:14 +0200
Message-ID: <20110808210714.GA16512@elie.gateway.2wire.net>
References: <4E3EF38A.9010307@gmail.com>
 <20110807234634.GA3236@kroah.com>
 <CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
 <D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
 <CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
 <20110808204448.GF18294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Mack <zonque@gmail.com>, David Aguilar <davvid@gmail.com>,
	Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:07:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqX2s-0000q0-5C
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab1HHVH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 17:07:29 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42762 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1HHVH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 17:07:29 -0400
Received: by gwaa12 with SMTP id a12so880527gwa.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aPd2O4hZ5ghm+KvUuIqOdrGrkvaRkGTW/I7C0P9Dy5U=;
        b=mDbIKAFXiWCpNC9s3o0SSlLz059qJTneMvg2QVeLAPpL4cSFCocvjuNG9/RSi0JEWa
         c3lB6Wcsiv6bnCWHoyBeW6KMuPhuzpmoxWji+Qqam+zu7c4Kfzs0FHLPMDlWPpFCQPtS
         01rw+TUSD3QYQftdAgJwuQ2rsmHGOq8GmNWo0=
Received: by 10.150.69.3 with SMTP id r3mr1634029yba.223.1312837648258;
        Mon, 08 Aug 2011 14:07:28 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.ameritech.net [69.209.49.224])
        by mx.google.com with ESMTPS id f48sm1981259yhh.0.2011.08.08.14.07.27
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 14:07:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110808204448.GF18294@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178985>

Jeff King wrote:

> I'm kind of confused why you would mark an address as "cc", but not cc
> it. Wouldn't it make sense to call the header something else?

Maybe the patch is a draft and he is seeking early feedback.  The
final version will be cc-ed to the indicated person later (and that's
part of what it is time to get feedback on).

Or maybe the Cc: line is from the original patch and he is using git
send-email to forward it without mangling.
