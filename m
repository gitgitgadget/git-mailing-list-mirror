From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to compare different files in different branches
Date: Fri, 06 Jun 2008 05:34:59 -0700 (PDT)
Message-ID: <m3skvqyc78.fsf@localhost.localdomain>
References: <20080606122421.GA1521@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bAk-0003ir-E3
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbYFFMfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbYFFMfE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:35:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:18199 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYFFMfC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:35:02 -0400
Received: by ug-out-1314.google.com with SMTP id h2so701857ugf.16
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ONbhUjMaOUEaPTWzPo2WpJQ8QUOMEdmFhg+O9oEAxwI=;
        b=urvUBCY+YtjZVeKC8itQWVepKZTWKQoQsoi3HegVxopD/mOajrxMyZRmHBao9kxGyp
         r4DaXvHyQIQoWPe+Gk+TvzfN8h6vdMy3XVRebiA+MN3KceQ1UelcIH1KlCqsjdK/gjKk
         W3m5ypTVCHLKlhyN/NA/QPcq5FLY9vyR3tPZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=uTeb2IpOum/RCyUhmxe6BnUAjPVuVWbt5E+c5thE4BnDP/xQuH13eW7iQvoQxq6vet
         1qsCxOSTifFGtrlrNMqB9WOUNRS7pOATmj6Q8TZj9Tz///rI0IXN6GX7SaVHYt27D62G
         Na4ySR/ZDqUN1oYku5E8sLGi5YdlPaE9aa30I=
Received: by 10.66.232.10 with SMTP id e10mr1125115ugh.24.1212755700302;
        Fri, 06 Jun 2008 05:35:00 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.141])
        by mx.google.com with ESMTPS id s8sm4416794uge.30.2008.06.06.05.34.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 05:34:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m56CYJqx026303;
	Fri, 6 Jun 2008 14:34:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m56CY30p026299;
	Fri, 6 Jun 2008 14:34:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080606122421.GA1521@denkbrett.schottelius.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84058>

Nico -telmich- Schottelius <nico-git-20080606@schottelius.org> writes:

> I want to compare 'configure.in' from the master branch with
> 'configure.ac' from the gpm-2-dev branch.
[...]
> I really think git can do that, but currently I do not see the right
> way. So any idea on how to do that?

 $ git diff master:configure.in gpm-2-dev:configure.ac

See "Specifying revisions" in git-rev-list(1); I think it can be also
found in other places, but I'm not sure.  git-show(1) refers to this
section when describing <object> option.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
