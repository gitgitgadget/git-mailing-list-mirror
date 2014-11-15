From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Fri, 14 Nov 2014 16:27:11 -0800
Message-ID: <20141115002710.GA72216@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 01:27:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpRCt-00074V-NB
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 01:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162011AbaKOA1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 19:27:12 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54712 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161999AbaKOA1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 19:27:11 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so4928934pab.21
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 16:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=PBqOJISo9rrYV7E2CnX/KfLv+y41/qgoYBH7uKujj98=;
        b=A68OtF0ZKx3wHleVTutG27ecOx40EDZQESp+jWx6nKTnuteQTpIwlqrvFYduQHdEg+
         0y7Htzj2eUv1/2lQAuQc7s93Za7HCvjrXAXJAosolfs13QXBwdZxq2/dMnzlUK+NEKpB
         nuBcIxRYtDntttvlkkouyXPcFaEm1RY1u3MfGFIEJCnYQe0X/s1du+kQSw0uQ/TUbdxQ
         5IZzubElk5F/wb+sKD1+ss1NOugrPyhdWSy9hEgzl893AiJLBn95jTM4HRvAgaTZ9gZw
         B9OPaRl1A/mPl1YUZtBNBYeXCxUIagx12yFmMn2vF7NnSRfMrpkftExn6jOo6WhsRxfz
         5cZA==
X-Received: by 10.68.239.71 with SMTP id vq7mr77328pbc.155.1416011230701;
        Fri, 14 Nov 2014 16:27:10 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id zw1sm28501020pbb.82.2014.11.14.16.27.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 16:27:10 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Adri sent me this directly but I think it should have gone to the list.

Adri, if you don't mind, Junio can add:

Tested-by: Adri Farr <14farresa@gmail.com>

...to the commit message trailer since it looks like it's happy.

Thanks for testing!

cheers,
David

----- Forwarded message from Adri Farr <14farresa@gmail.com> -----

Date: Sat, 15 Nov 2014 00:10:12 +0100
From: Adri Farr <14farresa@gmail.com>
To: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools

I have tested this patch both in vim and meld and it works
wonderfully. Thank you for the time put into this. I should have
provided feedback back when the patch was proposed. I guess it's never
too late :).

2014-11-14 22:57 GMT+01:00 David Aguilar <davvid@gmail.com>:
> [snip]

----- End forwarded message -----
