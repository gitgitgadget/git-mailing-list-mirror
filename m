From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 03 Dec 2007 12:19:29 -0800 (PST)
Message-ID: <m3lk8bv8du.fsf@roke.D-201>
References: <20071203191143.GB17671@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 21:20:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzHlk-0004nf-1M
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 21:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbXLCUTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 15:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbXLCUTg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 15:19:36 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:53260 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbXLCUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 15:19:35 -0500
Received: by mu-out-0910.google.com with SMTP id i10so38107mue
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=OVDuaGF3UHC9HYhSruyH99yAyzztfCFwJXxZNElmZRg=;
        b=hYiIgrtE2e7+ovb5wp8aFC4TcHTIoVanD6BsLQaV6sJ5MMxbshW9S2b/2kQvTFf6aY7b7RXTkW1qaJQrITFiKUIGbcpW50oWfsat4fuzSzTJ8LrNjeMm9/fNNnbmNbxCqIiXtnrPU87oltSsm29AkfF2Qu3kf9sKPD5gX6bXsIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=rEHB1QDVDj6sLPFAJzvh6PAf1OQ6yXof7OkmY+k5q5lb7N1SbnO0DPMw3rZfeguYuYkG8uD+pBnWoCfNkTOIQ6N+WZK8zkQpqf5Ue8kPg7XejoP7/SDWxTQUs7Q02lJIQFrFedM4wOYv0N8GX7y/997WP695ou5yQeLPM2f56U8=
Received: by 10.86.65.11 with SMTP id n11mr10989368fga.1196713170282;
        Mon, 03 Dec 2007 12:19:30 -0800 (PST)
Received: from roke.D-201 ( [83.8.225.86])
        by mx.google.com with ESMTPS id l12sm6416188fgb.2007.12.03.12.19.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Dec 2007 12:19:29 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB3KJRFE009993;
	Mon, 3 Dec 2007 21:19:27 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB3KJQsY009990;
	Mon, 3 Dec 2007 21:19:26 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071203191143.GB17671@steel.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66952>

Perhaps simplier, but isn't it slower?

-- 
Jakub Narebski
