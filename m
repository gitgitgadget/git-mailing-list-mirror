From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 18:00:42 +0100
Message-ID: <81b0412b0512150900j5b328e2fu72ffd8820e5140b7@mail.gmail.com>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
	 <43A19962.2000202@zytor.com>
	 <Pine.LNX.4.63.0512151737240.3542@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 15 18:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmwTI-0007Mt-Gi
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 18:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVLORAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 12:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVLORAq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 12:00:46 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:47141 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750810AbVLORAp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 12:00:45 -0500
Received: by nproxy.gmail.com with SMTP id m18so137967nfc
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 09:00:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tK0eff3mhF4m48EMnhXDVmO6JocO0ipSdSEDowGYeXUifyEnCK4Pao9bZmSrDdotJfuqTlqnA2FvwtILsb+UswEVDK6OuBivZRZs4bNmr9AL6ckRxlJe+PCL+mcsLb8EalJ4ZkEPjHCRTutvG3Rp9Fsrhv4An0iAKguTc800hjw=
Received: by 10.48.223.11 with SMTP id v11mr99871nfg;
        Thu, 15 Dec 2005 09:00:43 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 09:00:42 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512151737240.3542@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13706>

On 12/15/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > If you're have to open-code it, you might want to just do it all the way:
> >
> I don't really care. I could have used !strcmp(cp - 1, "HEAD"), just as
> well...
>

...which would be more readable and greppable.
