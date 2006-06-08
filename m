From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 21:02:37 +0530
Message-ID: <20060608153236.GA8047@satan.machinehead.org>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 17:34:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoMV9-0008IU-9a
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 17:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWFHPcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 11:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWFHPcr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 11:32:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:16785 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964874AbWFHPcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 11:32:46 -0400
Received: by wr-out-0506.google.com with SMTP id i11so714250wra
        for <git@vger.kernel.org>; Thu, 08 Jun 2006 08:32:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bynkfU9wieLiK3xAOvkgVbJ7EpL8LofyKPBOjId9m8RoM1LUiR3AgDW5dU3QL4gBzCGFTs6Q1p1ItWwtM8A4TwN0ftb7rx/EObs1IBK22v4pf+PfcGeJHB1d3+zkJ80cT4xxWtWPaWuadJQRcYFc0U1RrefYdlzYjkKUk1d8dWc=
Received: by 10.65.236.9 with SMTP id n9mr1846888qbr;
        Thu, 08 Jun 2006 08:32:44 -0700 (PDT)
Received: from localhost ( [59.92.206.214])
        by mx.gmail.com with ESMTP id c6sm877335qbc.2006.06.08.08.32.41;
        Thu, 08 Jun 2006 08:32:43 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21495>

On Thu, Jun 08, 2006 at 01:31:46PM +0200, Johannes Schindelin wrote:
> 
> Since there is a global config now, we need a way to access it
> conveniently. Now you can say
> 
> 	git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."
> 
> to set the alias globally (it will be stored in ~/.gitconfig).
> 

how about  making the above 

   git config --repo alias.l "log --stat -M ORIG_HEAD.."

-aneesh
