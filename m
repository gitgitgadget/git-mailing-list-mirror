From: John Keeping <john@keeping.me.uk>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 19:54:51 +0000
Message-ID: <20131218195450.GK3163@serenity.lan>
References: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
 <20131218162710.GA3573@thyrsus.com>
 <CACPiFC+W-RiO-YL=Wgs7YzV=z-p97ehfA+64j5F2KbayPAQm8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@thyrsus.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 20:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtND2-0002D9-BH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 20:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab3LRTzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 14:55:01 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35986 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab3LRTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 14:55:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B6182CDA5B5;
	Wed, 18 Dec 2013 19:54:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2SMIei-MlJwU; Wed, 18 Dec 2013 19:54:59 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 6A139CDA55E;
	Wed, 18 Dec 2013 19:54:52 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CACPiFC+W-RiO-YL=Wgs7YzV=z-p97ehfA+64j5F2KbayPAQm8w@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239474>

On Wed, Dec 18, 2013 at 11:53:47AM -0500, Martin Langhoff wrote:
> On Wed, Dec 18, 2013 at 11:27 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> >> Anyway I hope that incremental CVS import would be needed less
> >> and less as CVS is replaced by any more modern version control system.
> >
> > I agree.  I have never understood why people on this list are attached to it.
> 
> I think I have answered this question already once in this thread, and
> a few times in similar threads with Eric in the past.
> 
> People track CVS repos that they have not control over. Smart
> programmers forced to work with a corporate CVS repo. It happens also
> with SVN, and witness the popularity of git-svn which can sanely
> interact with an "active" svn repo.
> 
> This is a valid use case. Hard (impossible?) to support. But there
> should be no surprise as to its reasons.

And at this point the git-cvsimport manpage says:

   WARNING: git cvsimport uses cvsps version 2, which is considered
   deprecated; it does not work with cvsps version 3 and later. If you
   are performing a one-shot import of a CVS repository consider using
   cvs2git[1] or parsecvs[2].

Which I think sums up the position nicely; if you're doing a one-shot
import then the standalone tools are going to be a better choice, but if
you're trying to use Git for your work on top of CVS the only choice is
cvsps with git-cvsimport.
