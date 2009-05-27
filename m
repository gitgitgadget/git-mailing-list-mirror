From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 23:37:36 -0700
Message-ID: <20090527063735.GB2986@gmail.com>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com> <1243394364-13772-2-git-send-email-davvid@gmail.com> <4A1CDF11.4080507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 27 08:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Clr-0000AE-Ai
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 08:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759390AbZE0Ghn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 02:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759081AbZE0Ghm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 02:37:42 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:58152 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbZE0Ghm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 02:37:42 -0400
Received: by pxi29 with SMTP id 29so222123pxi.33
        for <git@vger.kernel.org>; Tue, 26 May 2009 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PRkqL1IiO0C8mpNQAlKBNQZSAn9NwxRL0ubuQQiLKyY=;
        b=xU4VKy370EOxFH1E9DyeAPdPJZ4sipOkTQncPYNHxHSdZJN0LmBKRlUFI6IryhLNaP
         T1EnV4FBH3vYPHDfWQnjW+2xqv48Hc8tn+uux+K9BgC1NIxL4aTv+GShtVW2K3EhAMKR
         zfclqtopoep5tNrllP6y8VN1eilFAOZDrVfWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M7xt4KfeHPfAXMt2KTkddoFMi3aQrX+sXGW4GNBOLqTfZWzEyFUVa757JRWgsXgogC
         eZxQDXVlwRSd+0L/y7BK59uXWthb4iu/YWyfuxJQbFfO5zKs8T8SzX6DXW+PMBqMora+
         wNrWiWlY+idX2eWe42SBS3l8tu5sXMivzYZ9k=
Received: by 10.114.122.9 with SMTP id u9mr19178228wac.129.1243406263525;
        Tue, 26 May 2009 23:37:43 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l28sm18477038waf.19.2009.05.26.23.37.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 23:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1CDF11.4080507@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120037>

On Wed, May 27, 2009 at 08:34:57AM +0200, Johannes Sixt wrote:
> David Aguilar schrieb:
> > +#include <libgen.h>
> 
> We don't have libgen.h on Windows :-( (at least not with my aging gcc
> 3.something). Would you please open-code the call to basename()?
> 
> -- Hannes
> 

Thanks for catching that.
I'll roll that into the next version.

-- 

	David
