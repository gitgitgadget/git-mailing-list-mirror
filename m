From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Thu, 30 Aug 2007 18:01:46 +0200
Message-ID: <cb7bb73a0708300901j6ae83730p20d272c317de9116@mail.gmail.com>
References: <faulrb$483$1@sea.gmane.org> <20070830102115.GA17620@muzzle>
	 <cb7bb73a0708300444q73e12d72o665a8266c2a90f61@mail.gmail.com>
	 <20070830122514.GF5050@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 18:02:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQmSv-0004wr-EJ
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 18:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284AbXH3QBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 12:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758369AbXH3QBt
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 12:01:49 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:44078 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181AbXH3QBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 12:01:47 -0400
Received: by py-out-1112.google.com with SMTP id u77so2943634pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 09:01:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQt4HlReOw3sP5QCxzMgT5nPApACDoIZ4mgZBTVb8wFmSgBaJCbyOA511Z7U34ywk6AxyXpyqDxHrEt10nq2k47BOr4V4kXUPcalB96PbHHVpjUkqQBT9Y/63uw4dEw7WrNExzIkTWHAQUAGbL8L/uscujB7gwQzCco8MehD4MY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=go0a3L1d6ktPJKHrKzDN5+pLD75e15e8eEJUVEig6QsVePjFM5xzJFgCaOHbb7DtZIukqNSR5lgLnApZkquX/D5FcwrrfaBGTCUxcOMKih+6Y2rETrc3pUk06qPAy3NBHC8zkn4mQbcWJz1x2pyjlIjd4r5ys4dIOXE4hYSbf1U=
Received: by 10.35.78.9 with SMTP id f9mr770811pyl.1188489706354;
        Thu, 30 Aug 2007 09:01:46 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 09:01:46 -0700 (PDT)
In-Reply-To: <20070830122514.GF5050@xp.machine.xx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57048>

On 8/30/07, Peter Baumann <waste.manager@gmx.de> wrote:
> On Thu, Aug 30, 2007 at 01:44:35PM +0200, Giuseppe Bilotta wrote:
> > While we're at it: could you consider putting the svn-imported refs
> > not directly under remote? something like refs/remote/svn would be
> > rather cleaner.
>
> Did you have a look at the --prefix option mentioned in the manpage? I
> think it does what you want.

Uh, it must have escaped me, thanks.

(Still, it would make sense to have a non-empty default.)

-- 
Giuseppe "Oblomov" Bilotta
