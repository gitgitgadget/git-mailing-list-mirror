From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git show <tag>: show the tagger
Date: Tue, 18 Dec 2007 13:33:59 -0800 (PST)
Message-ID: <m38x3rpu0t.fsf@roke.D-201>
References: <Pine.LNX.4.64.0712181800250.23902@racer.site>
	<7vfxxzzrv8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4k55-00087b-4t
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbXLRVeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbXLRVeE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:34:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:2155 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbXLRVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:34:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so417387fga.17
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 13:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=cOcsf6MSNlUci4Ac9htudTfQ05wCsN15vp1W6jfdTMw=;
        b=MA6/BchlagXWqJh2WWliYmJD2LuaXG27Er+eZLFM0V6nN0jkiyKNpBhcbLejHZTAASJE82Fo79RQgZxct/j4yryW9YUDZtlqcJW1RF/iwh390Tey6qCTFM4SDRMrV9ZmVXBiPBKxOxDThFvRJIxpXBpp0JnkRWg6yKJixRCMmvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=iojnefuHoquVj+PB9UseoJVrx9hFPpXE9qnyYj0TZND8MoMwsFkdTlkx4Xa8xaZ8s1uJcUUAOGgzjcKZFvGLu1/LXY/bf3g96C9clddjsjByDvapTSua9fB+8rtrY+qPSrGHjgPEoDN7qBuL3MZMHjFuRRuQtBf33u1mpWFhr9E=
Received: by 10.86.26.11 with SMTP id 11mr8121302fgz.72.1198013640255;
        Tue, 18 Dec 2007 13:34:00 -0800 (PST)
Received: from roke.D-201 ( [83.8.255.201])
        by mx.google.com with ESMTPS id 4sm4497090fgg.2007.12.18.13.33.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 13:33:59 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBILXvTr020123;
	Tue, 18 Dec 2007 22:33:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBILXtsH020119;
	Tue, 18 Dec 2007 22:33:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vfxxzzrv8.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68820>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > For commit objects, the Author is shown, so do the equivalent for
> > tag objects, too.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	I know, it's feature freeze period.  But this is arguably a 
> > 	usability bug.
> 
> I'll wait for people to argue this fixes a usability bug, then.

IMHO the fact that currently "git show <tag>" _doesn't_ show
author and date of tag is a (usability) bug.

Fortunately "git cat-file -p <tag>" (or "git cat <tag>" with my
current alias) works, and dos show date in human-readable form.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
