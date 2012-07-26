From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Wed, 25 Jul 2012 19:26:12 -0500
Message-ID: <20120726002612.GA3038@burratino>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
 <1343196066-81319-2-git-send-email-schwern@pobox.com>
 <20120725212418.GA17494@dcvr.yhbt.net>
 <501075B2.8090205@pobox.com>
 <20120725230833.GA23993@dcvr.yhbt.net>
 <501088EC.50405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 02:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuBuM-000689-5A
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 02:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab2GZA0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 20:26:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53097 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab2GZA0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 20:26:21 -0400
Received: by yhmm54 with SMTP id m54so1387439yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jqvU+cEFeSu6Xe/dXKTWkq4Iacj8FAVOtdnHf8HqLiU=;
        b=0ZJjYT7sNghPudyeweq5jpOZW9hY1AZCxa+W7h10J9A0WD++urg2ju5GnMHwC/gJQh
         h14FdnO2K0ePbvScHyP7Fit7ZNtYZttuZx1lNRDiY3pweRz5XSpB1nriej348UuhPm5Y
         My/z64RyfC4tWP7I/2b2hzhHPciUG8PiIVok5wGwV1MARvA1QVhQA7kz1USmGG/HZ+Qt
         O2JNoWRexA5pAKK8ewxhR6oAltBvo+RP4ABd898ikSpG1lgrM5+zjsOLgpOvc8N+MNy5
         VGVf60EAtofjxTheQh4XhhQiYF93t2+H3ol+PDd9IFj6ePUjZpErJbM+5qEeysBLv74x
         BBQA==
Received: by 10.236.191.6 with SMTP id f6mr25454560yhn.126.1343262380497;
        Wed, 25 Jul 2012 17:26:20 -0700 (PDT)
Received: from burratino ([64.107.3.56])
        by mx.google.com with ESMTPS id i65sm39360714yhb.3.2012.07.25.17.26.19
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 17:26:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <501088EC.50405@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202220>

Michael G Schwern wrote:

> This is rapidly getting into the weeds.  Regardless of the debate below, what
> would you like me to do?  Switch indentation to tabs and resubmit?  AFAIK only
> the new tests are affected.

Yes, please do so at some point before the final submission.  (If
there's more feedback coming for this generation of the patches, no
need to resubmit right away unless you want to.  In general, when
getting review a useful strategy can be to discuss proposed changes
and batch them until the discussion seems to have died down and only
then resubmit the next version.)

If we want to switch indentation styles (not a traditional way to
start working with an existing project, but whatever), that would be a
separate change, affecting all the code consistently.

Thanks,
Jonathan
