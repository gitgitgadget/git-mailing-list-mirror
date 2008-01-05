From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple shared repositories (including svn) workflow
Date: Sat, 05 Jan 2008 07:07:28 -0800 (PST)
Message-ID: <m363y8nwf9.fsf@roke.D-201>
References: <DA45FDDC-BEEB-47F6-A2B6-4FE4FFEF8B0D@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 16:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBAd2-0004W0-KH
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 16:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYAEPHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 10:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbYAEPHb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 10:07:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16253 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbYAEPHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 10:07:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2916374ugc.16
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 07:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=D2fgmjDfqOg1cUJmCR+WS6RTiUtb6kGbQHsfMsl4oJc=;
        b=WDUw0NZehJK4TpEzeNwLkZItxnUArdLkzhdDcr7CruZGOIdekJ4QFqHU5XjFOXVRtNGFBMIXddUKl7ZDlUdAGR0EgUTs0d06+ZiLOeQzcxMzPzEjpV09OlR3vBwtrbVCB3flcYTDLcVaWGfSkiyIDlUuzuoKkUNNxAN7EJqbfCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=LbMDUtnYS1P/rQNDixQCJ+Mhk8/i1u7mNNMgLfSAskBm0CI+RN424n+tJbnYByz1YpvrxnrUsPU+xwq5cSPfuGx2Sx22eiGN3a7bszXwqmmQPXT/sOwDmdhwKCKmngPwNNKxKwG0/JWkNhfMtuAOXq6nWSnJMH9r8EjD1pcJMqc=
Received: by 10.66.221.17 with SMTP id t17mr13259939ugg.66.1199545649057;
        Sat, 05 Jan 2008 07:07:29 -0800 (PST)
Received: from roke.D-201 ( [83.8.240.50])
        by mx.google.com with ESMTPS id l22sm18479860uga.30.2008.01.05.07.07.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 07:07:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m05F7N4O006668;
	Sat, 5 Jan 2008 16:07:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m05F77Cb006664;
	Sat, 5 Jan 2008 16:07:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <DA45FDDC-BEEB-47F6-A2B6-4FE4FFEF8B0D@vicaya.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69674>

Luke Lu <git@vicaya.com> writes:

> Anyway, I've been using git for only a few months. There might/must
> be better ways to do it. As a user coming from cvs and svn, it seems
> to me that the most confusing command is actually "git pull" as it
> doesn't work with such workflow at all (conflicts with confusing
> messages, until you really understand the implications of rebase). It
> seems to me that if we create a new "git update" command which is
> essentially "git fetch && git rebase <remotebranch>", it would
> greatly alleviate such confusions. Some lessons learned from the
> short experience:
> 
> 1. commit first, ask question later.
> 2. rebase is the new update
> 3. reset --hard and reflog are your friends.

I don't remember if it would be in coming 1.5.4 release, but there
is "git pull --rebase", which means fetch + rebase instead of default
fetch + merge.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
