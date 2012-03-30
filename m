From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8 2/3] gitweb: refactor If-Modified-Since handling
Date: Fri, 30 Mar 2012 16:30:51 +0100
Message-ID: <201203301730.52615.jnareb@gmail.com>
References: <201203282328.08876.jnareb@gmail.com>  <8839345a047a7dee825565032029b1c08890a0f0.1333024238.git.wking@drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 17:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDdn2-0007JQ-J5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 17:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760609Ab2C3Pa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 11:30:56 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53627 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab2C3Paz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 11:30:55 -0400
Received: by wibhq7 with SMTP id hq7so717488wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TaPsRcpYOTX2BIn8WRcXVuxPXMYo50BsmLs/afK4LSQ=;
        b=lTBE/8AnW66s6Jwumxl7zZ3iaQa0pygj8bQg6jU3JxK9ncEW7Qtv1MQRu1khLVPfUH
         e1nf0v7/cne6QkFZhi4fm1bqzawwTz4m/YAdJmakTiFJYH7fBwdGpigNR/fbL0O9vnI1
         gYrPGj4kHMJXxtrREtd6u5ZRF2apOVDxkOVId/WgE38pulH90fH8muu2g8ujYGrnlq7W
         XL//TvcwvsBGduNaAynxJol64isPaC2XR+/POUyuFu1Mhch/DOjA87XRaNn6P2aVaRTX
         yKlvXN5S98N9qn+7hJOxg0b0tkalf42YJDWjix1rebqN7gvL3RVa2NSNkqD7jDt2Nrue
         mbfw==
Received: by 10.180.102.129 with SMTP id fo1mr7509859wib.6.1333121453717;
        Fri, 30 Mar 2012 08:30:53 -0700 (PDT)
Received: from [192.168.1.13] (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id j3sm11577827wiw.1.2012.03.30.08.30.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 08:30:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8839345a047a7dee825565032029b1c08890a0f0.1333024238.git.wking@drexel.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194367>

W. Trevor King wrote:

> The current gitweb only generates Last-Modified and handles
> If-Modified-Since headers for the git_feed action.  This patch breaks
> the Last-Modified and If-Modified-Since handling code out from
> git_feed into a new function exit_if_unmodified_since.  This makes the
> code easy to reuse for other actions.
> 
> Only gitweb actions which can easily calculate a modification time
> should use exit_if_unmodified_since, as the goal is to balance local
> processing time vs. upload bandwidth.
> 
> Signed-off-by: W Trevor King <wking@drexel.edu>

Nice and clear.

  Acked-by: Jakub Narebski <jnareb@gmail.com>

Perhaps the second paragraph of the commit message would read better if
it started with "Note that only ..." or something like that, but this
is not that important, and not worth another round.

-- 
Jakub Narebski
Poland
