From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: Confused about tracking git master
Date: Tue, 18 Apr 2006 20:59:37 +0200
Message-ID: <20060418185937.GD13672@vsectoor.geht-ab-wie-schnitzel.de>
References: <m2wtdmg3in.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 21:00:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVvQy-00010P-1u
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 21:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWDRTAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWDRTAM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 15:00:12 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:38154 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S932281AbWDRTAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 15:00:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 1158F411D;
	Tue, 18 Apr 2006 20:59:59 +0200 (CEST)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22302-04; Tue, 18 Apr 2006 20:59:40 +0200 (CEST)
Received: by vsectoor.geht-ab-wie-schnitzel.de (Postfix, from userid 1000)
	id D31D6411F; Tue, 18 Apr 2006 20:59:37 +0200 (CEST)
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m2wtdmg3in.fsf@ziti.fhcrc.org>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18873>

On Tue, Apr 18, 2006 at 11:08:48AM -0700, Seth Falcon wrote:
> To get updates, I _think_ all I have to do is 'git pull'.  Doing so I
> get:
> 
>     Unpacking 157 objects
>      100% (157/157) done
>     * refs/heads/todo: same as branch 'todo' of git://git.kernel.org/pub/scm/git/git
>     * refs/heads/maint: same as branch 'maint' of git://git.kernel.org/pub/scm/git/git
>     * refs/heads/origin: same as branch 'master' of git://git.kernel.org/pub/scm/git/git
>     * refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
>       not updating.       
> 
[..]
> 
> Is there a step I'm missing?  Or am I just misunderstanding what to
> expect?  Clarification on either of those would be appreciated.

You are trapped with the pu branch imho, like many others before *G* ... 
simply do a 

Pull: +refs/heads/pu:refs/heads/pu

in your .git/remotes/origin file or remove that pu line...

Greetings
Nicolas
