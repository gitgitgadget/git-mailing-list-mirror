From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] t3040 (subprojects-basic): modernize style
Date: Thu, 8 Dec 2011 10:34:48 -0600
Message-ID: <20111208163448.GA2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 17:35:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYgw1-0007ai-FC
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab1LHQe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 11:34:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61913 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1LHQe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 11:34:56 -0500
Received: by ggnr5 with SMTP id r5so2199376ggn.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VIxY0x1wRKUfqXg3FGOBOA1n4FNa7AYpuMt0yQhSWYA=;
        b=hl+yMzUZLJTq29STFbBPauXYeof/Fc2Xb7TX9mc2ByAplTp39d7A3DLYkP8B5koygQ
         tNhOBno3CMX+jFPTBmCUFNlYcj6CRAlKA3LWu7i1IbI12PhXWz6d4J9VDLu8eo0GdYT6
         fILPyi7DYJqrx16uRJc8frWYKHnr7WIrpHJ5A=
Received: by 10.101.184.19 with SMTP id l19mr878414anp.102.1323362095612;
        Thu, 08 Dec 2011 08:34:55 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c44sm9869705yhm.5.2011.12.08.08.34.54
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 08:34:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186568>

Ramkumar Ramachandra wrote:

> Put the opening quote starting each test on the same line as the
> test_expect_* invocation.  While at it:

I suspect the above description, while it does describe your patch,
does not describe the _reason_ that the patch exists or that someone
would want to apply it.  Isn't it something more like:

	Make the following changes pertaining to &&-chaining, for some
	good reason that I will describe:

	- ...

	While at it, clean up the style to fit the prevailing style.
	That means:

	- Put the opening quote starting each test on the same line as
	...

I didn't read over the patch again.  Has it changed since v1?
