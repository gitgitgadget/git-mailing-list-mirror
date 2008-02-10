From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fetching a single commit from remote repo
Date: Sun, 10 Feb 2008 08:48:26 -0800 (PST)
Message-ID: <m3sl00g3lc.fsf@localhost.localdomain>
References: <1530970.y9vPlhFxz8@yoush.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nikita V. Youshchenko" <yoush@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFMX-000388-OF
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYBJQsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYBJQs3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:48:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27605 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbYBJQs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:48:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so166241ugc.16
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 08:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=tUvsxNcUn9k6BNhIhtYdc2BgrOXi4zktOknh36o205A=;
        b=jn4rfjlssgwz3Am5Yfu76876M1rYQQuf3qdIGdPk1Y+GXmv2SUAxNXSWt6hGvbnMv9WKpLfSKzVMcW5y9SX4xFplqpg9txqk0/afNAUd9T1+BUPy6h0lJ+NjNSCukjPf6suPUA5k4y/Q9zEbEVLh5nXrWcuM6PbmV8vbhRQ2454=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=AILqmURjKndm3oZLsyk5ptOpS+OVBncWeI2hL5TWIghf5qixATJJ23BPKCPmNvzYyklyxECVFjclDjwFOOqIp/RPbBek+8V9K/V4tvaQITKabBd2Teyo7hdo+E249DxxL7fpc2sRxciMJaBQDiIMsEI+oNJC0Rx8JaVH6voiNYg=
Received: by 10.66.236.13 with SMTP id j13mr8029993ugh.30.1202662107328;
        Sun, 10 Feb 2008 08:48:27 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.105])
        by mx.google.com with ESMTPS id 18sm4862435ugk.18.2008.02.10.08.48.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 08:48:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1AGmLoX030900;
	Sun, 10 Feb 2008 17:48:22 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1AGmFOq030896;
	Sun, 10 Feb 2008 17:48:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1530970.y9vPlhFxz8@yoush.homelinux.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73374>

"Nikita V. Youshchenko" <yoush@debian.org> writes:

> I'm looking for a way to fetch a single snapshot, without history, from
> remote git repository.
> 
> I've found how to do it with a head (clone --depth 1, or fetch --depth 1).

You can also try "git archive --remote=<repo>" if it is enabled,
or if project has gitweb, then use 'snapshot' feature (if enabled).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
