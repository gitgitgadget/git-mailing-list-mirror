From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack extension
Date: Wed, 26 Oct 2005 11:16:15 +0200
Message-ID: <81b0412b0510260216s7571dba6w97163927a335818d@mail.gmail.com>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051025204754.GA8030@steel.home>
	 <Pine.LNX.4.63.0510252300290.15756@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0510252346t3806892dx71f9c0dc1efe4073@mail.gmail.com>
	 <Pine.LNX.4.63.0510261041100.7424@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 11:17:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUhOr-0000fm-GS
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 11:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVJZJQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 05:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVJZJQT
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 05:16:19 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:15841 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932570AbVJZJQS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 05:16:18 -0400
Received: by nproxy.gmail.com with SMTP id q29so20451nfc
        for <git@vger.kernel.org>; Wed, 26 Oct 2005 02:16:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uhBAmgVqPul2YedgvgDam5jwSR67BAqHO4bttLusFyb3Tz7mATQwBwNP0kR5oi0LyN5ROFMTyNvyqFSKv6ROlauQ91aL2110UzKM3RZGHpJS27PTCXxkoiCigsAM/9isnLhGeOC3rsz5DaIo/fUlbgoIYdo+8IDAVBZ4QwMV5Ug=
Received: by 10.49.5.14 with SMTP id h14mr162625nfi;
        Wed, 26 Oct 2005 02:16:15 -0700 (PDT)
Received: by 10.48.49.13 with HTTP; Wed, 26 Oct 2005 02:16:15 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510261041100.7424@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10659>

On 10/26/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Could you please try the patch I sent with the subject "[PATCH]
> > > fetch/upload: Fix corner case with few revs"? Your output looks exactly
> > > like what I fixed with that patch.
> >
> > I couldn't at the moment. Do you still need a test?
>
> If you have time and can test it, yes, please.
>

Will try. Which patch is it?
