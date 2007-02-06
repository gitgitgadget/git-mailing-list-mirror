From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH] enable rerere by default
Date: Tue, 6 Feb 2007 16:39:52 +0100
Message-ID: <81b0412b0702060739y35c00332q8945a33743084219@mail.gmail.com>
References: <Pine.LNX.4.63.0702061103070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702060556r3e366defwe4b7afabdf5ffb7c@mail.gmail.com>
	 <Pine.LNX.4.63.0702061602360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 16:40:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HESQI-0001uD-OK
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 16:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbXBFPjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 10:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXBFPjz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 10:39:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:63997 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588AbXBFPjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 10:39:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1638687uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 07:39:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JJCbLrsX7UG5GdfOiLGes2oXjzplsMigwRpXUlJ+TvjsGr0KCw6FR5N01wcLNClTqQMzBWM35BGK2hrIx7f1H5PccarLWN3N1lZQ3PKRi/f1QWyPOYYWMMlss9whSgxNPU+vkfQ554DayUlzdu7rquQSMb6quWgJvXRiRvwqH8E=
Received: by 10.78.160.2 with SMTP id i2mr1733117hue.1170776393278;
        Tue, 06 Feb 2007 07:39:53 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 07:39:52 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702061602360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38852>

On 2/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >         I know it is quite late in the game for 1.5.0, but since the theme
> > >         is usability and user-friendliness, I cannot think of a better
> > >         release to enable rerere by default, if that should ever happen.
> > >
> > >         Comments?
> >
> > How do I disable rerere by default?
>
> How'd you like it? Should this rather become a config variable, or do you
> want to make a file called "rr-cache" in the templates, which just
> contains a word "disabled"? (git-rerere checks if a _directory_
> $GIT_DIR/rr-cache exists.)

I suggest a config variable defaulting to "on", able to disable rerere even if
rr-cache exists. So the var has at least theoretical use also after a
repo is created.
I'll put it in templates config then, and modify existing repos to
switch it "off"
(so I always have it mentioned in the configs).
Newbies, who don't have it own templates, wont even notice it.
Unless it is put into the generated config, that is: like
core.logallrefupdates -
it can be in templates config, or git-init writes it.
