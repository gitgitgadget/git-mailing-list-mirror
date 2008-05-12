From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 21:49:02 +0200
Message-ID: <bd6139dc0805121249q76282be1mfc888e3707598a29@mail.gmail.com>
References: <alpine.DEB.1.00.0805121428310.30431@racer>
	 <alpine.DEB.1.00.0805121606010.30431@racer>
	 <20080512152731.GM31039@zakalwe.fi>
	 <alpine.DEB.1.00.0805121804500.30431@racer>
	 <20080512180720.GN31039@zakalwe.fi>
	 <alpine.DEB.1.00.0805121920120.30431@racer>
	 <20080512183615.GO31039@zakalwe.fi>
	 <20080512183803.GP31039@zakalwe.fi>
	 <73584838-DF17-4CDB-92CA-363ED9DA9582@gmail.com>
	 <20080512191002.GQ31039@zakalwe.fi>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim Harper" <timcharper@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"bill lam" <cbill.lam@gmail.com>, git@vger.kernel.org
To: "Heikki Orsila" <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Mon May 12 21:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jve22-0004l9-Pd
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 21:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYELTtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 15:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYELTtH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 15:49:07 -0400
Received: from el-out-1112.google.com ([209.85.162.179]:16882 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYELTtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 15:49:04 -0400
Received: by el-out-1112.google.com with SMTP id s27so534772ele.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6arXJWeKUQZ+q1LBZq3la71GIqDoj8OgKki/+V7Tg7k=;
        b=E6SYZu7boixSqcoczL7QyDuwskAjwFmhUehi+ub8dvLwY7jFjEpppuND4ufAAOXELHf3hHHUJjcYFRZ31mhphtdBMy9LLvBp92jfpRQAyzGkHsMGsZvqwk8WDzIN89pctzAlo+pBWTq6mszNhgLtmbpLiWgt1tjnzFS1EV66toQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCla/O6otgpKBoLDlSgb+LYuGpGJWTGXCDGaJJcgX8eXyyaMF73AQuEp51NVJ+Y0xPQHSMj8KbKX7BqiRaUguQrcEQ/OAmfQPHYDB20wHeCcJXE+ERmOAS6qgL5MRh6HiLXuaXAU/Tc7cMts3M0Z0EjtAN+Yo8B4H4JHB7XpCi8=
Received: by 10.143.2.19 with SMTP id e19mr3430061wfi.90.1210621742886;
        Mon, 12 May 2008 12:49:02 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 12:49:02 -0700 (PDT)
In-Reply-To: <20080512191002.GQ31039@zakalwe.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81915>

On Mon, May 12, 2008 at 9:10 PM, Heikki Orsila <shdl@zakalwe.fi> wrote:
>  So you assume everyone syncs everyone else often enough. I don't think
>  many organizations want to rely on that assumption. The point is to
>  have a simple, efficient and manageable backup system that
>  does _not_ require knowledge of Git internals.

Isn't that what Dscho and others have mentioned a few times now?
Initially you git clone the repo, every few hours you have cron do a
git pull and daily you do 'rm yesterday.tar.gz && mv today.tar.gz
yesterday.tar.gz && tar czvf today.tar.gz .git '. Why would git need a
'backup script' for something so trivial? I reckon everybody wants a
different type of backup too, so creating a 'git backup' would
probably not be very usefull to most.

-- 
Cheers,

Sverre Rabbelier
