From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Wed, 11 Jun 2008 01:25:57 -0700 (PDT)
Message-ID: <m3hcc0s7f5.fsf@localhost.localdomain>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
	<cover.1213084587.git.marius@trolltech.com>
	<alpine.DEB.1.00.0806101632570.1783@racer>
	<7vk5gxc4gz.fsf@gitster.siamese.dyndns.org>
	<484F6A27.1040602@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 10:27:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6LfW-0005FF-DQ
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 10:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYFKI0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 04:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbYFKI0D
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 04:26:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:47521 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbYFKI0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 04:26:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2049616fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=C0ROoS3Tl+yXKv/pMb0QdJ+K0qazGvOpmmg5QdngHj8=;
        b=H498Yz/8ehrEHNt5j0MPq9Qb8c7C3Cbgr1Mr4tEk2jly5FGzcksWAQHwJ5yecQji2b
         R3aW3APnC1a6ljbC0FuUe0nY/qe98HlcOaToFspHVhyBMBO4oIhxhG08FlUsSoXn6vNG
         pQMn/KLYNtB7+r3uIoA4zofdSYY0bdeJP3TKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=XbjwmStTdFboFd2QSi4tRfctGiYw/ZiWjbwhl6W2byslOyrAhMRz/2Lb14mxOuGqOc
         t5GVtI1NEP8s9z+851mw/u5XxTNAP3BfMm1xXbXTr5eP5dU8J4W9vbyNjP03sfmQ9Vb6
         fUq3ShamO+6XXX1yX5n6cQdDJNYcvhclOI3lY=
Received: by 10.86.27.9 with SMTP id a9mr6787968fga.57.1213172758839;
        Wed, 11 Jun 2008 01:25:58 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.81])
        by mx.google.com with ESMTPS id l12sm14720749fgb.6.2008.06.11.01.25.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Jun 2008 01:25:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5B8S1Zg006016;
	Wed, 11 Jun 2008 10:28:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5B8RQcR006006;
	Wed, 11 Jun 2008 10:27:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <484F6A27.1040602@trolltech.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84600>

Marius Storm-Olsen <marius@trolltech.com> writes:

> However, I also see that it can be useful at times. Almost makes me
> consider a --raw option to 'git show' for those seldom cases. IMO,
> 'git show' *should* care about autocrlf. Not doing so is just
> confusing to the end-user.

There is always "git cat-file -p" which is porcelain, and should not
care about attributes (perhaps with the exception of explicitely told
so with some command option).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
