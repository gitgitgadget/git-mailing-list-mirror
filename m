From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Makefile: add clean-obsolete-scripts target
Date: Wed, 10 Jan 2007 14:52:27 +0100
Message-ID: <81b0412b0701100552w5efc29d7uc3a0af1d33fe3ce1@mail.gmail.com>
References: <Pine.LNX.4.63.0701101319480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701100453t63b62867ne67819e91f1319b9@mail.gmail.com>
	 <Pine.LNX.4.63.0701101441360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 10 14:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4dsa-0001QE-Q4
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 14:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbXAJNw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 08:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbXAJNw3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 08:52:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:58889 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964857AbXAJNw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 08:52:28 -0500
Received: by wr-out-0506.google.com with SMTP id i30so46158wra
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 05:52:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4yYu6G4smbuChjz4WKO6+OBFxRInfod0bHdINjcmLPRWUvOq1MJSPtfNuwHPjbnHvRa67SGoVGzhSBvB1FkIwoE9NQSRnqyJthgnOdIbR/w7F2D6+583JHHQvmvblkzjwP6aHauwbiWZbtYqGXaPxG3Xx2Wt5PoEMN7DL+yokA=
Received: by 10.78.193.19 with SMTP id q19mr91312huf.1168437147196;
        Wed, 10 Jan 2007 05:52:27 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 10 Jan 2007 05:52:27 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701101441360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36510>

On 1/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Not enough. You have to cleanup the build directory too,
> > otherwise tests fail, and git-hacking on git itself is ... complicated.
>
> Doesn't it handle that?
>
>         ls *$X '$(DESTDIR_SQ)$(gitexecdir_SQ)'/*$X
>
> Note the first "*$X". It really should pick up on all executables in the
> build directory. Or do I miss something?

No-no, sorry. I didn't noticed the first *$X, which will of course catch the
execs in the current directory.
