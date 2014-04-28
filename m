From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or
 CURLDIR
Date: Mon, 28 Apr 2014 16:30:16 -0700
Message-ID: <20140428233016.GR9218@google.com>
References: <1398718883-5630-1-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kusmabite@gmail.com, gitster@pobox.com
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wev0Y-0007ZB-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991AbaD1XaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:30:23 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33294 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964AbaD1XaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:30:19 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so1976228pde.22
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5an1XO5zD0fmsihxkv9o4YQwKeMz3OfWT5mT9EGXhmY=;
        b=inv0nbyOkwWjdPUnrByHaQ14fTdiTz6t9n4BgeyzTc9uhGJ1OdqZxV//9rS1VkGh3P
         L6UmudoyAmH76yr7xKINJCSmmDdhD+8ipPKw8hkbvLpdababdnV2eoUemcoiQWONQ44B
         hFYOaYcr2f9mbVL3E/5ut4YO8LaMAVF6iFKFymhArQm/wkdZ6q9xCci3f3eMoYqeqEsW
         fHdHJJQ/nXbXSR1EXzTBXd6RgmiT3wKZC4OMGsurI0j+Y3AVCITMNDdP3EkjbGekLnuq
         3vlXMK11XICXsr7pYHRcMDkdj2q0EkFfnpGxvGVC7UxZ525dsHNXcFYFJs6EHxuvmIAw
         vpOA==
X-Received: by 10.67.1.106 with SMTP id bf10mr28360972pad.78.1398727819329;
        Mon, 28 Apr 2014 16:30:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk3sm37452333pbb.65.2014.04.28.16.30.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 16:30:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398718883-5630-1-git-send-email-dborowitz@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247494>

Dave Borowitz wrote:

> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Makefile | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the quick turnaround.
