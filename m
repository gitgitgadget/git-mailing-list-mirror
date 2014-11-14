From: David Aguilar <davvid@gmail.com>
Subject: Re: --trust-exit-code not working
Date: Fri, 14 Nov 2014 13:55:28 -0800
Message-ID: <20141114215527.GA93845@gmail.com>
References: <20141114161235.GA30086@vimeitor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adria Farres <14farresa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:55:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpOq5-0000ow-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 22:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbaKNVza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 16:55:30 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49282 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbaKNVz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 16:55:29 -0500
Received: by mail-pd0-f181.google.com with SMTP id z10so154643pdj.26
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fKHRGFD3SHy22PIjiEhKeTwoi7fkbllwSJlycObLJZk=;
        b=d6ORABiQhCvr9gP5877quxu2S0Mu86aIIv1puvxh75CB7exaPItT/PUksYgulcPgGx
         NES/2KekN+aqvCu1yAg+quhwuX6yyFd1vTe5XQzG/L1M+Jw50N48BmHc38tRAPTKdnR4
         +BoMtPoSlV9uWcqtrqTZTdf71cI1y/+8tdxleZ4i9BTVQMktVZ8l9ZLq5vNOXwvOuzoV
         ZU1wDTWlZ2rhKXWI9hJh7pro5D69A+D33SH4NXo+E5WJXkH5rzgwxlLyn0j5FxXI7KWl
         m7S5ZEnchGQgDwuvpzNvG+bsd21HKAJ2aQ49iWyPwm4IKs6rxGZxkspkl9SI/rCCNCJt
         0SwQ==
X-Received: by 10.68.93.1 with SMTP id cq1mr12818062pbb.145.1416002129083;
        Fri, 14 Nov 2014 13:55:29 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by mx.google.com with ESMTPSA id i12sm5706179pbq.64.2014.11.14.13.55.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 13:55:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141114161235.GA30086@vimeitor>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 05:12:35PM +0100, Adria Farres wrote:
> Hello!,
> 
> I sent an email last week, but I'm not sure if I sent it incorrectly, or the
> formatting was very bad, or it went unnoticed. A few days ago a great soul was

Nah, I was just very busy and it slipped through the cracks.
Sorry 'bout that ~ I was meaning to get back to it.

> kind enough to create the --trust-exit-code option that made git respect the
> exit code of the difftool. Unfortunately, I haven't been able to make it work.
> Exiting vimdiff with :cq doesn't seem to make git quit, as it keeps pushing new
> files to be diffed. I tried meld and the exact same thing. I'm confident that
> exiting with :cq gives an error, as I have checked it, and I'm using git
> 2.2.0.rc1.
> 
> Am I missing something important? Has anyone managed to make it work with
> vimdiff and meld? Sorry for bringing that up so late and for being a
> disturbance.
> 
> Thank you,

Thanks for testing, Adria.

If you could test my new patch we would very much appreciate it;
adding a Tested-by: attribution line to the commit with your
name would be very nice.

cheers,
-- 
David
