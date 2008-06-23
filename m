From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git blame for a commit
Date: Mon, 23 Jun 2008 18:29:21 +0200
Message-ID: <200806231829.22004.jnareb@gmail.com>
References: <485ED2E5.3070906@mircea.bardac.net> <m3ve00lbby.fsf@localhost.localdomain> <alpine.LFD.1.10.0806231149470.27742@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mircea Bardac <dev@bardac.net>, git@vger.kernel.org
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAovw-0005SE-31
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbYFWQ32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026AbYFWQ32
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:29:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:49045 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbYFWQ31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 12:29:27 -0400
Received: by ug-out-1314.google.com with SMTP id h2so555755ugf.16
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=e5qt6NDfv1m+fYq+BhampwIxp4cU7/ZQMEkrCZX6UqQ=;
        b=r1hQHndponvYang4ItbZ64CbxdYU7Gq13ctDZCpKWVJfPhWuSAapo4RiRwtGZtOdPa
         qsmr+lVCuuzc67H8skx+46yhGZjiniMIJlUvnjXo2ZSVgVwyHDMZjFVZMNliMwZnNjUM
         qtb2gxRiPpmPSw0CrUlR1oyeGwlyleSd9Nn+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Hs+wJoUtkYVulMjiYf+Bp2v6NiZlf+bvegi0Ucv0I8BgXrfTlDxMAin5wQDPm01qRP
         rma/8ad2AyKrj+Q/VlaYuO12x6ZkPjRoTEq/pykF8QXrbyMtQ1Z2TcMCVLcAnaBQk6xW
         50MjI0BM2qO0gb9NTNWqm7KcBZoabQ3n+q/gA=
Received: by 10.66.236.16 with SMTP id j16mr2361146ugh.31.1214238565281;
        Mon, 23 Jun 2008 09:29:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.247.21])
        by mx.google.com with ESMTPS id b35sm30458925ugd.51.2008.06.23.09.29.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 09:29:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0806231149470.27742@sys-0.hiltweb.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85884>

On Mon, 23 Jun 2008, Ian Hilt wrote:
> On Mon, 23 Jun 2008 at 3:01am -0700, Jakub Narebski wrote:
> 
> > I think you could script it using "git diff", and "git blame -L m,n",
> > where line ranges would be calculated from git diff header for
> > post-image, or both pre-image and post-image (in the case of deletions).
> 
> Maybe I'm missing something, but I thought git-blame only worked with
> the files in the Git working directory.  Therefore, if a file had been
> deleted it would not be reachable with git-blame, whether you diff'ed
> the pre- and post-image or not.

You can give blame the revision to start blaming from; that's what
I meant the "pre-image" blame (staring from parent revision).

I'm not that sure if it is the best solution...
-- 
Jakub Narebski
Poland
