From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 22:24:26 +0000
Message-ID: <200703022224.28678.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <Pine.LNX.4.64.0703021249010.3953@woody.linux-foundation.org> <200703022221.38309.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 23:27:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNGDk-0004XK-MI
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 23:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbXCBW1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbXCBW1S
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 17:27:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:5671 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030638AbXCBW1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 17:27:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so832906uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 14:27:16 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uuBA50ktlpu7vLxa5ZAjypBxErN1F4UZvHvOwHsh17XC1kwsbcbsELYTsJCGe4jY+6OghMwn8Vb+ht+zGGZdRENN62uucCFoXTuqhxXQnYHjNDAmr3y+C+ZiWZ+iyFJG5Xu75yT53Jrxa6ZDmqLzTUo5a0P/zp7Mygm/dpnLYlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e9+gGUgL09ytz6mbOtK/Z9pIAQfPR5NXqiWJZbDJ2zEubrZY+30L4TJdmchVm5dHRWLNylxK3ThVTt5y5syDw/1ezcJjNyq5iGyF27yYkg1yl+ru7LXJ6Evb+XpZP43PUZcYsbClEZvDxZCPgqArcGI6HPB+TRfDTjDJV2TZtCk=
Received: by 10.67.19.20 with SMTP id w20mr3940685ugi.1172874436517;
        Fri, 02 Mar 2007 14:27:16 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id l40sm2962930ugc.2007.03.02.14.27.14;
        Fri, 02 Mar 2007 14:27:14 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <200703022221.38309.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41255>

On Friday 2007, March 02, Andy Parkins wrote:

> There is an alternative.  pager.c:run_pager() runs a select() to wait
> for data before it actually exec()s the pager.  What if after the
> select() the process didn't exec(), but read the first line to decide
> what pager to exec?

Duh!  I see now that that is almost exactly what you did in your patch.  
Ignore me.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
