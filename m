From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Fri, 8 Feb 2008 10:47:00 +1300
Message-ID: <46a038f90802071347l2e6465a1v85e4f5a21b96a109@mail.gmail.com>
References: <pan.2008.02.04.18.25.26@progsoc.org>
	 <20080205050741.GA4624@coredump.intra.peff.net>
	 <pan.2008.02.06.21.56.35@progsoc.org>
	 <20080207042332.GA7632@sigill.intra.peff.net>
	 <pan.2008.02.07.10.15.05@progsoc.org>
	 <20080207142322.GC18497@mail-vs.djpig.de>
	 <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
	 <20080207204026.GA2550@sigill.intra.peff.net>
	 <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Anand Kumria" <wildfire@progsoc.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 22:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNEar-0005RJ-1O
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 22:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762846AbYBGVrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 16:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762817AbYBGVrF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 16:47:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:17603 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762687AbYBGVrC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 16:47:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so777278ugc.16
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cLlOA+WpJeDxOboGIjmMc7sN9SxPh9jXjryUgMAEvac=;
        b=gtnAHf3bpdb+LWlud57cGX5szzlqmvKDtIEnNeH5A2UfC+RgBhR9ucxhWM+A2Rm9EqdQ7o17k7Wdgqtaxeb3VW++fb/tQk6B6WXyzo65PbiU25Sk8jujyQ4K3zl81LbK5ovs+0AlL6gSH24Tp+lLiJ4F5Dd9fP/+OqJ0ovGO5E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KRrQUbUgB0uY8QRl6KM+EwvTduPIelSYqv3tiM2SfpWteTTwhj69MVInE3LlKGxRjtByCnEpjbxDeXXOEKQIe3/DgPjAMeYSEECvOucns8PmPPqSECj+a/0DnmjV6HY6rH+6gpEodt2XtkqZ6Tdu4E1ho4Aaz+S8eP1rTakFFog=
Received: by 10.67.116.11 with SMTP id t11mr4536872ugm.61.1202420820333;
        Thu, 07 Feb 2008 13:47:00 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 7 Feb 2008 13:47:00 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73006>

On Feb 8, 2008 10:01 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> My comment was about claiming "not distributable". That was simply not
> true. It's perfectly distributable, it's just Debian that has issues with
> OpenSSL (but then they shouldn't link it against curl either, so there
> seems to be some _other_ problem there too).

I think tides are shifting and Debian may be seeing some common sense
prevail. Thanks to ubuntu perhaps, or solar flares...

> In short - I just wanted to make sure that we do not make the insane
> Debian policies somehow official git ones.

Good clarification anyway :-)


m
