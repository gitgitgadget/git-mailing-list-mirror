From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Q] Tell Git to follow symlinks?
Date: Mon, 25 Feb 2008 00:52:48 -0800 (PST)
Message-ID: <m3k5ktbep1.fsf@localhost.localdomain>
References: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:53:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTZ5X-0004z7-FP
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYBYIwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbYBYIwz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:52:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:23717 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYBYIwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:52:54 -0500
Received: by nf-out-0910.google.com with SMTP id g13so711206nfb.21
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 00:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=P6/I+gCI1PoCPOZahz6Y4/ezunYT78sxQGhMe8FWjQM=;
        b=Ig758EvhmPf4jiN4NC0GaY+NoPKfKijvV+mKwLUBrUSbD21T53cx5xDKdNe+yoc3CmodymcyRf12/IZrvgyeC+gzFd6OsdlJR19LMwYalW6FlvRiLCX2UAbnIQEAxfIBRbV/rJgkSmwmGUwcMnMPzBuR3E/PkRyEzoDR/Vuo0os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=wqcjbSPL+xdyv1wsWY2fWza9LI0ZP2xwqet1GxncIbJYcObVlEW8YahFLUQrHHcJFTF2RP+cc+1UwYc7j0hAbkuGE7/V9Cb5lJUr7ZYWPa5p3W0ktS7rtgaH474fAOEKWCtfw4wlJa3N9GA2/DS0S2zibf4x1r1XuFARsGnUwVU=
Received: by 10.151.43.19 with SMTP id v19mr972046ybj.195.1203929569472;
        Mon, 25 Feb 2008 00:52:49 -0800 (PST)
Received: from localhost.localdomain ( [83.8.199.10])
        by mx.google.com with ESMTPS id d26sm4153727nfh.25.2008.02.25.00.52.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 00:52:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1P8qhsZ032316;
	Mon, 25 Feb 2008 09:52:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1P8qgXC032313;
	Mon, 25 Feb 2008 09:52:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75017>

"Alexander Gladysh" <agladysh@gmail.com> writes:

> I thought to construct my repo of the number of symlinks to other
> places, but apparently Git does not follow any symlinks.

Git stores symlinks as symlinks. Changing that (adding for example
core.followSymlinks) would require quite a bit of surgery.

You can alternatively try to work with GIT_DIR, or/and with
explicitely specifying worktree (and working from within repo), and/or
symlinking .git.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
