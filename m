From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Thu, 11 Aug 2011 15:16:04 -0500
Message-ID: <20110811201604.GI2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 22:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrbfq-0003yi-Aw
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 22:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab1HKUQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 16:16:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55596 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1HKUQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 16:16:08 -0400
Received: by yxj19 with SMTP id 19so1566626yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+0LnwH34dcByolpViBP/JHzBg/te3p1sn6YBnLIe6y8=;
        b=ImjFMs8Gcu8gFOsfGMFNe35SpFqSNHc7gTDhMbEwFmaUlLQJAbvisFlU01rX3aY/vC
         73kR/QyxPON+4bVXLSUWzQ0dk/g/CxjfKV0IO2ZI7KOYjw7k/6mKWCGTUHmaor+toPhq
         63TmJj9sbsqfdyX2C3KsxBI7VlpKs0tu0RdFc=
Received: by 10.150.32.9 with SMTP id f9mr1142005ybf.110.1313093767575;
        Thu, 11 Aug 2011 13:16:07 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id f5sm966333ybf.1.2011.08.11.13.16.06
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 13:16:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179141>

Ramkumar Ramachandra wrote:

> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -7,7 +7,32 @@
>  #define SEQ_TODO_FILE	"sequencer/todo"
>  #define SEQ_OPTS_FILE	"sequencer/opts"
>  
> +#define COMMIT_MESSAGE_INIT  { NULL, NULL, NULL, NULL, NULL };

I don't think this should be exposed.  The rest seems pretty sane,
though I haven't read the patch carefully.
