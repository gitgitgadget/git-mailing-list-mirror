From: Sam Vilain <sam@vilain.net>
Subject: Re: Cloning of git-svn repos?
Date: Fri, 20 Apr 2007 01:03:53 +1200
Message-ID: <462768B9.5030102@vilain.net>
References: <20070418092916.GI31488@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 15:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeWIy-0003hS-DB
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 15:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S637759AbXDSNEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S637762AbXDSNEF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 09:04:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:56318 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S637759AbXDSNED (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 09:04:03 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id AF99013A400; Fri, 20 Apr 2007 01:04:00 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id F127213A303;
	Fri, 20 Apr 2007 01:03:56 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20070418092916.GI31488@curie-int.orbis-terrarum.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45018>

Robin H. Johnson wrote:
> (This is completely unrelated to my previous posts about using git for
> Gentoo, it's not the only placing I'm looking at implementing Git).
>
> Is there a sane and git-recommended way to clone repos created with
> git-svn?
>
> If I do: 'git-svn clone ....', and then git-clone of that directory, the
> second clone cannot use git-svn to follow the original SVN or feed stuff
> back to the original SVN.
>   

You need to make sure to clone the remotes/ refs as well.  See
http://utsl.gen.nz/talks/git-svn/intro.html#howto-track-svn

Sam.

> If I create them separately (or by plain copying the first one to create
> the second), then pulling between them works fine.
>
> The copying just feels messy compared to the initial git-clone
> functionality.
>
>   
