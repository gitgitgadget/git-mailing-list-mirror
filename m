From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: [wish] Auto-generate gitk's pretty pictures
Date: Sat, 14 Jan 2006 01:14:19 +0300
Message-ID: <40b2b7d90601131414o20eae573r23256ff2dfbeffa5@mail.gmail.com>
References: <46a038f90601121302x3d06898dk3f9a0ab7114ef70a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 23:15:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExXC6-0001Tt-Sf
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 23:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423010AbWAMWOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 17:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423012AbWAMWOX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 17:14:23 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:26007 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423010AbWAMWOV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 17:14:21 -0500
Received: by uproxy.gmail.com with SMTP id s2so68047uge
        for <git@vger.kernel.org>; Fri, 13 Jan 2006 14:14:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nCj2YmB0Ax1cbLeDGL8PyYLeYaGKFsQrabm+xRjq5T6txy0OR7Zl24Z17+VUKSg/tikoppi1EaFd2NQkZBJ/m1/92r9M+Qtvng40k1+7ETM/AdKD77WtOnz7QifRDm8qVed/GtDY+uiHHxzSyVChOMcmgB8PgSTVQP4qk7dcLnw=
Received: by 10.48.202.9 with SMTP id z9mr107782nff;
        Fri, 13 Jan 2006 14:14:19 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Fri, 13 Jan 2006 14:14:19 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <46a038f90601121302x3d06898dk3f9a0ab7114ef70a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14651>

> I am working on the idea of running an hourly cron on the server that
> does
>
>  gitk -d --all --max-count=1000 --prettypic=foo.png
>
> and link to the png from gitweb.


I'm working on a web interface that will look similar to gitk.
It's far from being usable, the only thing it does now is to "draw"
gitk-like "picture". But if the picture is all you want, you may
find it useful. Please look at

http://straytree.com/git-browser/by-commit.html?r=git

hope this helps,
Artem.
