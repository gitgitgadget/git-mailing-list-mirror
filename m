From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 07/31] rebase: stricter check of standalone sub command
Date: Fri, 1 Jul 2011 17:29:19 -0500
Message-ID: <20110701222919.GA11258@elie>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-8-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110701035503.GA9818@elie>
 <alpine.DEB.2.00.1107010833310.580@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 00:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcmDX-0007Rk-5D
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 00:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676Ab1GAW3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 18:29:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55585 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745Ab1GAW33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 18:29:29 -0400
Received: by iwn6 with SMTP id 6so3145359iwn.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qizYdrsKrD+1rLAm/93jExce+inB8ikKC+8wGR8RGCo=;
        b=vkkGhl6LbSlEZUHhc8tSLERpFCPLVNlSkeVsOYEWSunLgfZ+Jg/dm/05uY4E8qBQhv
         kG/Gbj8osyV3iZUs0+mbj4N7ntx3hQZRj7j3WIZb4KPcq7vdtBmienAkygiFGtnxTHD8
         qUb1k6LnfIa6zhf+yhUojAjsUT9S3fNTmIdqs=
Received: by 10.43.61.196 with SMTP id wx4mr3304374icb.310.1309559368637;
        Fri, 01 Jul 2011 15:29:28 -0700 (PDT)
Received: from elie (adsl-68-255-110-41.dsl.chcgil.ameritech.net [68.255.110.41])
        by mx.google.com with ESMTPS id vn4sm3770558icb.7.2011.07.01.15.29.26
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 15:29:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107010833310.580@debian>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176538>

Martin von Zweigbergk wrote:

> Is the below patch what you had in mind?

No, but it looks good to me ("rebase usage: subcommands can not be
combined with -i").

>> Ah, it seems you already wrote a patch at [1].  The commit message
>> says it fails for "-i --continue" but I don't any code doing that;
>> what am I missing?
>
> That patch was never accepted, but 95135b0 (rebase: stricter check of
> standalone sub command, 2011-02-06) was.
>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/164241/focus=166684

I'll play around with [1] and try to revive it.  Thanks.
