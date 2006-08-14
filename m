From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 17:14:36 +0200
Message-ID: <81b0412b0608140814h227517a0l5857389c84ef8ff8@mail.gmail.com>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com>
	 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 17:15:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCe9K-0007pe-Mn
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 17:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHNPOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 11:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWHNPOj
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 11:14:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:865 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750790AbWHNPOi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 11:14:38 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1825976nfb
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 08:14:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NSxohrTPAgA2Fncec54s870iupEbpAtahSnWOvKO4SC8Oqg+WP5RWt1oYk80kaMEE3Qzkgi95UzfpbZRF86huDpf8YpW0Qaq9kmwXnnoly1Uky3RHaL1xI1uhW/NgoMvyPrrW96BDfvzGPJgH9JwggnnGQNid4bEP+Zomi9XFQY=
Received: by 10.78.150.7 with SMTP id x7mr3281943hud;
        Mon, 14 Aug 2006 08:14:36 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Mon, 14 Aug 2006 08:14:36 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25359>

On 8/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> Changing the probabilities probably won't help much, but there may be
> good gains from partially eliminating 1M encoding maps.

will the old git installations, without the maps, still be able to decode the
pack created this way?
