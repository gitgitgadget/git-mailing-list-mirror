From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Sat, 28 Dec 2013 14:21:29 -0800
Message-ID: <20131228222129.GE5544@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 28 23:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx2GG-00013d-Od
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 23:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217Ab3L1WVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 17:21:33 -0500
Received: from mail-gg0-f181.google.com ([209.85.161.181]:51102 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3L1WVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 17:21:32 -0500
Received: by mail-gg0-f181.google.com with SMTP id y1so2084883ggc.26
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 14:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=icigG0iEYzI9dw3wk5p2G6o4FcZBbLbp41zAsupOP54=;
        b=QpFuhQzq6YHCUPNes9w0mSP5hAZmKYkBfUUbVdk8zPDIod5JA1dAr7Cb1c+9U6Vywb
         7h8jnhz1kpEDvMacdxSh72m/N1DCQCWYCzH6GlBscOk8lgrGx/Pw+dyBvI8dmYFA9HpY
         r22chtSGX9eiJjzc4WU72RjnGz4jPo7PNB55k2hOXjRXeK70R2vONJv4A4VlXCvqvr0v
         fiUodcelQiRoLbpR8oVW6m/hVcog9xeoKmiaLHVRwuCps+P4ShMUysPEG8mUCvFZK39Y
         wMVHwUauAiRD762vTBawhwpG1aQ2qEfWsBlynxYYbQu4tfYWpS5negi7I4KGpHkjMSyH
         LB2A==
X-Received: by 10.236.150.212 with SMTP id z60mr267368yhj.128.1388269292331;
        Sat, 28 Dec 2013 14:21:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id d7sm1499269yhd.24.2013.12.28.14.21.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 28 Dec 2013 14:21:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131228092731.GA26337@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239793>

Jeff King wrote:

> When I want to debug a failing test, I often end up doing:
>
>   cd t
>   ./t4107-<tab> -v -i
>   cd tra<tab>
>
> The test names are long, so tab-completing on the trash directory is
> very helpful. Lately I've noticed that there are a bunch of crufty trash
> directories in my t/ directory, which makes my tab-completion more
> annoying.

Ah, and if I'd read this then I wouldn't have had to be confused at
all.  Would it work to replace the commit message with something like
this?

Thanks,
Jonathan
