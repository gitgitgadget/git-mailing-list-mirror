From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] Careful object pulling
Date: Wed, 4 May 2005 05:35:10 -0400
Message-ID: <118833cc050504023569e00d38@mail.gmail.com>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
	 <Pine.LNX.4.21.0505040004290.30848-100000@iabervon.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 11:29:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTGBn-0002Vg-Tc
	for gcvg-git@gmane.org; Wed, 04 May 2005 11:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVEDJfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 05:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEDJfN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 05:35:13 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:52097 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261559AbVEDJfL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 May 2005 05:35:11 -0400
Received: by rproxy.gmail.com with SMTP id a41so126900rng
        for <git@vger.kernel.org>; Wed, 04 May 2005 02:35:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JiG7PVFtL4h0NTH+zbAMyFjITqMMYloUAqj/phFDGMOshlLFVSyg33ukZqk/xaq6AQeVcMkOaUfzyowm1dBajKuVQmIoF6qNLG5Uk7nnGMa+rvzF6XAqX8qPhYyv55nJdo0POifv0ZUUxIK5qkI7ZRb/LJcEQuC/3t6yqntozR4=
Received: by 10.38.86.11 with SMTP id j11mr934185rnb;
        Wed, 04 May 2005 02:35:10 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Wed, 4 May 2005 02:35:10 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505040004290.30848-100000@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Something's fishy there.  You are comparing the result from link with EEXIST.

Morten
