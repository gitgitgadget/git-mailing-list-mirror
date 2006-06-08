From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 21:05:08 +0530
Message-ID: <20060608153508.GB8047@satan.machinehead.org>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de> <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de> <20060608133747.GA15374@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas Sandstr?m <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 17:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoMXb-0000KH-Lj
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 17:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWFHPfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 11:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWFHPfU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 11:35:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:28308 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964879AbWFHPfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 11:35:18 -0400
Received: by wr-out-0506.google.com with SMTP id i11so714862wra
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 08:35:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pcQajxuwS5wFDEgTQPg5MBMTO7FAAusnVOmEtRUXGjUDBhZlDEJp3lYgd2RacMAmEwjNxFIUfg73GX/tMyjjEpFJouZCfq4TLzgrM5vrcWCnHW+XumnjcNE5+yj4zfIz/cGDFI6oPh5H2CJOyvwwR7H+ihQgorFCF/DQmWBxH0U=
Received: by 10.65.137.16 with SMTP id p16mr1852262qbn;
        Thu, 08 Jun 2006 08:35:16 -0700 (PDT)
Received: from localhost ( [59.92.206.214])
        by mx.gmail.com with ESMTP id f17sm878263qba.2006.06.08.08.35.13;
        Thu, 08 Jun 2006 08:35:15 -0700 (PDT)
To: Karl Hasselstr?m <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20060608133747.GA15374@diana.vm.bytemark.co.uk>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21496>

On Thu, Jun 08, 2006 at 03:37:47PM +0200, Karl Hasselstr?m wrote:
> On 2006-06-08 13:41:04 +0200, Johannes Schindelin wrote:
> 
> My vote goes to --no-local, but only if we also get a --no-no-local
> flag with the opposite meaning. Otherwise, I'd prefer --global. :-)
> 


I guess it makes much sense to rename the command to git-config and say 

git config  alias.l  -> for golbal config 
git config --repo alias.l -> for repo specific config 

-aneesh
