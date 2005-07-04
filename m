From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Mon, 4 Jul 2005 18:27:40 +1200
Message-ID: <46a038f9050703232719a05c9e@mail.gmail.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
	 <m3ekagp9mk.fsf@telia.com>
	 <1120385280.6845.12.camel@localhost.localdomain>
	 <m3oe9k6p40.fsf@telia.com>
	 <1120425269.6845.28.camel@localhost.localdomain>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Jul 04 08:28:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpKRm-00078Q-3G
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 08:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVGDG1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 02:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVGDG1t
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 02:27:49 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:62758 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261515AbVGDG1k convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 02:27:40 -0400
Received: by rproxy.gmail.com with SMTP id i8so624146rne
        for <git@vger.kernel.org>; Sun, 03 Jul 2005 23:27:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R1kp4d5NTQd+4zp2SEU6+5vWd+A9qHzYZcZR6q+LYPCTolbAFpy9XpPERAeAGnZ9FFE1Qazxo/rePYeaduEou3JE5aDYawvCwJvDKnHZGXA1u16zS9szpg2SdY5aPu9eDQMERLq3yHAN4ohv0w39kuvqOvTakTAM2APK57M0/PU=
Received: by 10.38.209.48 with SMTP id h48mr2735708rng;
        Sun, 03 Jul 2005 23:27:40 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Sun, 3 Jul 2005 23:27:40 -0700 (PDT)
To: GIT <git@vger.kernel.org>
In-Reply-To: <1120425269.6845.28.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > OK, I see. How about using wiggle instead?
> >
> >         http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/
> >
> > That's what patch-utils uses if you run "pushpatch -m". wiggle is also
> > a lot smarter than diff3, so there will be fewer cases that result in
> > a conflict. Maybe a parameter to "stg push" could enable wiggle mode.
> 
> I haven't used wiggle before but I will give it a try (though I prefer
> such a tool not to be too smart since it might make mistakes). Anyway, I
> will make this configurable, i.e. you could put something like below in
> the .stgitrc file:

wiggle is good but it's not safe. You should definitely review the
results of a wiggle merge with extra care. It sometimes does magic and
merges the unmergeable, and sometimes it does bad, bad things.

cheers,


martin
