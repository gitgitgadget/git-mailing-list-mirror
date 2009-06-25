From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git in emacs
Date: Thu, 25 Jun 2009 05:59:18 -0700 (PDT)
Message-ID: <m3bpocxyf4.fsf@localhost.localdomain>
References: <f46c52560906250535k6a0eb0a5ne05dc327760d14bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 14:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJoY4-0002vP-NW
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 14:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbZFYM7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 08:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZFYM7S
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 08:59:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:61645 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbZFYM7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 08:59:17 -0400
Received: by fg-out-1718.google.com with SMTP id e12so552509fga.17
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GgYvGj7t11WUeG+QwAuKGGJlz1EEkhhYnAhiKu6OAik=;
        b=FC44H+DzUaTCgSpkLX8oreCEBiTmagWqtYUoUt+hZ4Tcn0CxNyI1m4AQKZVWtIS8xw
         /ZzkmePtlmj0bpJU9Ojob6vARfmC6RSwRslGLyzkIa7HHNO3NVG2z+f98rXSau+xHd6L
         nSLevas0F3J011LV+FRDBMRIRcZfDaLvPfV6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=uuMMsyDn4r0yYbarMwqV4KjTl11puRq70yHs20TQ/UyjfYI6cWXgj8GU0zJTpHKG7f
         T4kXcGEWu9g585tyklro9zCQU2SEbuOjExPh60VWBJxHliBOir/htN3y4anCLROJMuum
         w9wLjfc5qeQD9/nOoGXclAEtjyJIaIM60S7Ig=
Received: by 10.86.49.16 with SMTP id w16mr2525475fgw.67.1245934759385;
        Thu, 25 Jun 2009 05:59:19 -0700 (PDT)
Received: from localhost.localdomain (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id l19sm4286579fgb.21.2009.06.25.05.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 05:59:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5PCwpAp018537;
	Thu, 25 Jun 2009 14:59:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5PCweYn018533;
	Thu, 25 Jun 2009 14:58:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <f46c52560906250535k6a0eb0a5ne05dc327760d14bd@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122205>

Rustom Mody <rustompmody@gmail.com> writes:

> Ive been trying to use git.el in emacs
> 
> When I checked out an internal commit (I guess that's called a
> detached head?) then git-status (in emacs) starts giving me
> 
> Branch:     fatal: ref HEAD is not a symbolic ref
> 
> This goes away when I do
> git reset --hard <original-head-sha> --
> git checkout master
> 
> [I'm not sure this the best way of restoring the head]

This probably means that git.el (which version do you use) should 
be corrected.

> 
> But my question is more about git in emacs. I gather that there are 3 options:
> 1. git.el
> 2. vc with git backend
> 3. dvc with git backend
> 
> Which is best/preferable?
> Or is it best to stay with the command line?

See http://www.emacswiki.org/emacs-en/Git

-- 
Jakub Narebski
Poland
ShadeHawk on #git
