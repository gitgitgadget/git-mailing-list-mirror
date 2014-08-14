From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Thu, 14 Aug 2014 15:29:39 -0700
Message-ID: <20140814222939.GA32124@google.com>
References: <53ECA7DB.7060407@jump-ing.de>
 <53ECCA14.40900@web.de>
 <53ED0257.3070505@jump-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Markus Hitter <mah@jump-ing.de>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:30:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI3X6-0005mt-1c
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 00:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbaHNWaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 18:30:01 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51230 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbaHNWaA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 18:30:00 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so2320325pde.18
        for <git@vger.kernel.org>; Thu, 14 Aug 2014 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f1sa6xdXR7dm2bugIGAphHHVyaRyGxVW7wtpQ29wTTg=;
        b=pHa8bNTWQxXxeOiNVIPJL+nX2ZtZECzWNrNwW3uSDeLKDXUOpNyIyIvzz+PkvshPF2
         pnpTPpbyRb8fMLXl72ivyK6jRiCWoTbAGOx/1t4knuHhPFYba/ZZH+daUmu7kY1aG7jr
         uj1lRaIqrF7CI9HDH1uAc4KN3WBXRvzKpydVa/n2rn4/k1nw8XnHnpK9mTi1gZsdGibJ
         VmWjojoL7Gk19RfWHENphxdGIF2VWsiwswQB3ZRKCno/3/P5qtXSTb6WS+dnRDS8x+5L
         jggv0YaNfb1iM+YmXvSv6X5pLaHLp0Swoao5XelKeptkj/NUu2AEy6jMaSV0Mnsit2C3
         fdYg==
X-Received: by 10.66.165.34 with SMTP id yv2mr7180097pab.27.1408055399752;
        Thu, 14 Aug 2014 15:29:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:9dd6:74a0:f3e:9f14])
        by mx.google.com with ESMTPSA id uk6sm17690493pac.13.2014.08.14.15.29.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 Aug 2014 15:29:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53ED0257.3070505@jump-ing.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255276>

Hi Markus,

> export NO_APPLE_COMMON_CRYPTO=yes
> make configure
> CFLAGS=-O2 ./configure --without-tcltk --prefix=/usr/global
> make all
>
> compiles fine on 10.4.10. Would a configure patch checking for the
> existence of CommonHMAC.h and, if not found, defining this variable, be
> acceptable?

Yes, that sounds useful.

Orthogonal to that: a patch to the Darwin section of config.mak.uname
so you can build without the 'make configure' would be even more
welcome. :)

See Documentation/SubmittingPatches for details about how to
contribute to git.  (Or if you're short on time, see section 5 of that
file, "Sign your work", and then push your code somewhere and tell us
about it.)

Thanks,
Jonathan
