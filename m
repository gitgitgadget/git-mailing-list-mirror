From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: git pull fails
Date: Wed, 29 Mar 2006 03:11:36 +0300
Message-ID: <20060329031136.e0389c00.tihirvon@gmail.com>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com>
	<20060328141140.GC3113@linux-mips.org>
	<20060328173827.3d64d91e.tihirvon@gmail.com>
	<200603281700.17233.astralstorm@o2.pl>
	<20060328224807.GC27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: astralstorm@o2.pl, git@vger.kernel.org, ralf@linux-mips.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOHZ-000382-8U
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWC2AL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWC2AL0
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:11:26 -0500
Received: from nproxy.gmail.com ([64.233.182.191]:7253 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964850AbWC2ALZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 19:11:25 -0500
Received: by nproxy.gmail.com with SMTP id n29so45888nfc
        for <git@vger.kernel.org>; Tue, 28 Mar 2006 16:11:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qGax4GTnbirQf+7D7plAZy7sclgeFBAxv6t/r2uzxJ4sheWUkgyySgshYm31Y9S9IX+PMWJZNTf36vhpm6NIfW6CBBeQWI0AdwOWD2ShaWPin5450yq+6D7PJUOXKgwd2CvwCTY0lU3gB5uqrj+6YgYWHD3KqQ+tCvEQJX7SiZU=
Received: by 10.48.237.10 with SMTP id k10mr74357nfh;
        Tue, 28 Mar 2006 16:11:24 -0800 (PST)
Received: from garlic.home.net ( [82.128.200.56])
        by mx.gmail.com with ESMTP id z73sm117601nfb.2006.03.28.16.11.23;
        Tue, 28 Mar 2006 16:11:23 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060328224807.GC27689@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18145>

Petr Baudis <pasky@suse.cz> wrote:

> If I understand it right, Timo complains that git-fetch got
> non-fastforward commits for "pu" and "next" and a good fastforward
> commit for "master", but it didn't update the ref for ANY head, not even
> the "master".

Exactly.  Maybe git-fetch should abort only if it could not update the
currently checked out branch?

-- 
http://onion.dynserv.net/~timo/
