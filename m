From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix fixed string (non-regexp) project search
Date: Tue, 6 Mar 2012 13:40:19 +0100
Message-ID: <201203061340.19547.jnareb@gmail.com>
References: <20120228183919.26435.86795.stgit@localhost.localdomain> <201203022334.25544.jnareb@gmail.com> <4F550EAE.5030006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 06 13:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4tgq-0002P4-Kn
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 13:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463Ab2CFMkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 07:40:24 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42369 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030426Ab2CFMkX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 07:40:23 -0500
Received: by eekc41 with SMTP id c41so1866511eek.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 04:40:22 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.10.196 as permitted sender) client-ip=10.213.10.196;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.10.196 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.10.196])
        by 10.213.10.196 with SMTP id q4mr1394275ebq.294.1331037622544 (num_hops = 1);
        Tue, 06 Mar 2012 04:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=1aKNZLmZ2es/l7q27XhfqePr1vzB5RuoLWcZCAZr+jw=;
        b=EdOITJIsela8zRDceufQSIQZfB7rEY7a26tp+Z/3WgnR/BbqCMoSm+HiLf5Xbz88tS
         QQzJ8+e4v8t2+tJzd1ro90GOCC4v1HeaqJBudrtku9FgOHn5VSj2Y05/2RE1Gvn6IGA1
         AhRy61Qp4iaSVUl/rnYwHAVQqiFk8WZMM8g7Yp7pPhQYFOx5VYoKx+rTuNaE2Vy3NPvl
         WrUVuQanbFdWMB/a9Fj++fd7raodqeEYqRU3T2fXBOIMKs4PtWONvroiHdMPeTINojve
         CJMmHM5poJ3R14ErVuRoyPY6YhaqpZsKlBrbX7+Td5k5KdNHKqjnCU85kYnFKmVGZ8eF
         r1vA==
Received: by 10.213.10.196 with SMTP id q4mr1059077ebq.294.1331037622401;
        Tue, 06 Mar 2012 04:40:22 -0800 (PST)
Received: from [192.168.1.13] (abwf76.neoplus.adsl.tpnet.pl. [83.8.229.76])
        by mx.google.com with ESMTPS id s48sm74119706eem.0.2012.03.06.04.40.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 04:40:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4F550EAE.5030006@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192340>

Ramsay Jones wrote:
> Jakub Narebski wrote:

>>> This patch solves the problem for me when using a regex search
>>> (re checkbox checked), but *not* for a non-regex search.
>>>
>>> If you have a leading '*' or '+', in the non-regex case, then you
>>> still get the above complaint (and xml error page etc.), although
>>> the line number has changed slightly from that given above.
>> 
>> Ramsay, please provide those line number in the future, together with
>> line and if possible some context.
> 
> Yeah, sorry about that; when I wrote that I didn't have the information
> readily available (I would have had to shutdown Windows, boot Linux, ...)
> and I was about to go out.

You could have told us _that_...

> So, the choice was to wait about 24hrs to report 
> with full info, or provide the feedback earlier; I chose the latter. ;-)

That's understandable.


Thanks again for reporting these issues.

-- 
Jakub Narebski
Poland
