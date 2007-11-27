From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 14:03:44 +0100
Message-ID: <81b0412b0711270503s7e69be3bn151cfa58b8067f35@mail.gmail.com>
References: <200711271127.41161.gapon007@gmail.com>
	 <81b0412b0711270321q6f70554at177ade878448b9fc@mail.gmail.com>
	 <200711271231.51270.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix06h-0005RQ-B7
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbXK0NDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbXK0NDs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:03:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:37608 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbXK0NDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 08:03:47 -0500
Received: by wr-out-0506.google.com with SMTP id c49so851900wra
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 05:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/473RKH2ttEJRyh1PEwgvsSxKcYJ5bgoirFmNc4u5bc=;
        b=dHDko2y53wOZC4ANvRo/qslDvOYBSIEorplDaSncI+CRqDlFQXaIaxTbEC84ETAF2E+v/4RdkvJm4Yy/NC9YUERDQxiglbNw4vPSK0t7zdgYD1xjv3iWrE7fnTzHGzgTwFFlKeXACTCOnlBE3PrZ/hKfPtOnX4O4VOHhFVYRjjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRNn3IyFzYB9eRocXitFoe89LUMFcxXVUMLe2DESnOuhSEZvrjW8Rb2h1TS7GQTLHsbLu629fPV9OrgtB0VhiX9pMm2PhFKrKBAUBTMmTnnCIkH4gyfTu8L/+iXP5lRoHfRd3EdBSURelJ4TsJ2FWDM6LS8PGo7Ic9QCi0cRsHE=
Received: by 10.78.159.7 with SMTP id h7mr4166344hue.1196168624494;
        Tue, 27 Nov 2007 05:03:44 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 05:03:44 -0800 (PST)
In-Reply-To: <200711271231.51270.gapon007@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66204>

On 27/11/2007, gapon <gapon007@gmail.com> wrote:
> as i wrote in my first email - i know that this is not "correct" scenario (i
> don't and won't use it anywhere) - but the git's behaviour is in such case
> confusing, at least for me
> just for clarification - my email wasn't about how to push or create shared
> repository - it was just about what i have discovered while playing with
> different scms

Well... It is known problem, for one. That user B of yours, did he just cloned
user A's repo?

What I suspect is a change in how git-clone setups the cloned repo
could have taken care of it. We could either setup push-configuration
so that it just does not work (and let user change to his preference),
or somehow figure out where the pushed references can safely land
and put that in the cloned repo configuration (that is "SOMEHOW",
I afraid. Absolutely no idea what could that be).
