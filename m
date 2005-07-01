From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Trivial sed fix up in t/t6001
Date: Sat, 2 Jul 2005 01:51:06 +1000
Message-ID: <2cfc40320507010851259a7e85@mail.gmail.com>
References: <20050701135516.87892.qmail@web41208.mail.yahoo.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 17:44:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoNg4-0005Ey-5t
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 17:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbVGAPvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 11:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVGAPvM
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 11:51:12 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:57348 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263375AbVGAPvJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 11:51:09 -0400
Received: by rproxy.gmail.com with SMTP id i8so269229rne
        for <git@vger.kernel.org>; Fri, 01 Jul 2005 08:51:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J/5rt7xNaLfhdotOEnShL9HhVn1/DlsySzjDIOBBTPHKxQk/Xg6aPNgHssQuDrtS4yWbjH4IZp2+6ExyLr8nNmSv4rzmQro8sQe8fT+oXPZnO+PR1QBH/8/VMqMg4S+Eqenchq7TexT0uDOGaDtaf+CLNAz2UGnadmPJjVJPCgo=
Received: by 10.38.104.15 with SMTP id b15mr1025187rnc;
        Fri, 01 Jul 2005 08:51:06 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 1 Jul 2005 08:51:06 -0700 (PDT)
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050701135516.87892.qmail@web41208.mail.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 7/1/05, Mark Allen <mrallen1@yahoo.com> wrote:
> Change the sed seperator in t/t6001.
> 
> This trivial patch removes the semicolon as the sed seperator in the t/t6001 test script
> and replaces it with white space.  This makes BSD sed(1) much happier.
> 
> Signed-off-by: Mark Allen <mrallen1@yahoo.com>
> 
> ===
> 
> Jon,
> 
> If you could ack this patch or incorporate it into your tree, I'd be very obliged.
> 
> Thanks,
> 
> --Mark

Ack'd. I have also re-applied it to the code I moved into
t/t6000-lib.sh in my recent patch series, so it is fit to go in one
way or another!

jon.
