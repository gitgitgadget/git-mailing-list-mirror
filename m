From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] Call it "Git User Manual" and remove reference to
 very old Git version
Date: Sat, 24 Aug 2013 20:05:17 -0700
Message-ID: <20130825030517.GA2882@elie.Belkin>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <119602113.1090836.1377329085278.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Aug 25 05:07:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDQfh-0005AZ-6Y
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 05:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab3HYDF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 23:05:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43980 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab3HYDF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 23:05:26 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so2113401pab.6
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 20:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e0+0q34XW2tROp/sEu5Ph1XjwzDVL4VTWkSZ5sR4mMo=;
        b=XhCzo0y1g7HIxPTn8m4qovwt6+USvReKzkLU+MLjUdK2yc2xliuuM7YKJXCmpBLkme
         6+GtIl4Cs0siUdbVX6E5BZv1HQotryTftWxZeK9RFYV5KLbxAx/ZqZNNj1ILgGWQBY3K
         lea09Ta2ghUMQFf3n9GgpsR0nQ1deo3xf/VaJlykQmcQM7JwNOm6gSwl2sF2fejdSvMq
         mxoVgttCtb5xLOR4Pf9KOyp28oTezSZOzBgJ+OFGDxkS52muu2EXIc19l0UKLqqvUL6/
         62YzFrKt77OeFjjLSDYcoYaAc7fmOVGsQZ7zrRyhIviVtUzYtRMLbcAcwTFLPpIsj8bT
         /ahw==
X-Received: by 10.68.229.2 with SMTP id sm2mr7883876pbc.68.1377399925768;
        Sat, 24 Aug 2013 20:05:25 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id w6sm9192927pbt.32.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 20:05:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <119602113.1090836.1377329085278.JavaMail.ngmail@webmail08.arcor-online.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232896>

Thomas Ackermann wrote:

> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1,6 +1,5 @@
> -Git User's Manual (for version 1.5.3 or newer)
> +Git User Manual

"User" versus "User's": why?  But I don't care much about this.

Dropping the reference to 1.5.3 is very welcome, since it should help
people to update the manual without fearing that new sections will
fail for people with ancient copies of git.  For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
