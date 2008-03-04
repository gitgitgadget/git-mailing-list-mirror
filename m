From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bug-tracking tools that handle branch/merge/etc
Date: Tue, 04 Mar 2008 14:24:21 -0800 (PST)
Message-ID: <m3ve42gmae.fsf@localhost.localdomain>
References: <20080304170903.7b029fc3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWfZJ-0007Cf-RJ
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 23:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbYCDWY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 17:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756860AbYCDWY0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 17:24:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:57082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbYCDWYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 17:24:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1231990fga.17
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 14:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=UYbSZINuh27nNq27aKGGaSReIXb+wWsLs9qj6Z7Pd+g=;
        b=UqIj7xUu1xzq84K1c3bYEYF4ahsMe6FeAHZzlx0gKCnQZh1arK61v5F8g/sV8HwA9w7lQjSvFs0Qb6WwHqXSNt6tOJkXpJCkBabn04FyvXO1VpMSd/hz42SCKRF9nhu/EVD+mjkngpS8JHI5hM9y+VUf0JJOboX/olhmJ64OBjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ZVNx9zZEl32qe2xxJ1yOf3mMKGU0qfu6RGG45Ue1kRagS04K9qRAOuJBadm9kyncWfgCzG/vS//RFMSChte8h+mrMjYLNjmKPm1ABQieMtktqm1caeF1JVHFLjC9V/wHoan12cZfOHIFuW8cZWqlqpPjHPXKX3C5Oy75MQsJ8q4=
Received: by 10.82.155.10 with SMTP id c10mr6069421bue.7.1204669463297;
        Tue, 04 Mar 2008 14:24:23 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.156])
        by mx.google.com with ESMTPS id y37sm271643iky.7.2008.03.04.14.24.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 14:24:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m24MOgkX016744;
	Tue, 4 Mar 2008 23:24:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m24MOf4L016741;
	Tue, 4 Mar 2008 23:24:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080304170903.7b029fc3@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76150>

Thomas Harning <harningt@gmail.com> writes:

> Partly referring back to the discussion last June
> (http://article.gmane.org/gmane.comp.version-control.git/49734)...  has
> there been any developments in the area of a BTS that can grok GIT in a
> sane way?

Unless you count work-in-progress Grit (http://git.madism.org/?p=grit.git)
I think the answer is no. The 'after the fact commit annotation' aka
git-notes are also as far as I can see abandoned.

http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-3a410db622d55b4dd88d91437d2c953f6b730542

> Main concept I see as important for a BTS grokking git:
>  * Capability of following branches/merges in a way that
>    you can see a list of bugs that affect a branch at any point
>    in time.
> 
> Niceties include:
>  * The ability to 'distribute' this so bug tracking is as disconnected
>    as coding itself (great for airplane-trip coding sessions)
>  * Ability to watch incoming commits (suppose the BTS can 'pull' from
>    various sources on occasion) for messages marking a bug as
>    in-progress/fixed/re-opened/etc.
>  * Local-application GUI integration... ex: gitk/git-gui + BT

BTW. you can put it in SoC2008Ideas as a project for Google Summer of
Code 2008... then try to find a mentor for this project ;-)

http://git.or.cz/gitwiki/SoC2008Ideas

-- 
Jakub Narebski
Poland
ShadeHawk on #git
