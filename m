From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [MonoDevelop] git integration with monodevelop
Date: Wed, 12 Nov 2008 14:19:38 -0800 (PST)
Message-ID: <m33ahwio3v.fsf@localhost.localdomain>
References: <491AAE6D.8030304@op5.se> <1226519288.4483.176.camel@erandi.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	monodevelop-list@lists.ximian.com,
	Michael Hutchinson <m.j.hutchinson@gmail.com>
To: Miguel de Icaza <miguel@ximian.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0O56-0000Oj-L7
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYKLWTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbYKLWTp
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:19:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:59937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbYKLWTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:19:44 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1184234ugf.37
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=R/ShA4xgSPtjtKjEpK8WWkXZb9U4KpOOcfHvpDKUoxE=;
        b=b3BSUTeU9b0Wq1ySqQLfXzypPOmp2sfqUFqoU0EVZJKf+YXlD5z6U9LQr+xIzq1K8I
         mclu/+9h8tLJJ9TvtZSgDDYIz6km7W+4HBCxrwtBhGWABfdxb1Umgn0ZcqdRo43j8IkN
         pXZdyTvQu1RkRgC327vhCNuTvF16yIOVc7/8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=uJwM7pOHNyiJByG6c6noSKYY809juSrt4oO1Hc6qpzi41mYqGgxzqvGpgcgU6P+hJe
         m8xVHVked/v0FkvG1SVIQDWUIz8we94ZiTdGk5JKP09MZ/aqBVard0ygA0klhz+CXywY
         kbLz90z8mX469cz7QDRjCm9ti1dE9593rA5Vg=
Received: by 10.210.92.8 with SMTP id p8mr10846479ebb.12.1226528379862;
        Wed, 12 Nov 2008 14:19:39 -0800 (PST)
Received: from localhost.localdomain (abwt78.neoplus.adsl.tpnet.pl [83.8.243.78])
        by mx.google.com with ESMTPS id 10sm3540788eyd.6.2008.11.12.14.19.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Nov 2008 14:19:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mACMJa1l003842;
	Wed, 12 Nov 2008 23:19:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mACMJWNb003839;
	Wed, 12 Nov 2008 23:19:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1226519288.4483.176.camel@erandi.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100820>

Miguel de Icaza <miguel@ximian.com> writes:
> Andreas Ericsson <ae@op5.se> writes
> 
> > So in an effort to learn C#, I've decided to play along with this
> > (hopefully with some help from the MonoDevelop team), but it seems
> > to me that the best place to start is the fledgling libgit2 and link
> > that with git-sharp. The primary reason for this is ofcourse that I
> > think it'd be a terrible waste to have yet another from-scratch
> > implementation of git in a new language (ruby, java, C#, C...). The
> > secondary reason is that it would be neat to have more OSS projects
> > use my favourite scm.
> > 
> > Besides, getting something to rely on libgit2 early on is probably
> > the best way to get more people interested in making development of
> > it proceed rapidly.
> > 
> > Thoughts anyone?
> 
> We would still like to see a port of jgit to C# as a fully managed
> implementation, one that does not make P/Invoke calls into C code can
> run on the sandboxed versions of .NET (Like the one available in
> SecondLife, Unity3D, Silverlight and Mesh).

I assume that results of Mono's Google Summer of Code 2008 projects
to create managed git implementation in C# (git#)[1][2] were not
very successfull?  Taking into account that JGit isn't yet full git
implementation, after much longer development...

[1] http://code.google.com/soc/2008/mono/appinfo.html?csaid=E6D8A717A88A7632
[2] http://code.google.com/soc/2008/mono/appinfo.html?csaid=F2E71A4D93E7EF37

-- 
Jakub Narebski
Poland
ShadeHawk on #git
