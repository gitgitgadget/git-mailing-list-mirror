From: "Ed Schofield" <edschofield@gmail.com>
Subject: Re: Newbie questions about moving around repositories
Date: Fri, 15 Jun 2007 18:19:58 +0100
Message-ID: <1b5a37350706151019u2bf81e81me05d13ea9bf40591@mail.gmail.com>
References: <1b5a37350706150652y7710c380l79e785cba8f6b02e@mail.gmail.com>
	 <81b0412b0706150718t2382648aw25959844f52c5c02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 19:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzFSs-00008H-44
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbXFORUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 13:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXFORUA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 13:20:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:19957 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbXFORT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 13:19:59 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1016892nzf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 10:19:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZyX8mZ/QaJSqBOAzr0bxqprAqZzxjLsyHbapKdvEFSq2imiDL0E02YfSLUtruam88se3Mi/dSWh3ZoPfbZceTnLYi8/1II5mEtb4tP5bW27PQfV8fbuGsQXW+iW2+d9UtP2bTIkPnZUGE2MDPl1y6zmBZg007OUdff863uSGEbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lFwhvdBqPfLrA1mj2EZkU6htZLdRsNmj+rKkUspLOVG2OqPHCCEbIF/+dcfsstE5foVpgAPx43/wgRF+u+xGC+UoO2Yk1DTMGastIyMLkwHCqMXo96XvsW7gjCF+eERW3O1eA3oQXb++oyrOrTw28PG1cxzgo5Vi1Lz5bYOZmfY=
Received: by 10.114.88.1 with SMTP id l1mr3228794wab.1181927998427;
        Fri, 15 Jun 2007 10:19:58 -0700 (PDT)
Received: by 10.114.196.16 with HTTP; Fri, 15 Jun 2007 10:19:58 -0700 (PDT)
In-Reply-To: <81b0412b0706150718t2382648aw25959844f52c5c02@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50272>

On 6/15/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 6/15/07, Ed Schofield <edschofield@gmail.com> wrote:
> > 1. I would like to move my repository (including all branches) from
> > directory A to a directory B on a different filesystem.
> > [snip]
>
> Just copy it.
> [snip]
> ... but fix that .git/objects/info/alternates files in the repos left to
> point to the new location of the moved directory.


Thanks, Alex! Changing this and .git/branches/origin worked a treat.

-- Ed
