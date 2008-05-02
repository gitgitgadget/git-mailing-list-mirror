From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Re: Parent-less branches
Date: Sat, 3 May 2008 01:20:10 +0200
Message-ID: <20080502232008.GA20092@ulrik-ibook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: win@wincent.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 01:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js4Z2-000850-T7
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 01:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937417AbYEBXU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 19:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935934AbYEBXU0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 19:20:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:51433 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937245AbYEBXUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 19:20:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1088313fgg.17
        for <git@vger.kernel.org>; Fri, 02 May 2008 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=9SG9gksPWHrZikCzBZKB7LDC+e6b5u983HurAcn6qAc=;
        b=l4GSn1XStuIK8p5GZ2o4e+I2i50/FZbi24TFkcDCUdn0k78C2cNDSbcthEQ1qaEAX8qRAZosoMw4Xp/Muhy3qNlJQ52dfHvc28ZgZ4vPVH0nVoBI2L3wa1CdHUUc1by33T78MAmNXq2o7kZEhhHpZJvV19wqF8DX+V+2hhQ7fkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Dq5ke8/4WstnAEmpcUNyCLBHp+j/N1dRVrGinCO2DaaFrQr+zmDME2QGpgwv6WDOzEB/roTNYaiFqTaWnELs/8TlmlSAorjCjBVgTxxKV/jjVNBeovvP/6FG39DjxmQ5S7a0rm6+2iIW5A3cKVdlqKf98NPl3nlcCGGplQKdUtc=
Received: by 10.86.73.7 with SMTP id v7mr5508965fga.37.1209770420394;
        Fri, 02 May 2008 16:20:20 -0700 (PDT)
Received: from ulrik-ibook.lan ( [87.176.182.60])
        by mx.google.com with ESMTPS id 13sm6057396fks.12.2008.05.02.16.20.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 16:20:19 -0700 (PDT)
Received: from ulrik by ulrik-ibook.lan with local (Exim 4.69)
	(envelope-from <ulrik@ulrik-ibook>)
	id 1Js4Xy-0005Ei-Ip; Sat, 03 May 2008 01:20:10 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81046>

> I wanted to do this just the other day, but I did it all inside the  
> one repo, and made some notes on the process here:
> 
> http://rails.wincent.com/wiki/Creating_independent_branches_with_Git
> 
> Basically, using "git write-tree" and "git commit-tree" plumbing.
> 
> Cheers,
> Wincent

I think I've seen this done much simpler, in this blog post:

http://madduck.net/blog/2007.07.11:creating-a-git-branch-without-ancestry/

Even though your instructions seem more complicated than they are since
they mix setting up the parentless branch and preparing the first
commit content.

regards,
ulrik

(I am not on the list, please CC)
