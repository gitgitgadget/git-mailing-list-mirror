From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Fri, 25 Jul 2008 01:44:01 +0700
Message-ID: <fcaeb9bf0807241144i6decac10q78c5962f3daa7a48@mail.gmail.com>
References: <20080723145718.GA29134@laptop>
	 <20080724171952.GB21043@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807241837441.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5oH-0003AQ-GU
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYGXSoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYGXSoF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:44:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:45973 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYGXSoC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:44:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1471181fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QN50hYnBQ+uTo+7XJ7YZqeZTg0CZ09xInBmSUYkVJIo=;
        b=Ix+YCxyPUC/JyvXBUXKfSbhkDCR9uafWsc2y5F+ZnJjB3M3lvCeqJWKWP0hIjKOve0
         Z3Dwtxi2pV0PGM5Y6BX200em866IaitfyNN8TIFT5jrGddEZLNam5upfucLr0QcxWtJZ
         clrdPTysVbraog1fdONuTpXneTK9vmmRkDXhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aYTnHLVoax/W67o4Wo3Cv8lBWbp9WjHKR91YNg0j/3Q75WV0h1c9wfMSPNejjRO4M6
         YFUj6tUfu74Yoy/15FaU3RsFr7D52xBGhxq0wOXHcRHrAQAq0sVf4BqP5C4ZGLPmxO96
         ZxcGKRoI7jgXJZCBfnvmEfMpZ14FOtYat1M5E=
Received: by 10.86.93.19 with SMTP id q19mr1116743fgb.63.1216925041428;
        Thu, 24 Jul 2008 11:44:01 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 11:44:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807241837441.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89934>

On 7/25/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Thu, 24 Jul 2008, Jeff King wrote:
>
>  > As a user, I would expect "sparse clone" to also be sparse on the
>  > fetching. That is, to not even bother fetching tree objects that we are
>  > not going to check out. But that is a whole other can of worms from
>  > local sparseness, so I think it is worth saving for a different series.
>
>  I think this is not even worth of a series.  Sure, it would have benefits
>  for those who want sparse checkouts.  But it comes for a high price on
>  everyone else:
>
>  - security issues (you'd need to open the git protocol to give you
>   something else than a ref, _including_ refs that were deleted)
>
>  - performance issues (the server would have to do a lot more, faking
>   commits, or in the alternative serving a gazillion more sessions if the
>   client does the reconstruction)
>
>  ... and I am sure there are tons more issues.

Widen checkout won't work and probably more.
-- 
Duy
