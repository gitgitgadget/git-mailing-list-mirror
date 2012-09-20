From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v4 3/6] Color skipped tests blue
Date: Thu, 20 Sep 2012 10:04:36 +0100
Message-ID: <CAOkDyE8uu4DWqKKAQTEcBCjmWXJfNueyJQuvJhAUaqnsihpkUg@mail.gmail.com>
References: <20120919201326.GA23016@sigill.intra.peff.net>
	<1348086263-27555-1-git-send-email-git@adamspiers.org>
	<505AAE34.2020408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 11:04:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEcgi-0000Y5-BM
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 11:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab2ITJEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 05:04:38 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34052 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab2ITJEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 05:04:37 -0400
Received: by bkuw11 with SMTP id w11so61365bku.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=15qSZ9oyjpCGZTzBLXkYUpgimVxEFsHD+Zi3qbbCDqA=;
        b=ALQMgditq3eruagbXrc27lUs/iyArANDDvCTZcdDMekpyVBJcnRjZs4aP/U8YZXssg
         vKBaLmyi1IdKn7Kso//VysBKC8+8kYcLrPyYYNQvNxT+ghA/iNoodE5mnSyzeo2jG1Fe
         cfQjpweJSLcYZTMpYuaoU3c1UNiar5eZD7uwf7MOMW619DyA9JM/kMdxZeEv/pVQGntf
         LhuWCleszAfEVZkCz5FRhaxtB8rJHZMxKGMbV/qp1ieCD0NNWav8OvUIQ7VviTEqprcL
         +VAqNaDVxP79jX/OGAe7OG7qIlDgEYsdgersHekMHWyf6QLpw6pLjq8417+bm1D4PvEu
         jAgA==
Received: by 10.204.148.86 with SMTP id o22mr315298bkv.59.1348131876135; Thu,
 20 Sep 2012 02:04:36 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 20 Sep 2012 02:04:36 -0700 (PDT)
In-Reply-To: <505AAE34.2020408@viscovery.net>
X-Google-Sender-Auth: UGvhhBb4d9WAFcZAEw58aTS31qg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206042>

On Thu, Sep 20, 2012 at 6:48 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 9/19/2012 22:24, schrieb Adam Spiers:
>>               skip)
>> -                     tput bold; tput setaf 2;; # bold green
>> +                     tput setaf 4;;            # blue
>
> It's unreadable on black background. Keep it bold; that works on both
> black and white background.

Whilst my preference aligns with yours in this particular case, we are
now on a slippery slope, since these days terminal colors are
infinitely configurable, and some heretics even choose backgrounds
which are neither black nor white ;-)  I don't want to trigger a long
discussion or end up spamming the list with lots of different color
scheme patches in an attempt to please everyone.  So bold blue will be
my last version of this patch.
