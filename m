From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about scm security holes
Date: Fri, 05 Mar 2010 02:49:46 -0800 (PST)
Message-ID: <m3lje7kpr9.fsf@localhost.localdomain>
References: <hmp427$d6h$1@dough.gmane.org>
	<32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
	<alpine.DEB.1.00.1003050953580.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, walt <w41ter@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 05 11:49:55 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnV6Q-0000yg-4N
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 11:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab0CEKtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 05:49:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:12073 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028Ab0CEKts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 05:49:48 -0500
Received: by fg-out-1718.google.com with SMTP id l26so187339fgb.1
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=rDxAHYhWsyD5DXiDPoYXwLe/ZZhiAsGq86D0l9qhKb8=;
        b=bZ2togRzPvPOc53rr0YxrDJTzXYnW0k4pci0vZQTZuXNPOJOU/wEWuLKsHGTUnD2fw
         FdxSwm8/xgVV4Cganx+/CnrX0CgdCDZqWGrETaqkLiNyYxMQx9mRyaG72imLQSySw8l1
         +P6biM+/b8BSs6CfEAqCH+llI4lCcs/cArYug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=lOBWllNhBWAv0Hu894sVGI0x/+9jmIPP1p30t74hzvZxz0ThnqiVgrxSiAvSRNEjjy
         nUD0dDs1LS9iqQaPAb3EhLYkuYa6gb0j8XtPAkYWF8V4yKnj4B6cGwfPENu5ATTnSBQh
         fAHzzvz0DQCNoWJ/aGLfxMx/pr3plH+7AuKZE=
Received: by 10.103.67.22 with SMTP id u22mr313768muk.12.1267786186797;
        Fri, 05 Mar 2010 02:49:46 -0800 (PST)
Received: from localhost.localdomain (abws10.neoplus.adsl.tpnet.pl [83.8.242.10])
        by mx.google.com with ESMTPS id 12sm7530291muq.1.2010.03.05.02.49.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 02:49:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o25AnEZP029940;
	Fri, 5 Mar 2010 11:49:19 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o25AmwNN029933;
	Fri, 5 Mar 2010 11:48:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.1003050953580.20986@pacific.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141574>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Thu, 4 Mar 2010, Avery Pennarun wrote:
> 
> > An attack in which someone untraceably modified the repo to contain 
> > modified code would be a little more interesting.

> > git makes this sort of thing pretty much impossible to do without it 
> > being *noticeable* at least.
> 
> That is not true in all cases.
> 
> If you're talking about a workflow as git.git has it, you're right, there 
> is a maintainer, and a refused push would ring all kinds of alarm bells 
> there.

[...]
> It gets even much, much worse in the common setup of companies: a central 
> repository. (The two main reasons why a central repository is used are: 
> tradition (we did it with Subversion, too), and bottleneck problems: a 
> single maintainer reviewing all changes is often deemed too expensive 
> and slow.)

About "bottleneck problem".  Frederick Brooks wrote in his seminal
book "The Mythical Man-Month" that recommended way of organizing teams
is *with a maintainer*.  But this is less known that his most famous
statement: "Adding manpower to a late software project makes it
later." (The Brooks's Law)... and I guess companies do not know about
this one either :-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
