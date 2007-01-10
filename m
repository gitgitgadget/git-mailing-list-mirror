From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: a few remaining issues...
Date: Wed, 10 Jan 2007 14:56:10 +0100
Message-ID: <81b0412b0701100556h1a1338d1q7c6ee99eaad60ab5@mail.gmail.com>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050327u6bf2a716s1fb38fb62e2ebb9d@mail.gmail.com>
	 <Pine.LNX.4.63.0701101320300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701100440n6fe9e406yfe712cf236a784e2@mail.gmail.com>
	 <Pine.LNX.4.63.0701101442520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 14:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4dwJ-0002Uc-OV
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 14:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbXAJN4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 08:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbXAJN4N
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 08:56:13 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:22463 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964862AbXAJN4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 08:56:12 -0500
Received: by an-out-0708.google.com with SMTP id b33so40013ana
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 05:56:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6I4lP+uvfRty9PmBrw4IjMQfyH7OJJEVPilut1gaCF4e1N26ykyP4L3Y9KgOf7FtqHeFoC/5iTZEO0co4a8ZzAwXcICp1qlsMZY+m/uWWBUlU9CEz3f+SDMAxijsNffGplz3PXrqqSQysaYUT2LHhiWt8aTsw86KtYcqa2C2Nw=
Received: by 10.78.200.3 with SMTP id x3mr82851huf.1168437370844;
        Wed, 10 Jan 2007 05:56:10 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 10 Jan 2007 05:56:10 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701101442520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36511>

On 1/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > I just sent out a patch in my mail "[PATCH] Makefile: add
> > > clean-obsolete-scripts target" which should help.
> >
> > Well, you also have to give people at least notice _when_ the
> > target should be called.
>
> Okay. Fair enough. So maybe this is the wrong approach: maybe the "all"
> target should look for _all_ executables if there is a script of the same
> name, and in that case remove it; and the "install" target should do the
> same in the gitexecdir?

...but unless they're in the index and the build directory is a git repo.
It's going to far. I suggest just giving a word of warning on cygwin at
at the end of build. It is the only platform broken in such a stupid way.
