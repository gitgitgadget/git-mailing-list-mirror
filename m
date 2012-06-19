From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 11:28:46 +0200
Message-ID: <CAGK7Mr5byhUOZ1vZTOMWWBVs4rXdE8RH+SS2ppz2QP1e-MiG0w@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
 <CAGK7Mr62y4-fTFzuLGmuOd+zLkk+h1Q-rCb30TW3dWd8VLhhAw@mail.gmail.com> <CAH3AnrppdYOC_Z4PWnzNLWXPSSQMBvHd9KPnQyAt40=FTn2dFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:29:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgukj-0005rS-Le
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 11:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab2FSJ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 05:29:29 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58744 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab2FSJ3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 05:29:17 -0400
Received: by ghrr11 with SMTP id r11so4421446ghr.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qYw4og5RlSWV+YGUzuwE3Ym773sAg7GIt0eWwnbCqyA=;
        b=Vdmk5IKOpI/L6WxvG/vBKrjuXZnft+1+fZdK20a/gEeLaDqF5+Q01jpGuh7RTpGdp2
         nn6MO55P1RYEr69MHCrgCakA+0nXriymr5ibU2cMwW5hP/AZ04S9EE+yEQgN8UiWCMeG
         lJJ9WWt9wZvGj4Yc5jbBHb/mK5fOOSpvbt05rzHiVJAKRghKSvu4kUOj+XS8vk78tN36
         z+e6FxXz+IUd+Znt5Dh4hnFcoZGtnLJBcGjP4vi4TZsz5o1XiqfeFgRinhQD7Zd9Cm0W
         c49ifpX0wHQSKD2YrZTyDCCEP4bxDZJFEVRpFL0Sjm/zjSe3al4HyG07ibTxPhdUoLq/
         jHbw==
Received: by 10.42.76.65 with SMTP id d1mr7114688ick.42.1340098156355; Tue, 19
 Jun 2012 02:29:16 -0700 (PDT)
Received: by 10.50.99.10 with HTTP; Tue, 19 Jun 2012 02:28:46 -0700 (PDT)
In-Reply-To: <CAH3AnrppdYOC_Z4PWnzNLWXPSSQMBvHd9KPnQyAt40=FTn2dFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200188>

> I was hoping to use cygwin because I don't like the (understandable)
> limitations of the msysgit toolset (restricted set of available tools,
> invoking bat files is painful, symbolic links don't work the same way,
> etc)

There's a git bash with msysgit which is probably more limited than
cygwin's one but decent enough. About the tools you can install
something like https://github.com/bmatzelle/gow/wiki or
http://gnuwin32.sourceforge.net.

To be honest most of the time I just use the *nix tools from the
windows command line, and jump into git bash for more advanced stuffs
when necessary.

Philippe
