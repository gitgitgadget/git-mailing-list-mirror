From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 3/8] ident: make user_ident_explicitly_given static
Date: Wed, 14 Nov 2012 23:51:25 -0800
Message-ID: <20121115075125.GC8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003405.GC17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:51:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuEm-0004RG-QL
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 08:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423625Ab2KOHvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 02:51:32 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38571 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423605Ab2KOHva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 02:51:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so974511pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 23:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qvNpugvjrARJKeZW0uAej0DaLeeM7SNrIHTfgwxPxhU=;
        b=sUjnwD7c3MFyfIBSVV7ANj4X4kgIjmjsopRpJUkoNKslftKitXEHGpuS15XIKiGMx6
         H++XvYO6whXWgVeP8jqUKS3bsTg7AZeF2LdkBMFwX6ha13HW+TTWV/dyuMHOwZ/wELKv
         svOjamWtAikZgYfaWCYJhrRMQ/UxcVl45eub0AGwCg9zB4pDwN0bhhVZPCI+WioTESl5
         dzayUasqgXkug3RaH0djIXNGfU0vjsCldTwBgrU1Q3C9VSVY2E3h1pKp1pB1hq/grofw
         hVx4Gu83TGq8X2geRbo3/qqByqoLxBQgdB/9u6Cynzy4BIUgiiYJnyBXTvTLvHrCLOQi
         LGUw==
Received: by 10.66.88.136 with SMTP id bg8mr846086pab.54.1352965890110;
        Wed, 14 Nov 2012 23:51:30 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id bc8sm9331079pab.5.2012.11.14.23.51.28
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 23:51:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003405.GC17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209804>

Jeff King wrote:

> In v1.5.6-rc0~56^2 (2008-05-04) "user_ident_explicitly_given"
> was introduced as a global for communication between config,
> ident, and builtin-commit.  In v1.7.0-rc0~72^2 (2010-01-07)
> readers switched to using the common wrapper
> user_ident_sufficiently_given().  After v1.7.11-rc1~15^2~18
> (2012-05-21), the var is only written in ident.c.
>
> Now we can make it static, which will enable further
> refactoring without worrying about upsetting other code.
>
> Signed-off-by: Jeff King <peff@peff.net>

For what it's worth I liked the old commit message more.  But I don't
mind either.

Hope that helps,
Jonathan
