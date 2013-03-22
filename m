From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Fri, 22 Mar 2013 11:29:44 -0700
Message-ID: <20130322182944.GH12223@google.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:30:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6jK-000191-23
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792Ab3CVS3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:29:50 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:48715 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422719Ab3CVS3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:29:49 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so1295853dal.40
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jFWm2Zg5amM81od3EqdFdQ2V2HNi2oxWUDGEfp8FAqk=;
        b=pRSzfi3SniwP+7PIpXzn5qvDUoSGLMZOb3gAHPnYxuwS6kJp4yPPduY+0AEwbN/KzH
         TvT659pe/v8WYcezn+WUf6aH2y7Ae+fgu9DDCEPRqOhIJ5R92/pfx0g9pwMg1bZ/UnUL
         faeSaZijRSwbWaG71FHr6FfqCEhxFTcXwG+vtZ8W6/91NotHHYs277NKDL/QIEANNUCY
         tmkkLPNN1Ia4UNrsuv47H/7s0eUXCtdLEpPXPRUmlAeBYwPxu50bm4hKwp5onz+cwjr8
         jAx7SYsonbGZVoP1Ib/Dds3PahYW56veV/76LG77OEtAKfhh2Gzg96l4+BiAHvuo0WLP
         1NUg==
X-Received: by 10.66.123.5 with SMTP id lw5mr4872771pab.132.1363976988941;
        Fri, 22 Mar 2013 11:29:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 1sm3233003pbg.18.2013.03.22.11.29.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 11:29:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363938756-13722-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218833>

Ramkumar Ramachandra wrote:

> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='fetching and pushing, with or without wildcard'
> +test_description='fetching and pushing'

The description before and after are equally useless.  You might as
well use the following description:

	test_description='t5516-fetch-push.sh'

(Please don't actually do that.)

I gave a sketch of what I think might be a more useful description and
got shot down without an explanation I could understand in reply.  So,
this one needs more work I guess.

Hope that helps,
Jonathan
