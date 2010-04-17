From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: Re: "Integrated Web Client for git" GSoC proposal
Date: Sat, 17 Apr 2010 05:53:09 -0700 (PDT)
Message-ID: <m3r5medyw9.fsf@localhost.localdomain>
References: <201004130403.42179.chriscool@tuxfamily.org>
	<201004150204.42813.jnareb@gmail.com>
	<1271293123.6248.147.camel@denix>
	<201004161118.32163.jnareb@gmail.com> <1271473792.3506.30.camel@denix>
	<loom.20100417T081957-371@post.gmane.org>
	<r2we72faaa81004170021z9920e6e9k4c3aa06fe46431b0@mail.gmail.com>
	<p2ue72faaa81004170022q2fc3a490u83ad6e325b91e139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 14:53:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O37WR-0001gL-FQ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 14:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab0DQMxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 08:53:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39890 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0DQMxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 08:53:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so883593fgg.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 05:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7hoJlwzqyaai5VvYGr+jdThHq9DDrJySOY5JNKJRL/s=;
        b=b0mIqLeGxSDB2nseKzZfmXfDrAVnpgQaW7GvKf7UddpbnHJq8YrQwv+Wh0/l9trpOZ
         lE1w3kdBPfaiEK2NwZXnj02AXq1Vq1kgUwsLiO1/cKgcCmp4LfKFr3ibiV5nQ3J9YP6M
         /Nj8CZYALTcZDsh46uW5/hILfZRm8GYk1/7Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ujc4REYMWBW8BzlntXQncPPNRrVq6lYUmNm6+SOOq1fwJRvLAKg5GJqhxylt5s117Q
         vTQtHD4/ndGFtqfkdRlRTqSYWXo99b2Q1zy6FuZgxthSQJQ89MsEOGOan9vWioba1p2P
         p3Wwj/O61hGdUXiSvOxMfzm1iynvXUyY8nS5g=
Received: by 10.87.61.22 with SMTP id o22mr2285545fgk.50.1271508790127;
        Sat, 17 Apr 2010 05:53:10 -0700 (PDT)
Received: from localhost.localdomain (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id e3sm5547778fga.9.2010.04.17.05.53.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 05:53:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3HCqmTZ030593;
	Sat, 17 Apr 2010 14:52:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3HCqc3a030588;
	Sat, 17 Apr 2010 14:52:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <p2ue72faaa81004170022q2fc3a490u83ad6e325b91e139@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145144>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:

> We need to keep gitweb dependancies as less as possible. So, using
> frameworks will be a bad idea, as everybody might don't want to use
> them.

Well, hopefully in the future PSGI / Plack would be as widely
available as CGI.pm is currently...

> 
> Coming to splitting of gitweb, as Jakub said installing a split web
> script would be a problem, but we can have a solution the problem by
> using proper algorithms. First, we parse the URL and get to know which
> function to be implemented and then we include the necessary file and
> call the function which will then execute and return the proper HTML
> output.
> 
> This way, we can no longer worry about installing the split webscript.
> All we need is to install the basic gitweb.pl file which does all this
> basic parsing and calling other perl files. The other files just
> needed to be in the path.

Not a solution, I think.  If you could munge PATH for web server
[user], you could munge PERL5LIB and use locally (local::lib)
installed packages.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
