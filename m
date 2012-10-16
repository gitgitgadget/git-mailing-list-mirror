From: Christian Thaeter <ct@pipapo.org>
Subject: Re: feature request
Date: Tue, 16 Oct 2012 15:34:29 +0200
Message-ID: <20121016153429.6e06ef91@jupiter.pipapo.org>
References: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:40:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO7O5-0007He-2B
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 15:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab2JPNkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 09:40:37 -0400
Received: from pipapo.org ([217.8.62.137]:38165 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2JPNkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 09:40:37 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2012 09:40:36 EDT
Received: from jupiter.pipapo.org (unknown [10.30.0.6])
	by mail.pipapo.org (Postfix) with ESMTP id F3C539E02221;
	Tue, 16 Oct 2012 13:34:30 +0000 (UTC)
In-Reply-To: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207823>

Am Tue, 16 Oct 2012 13:36:04 +0200
schrieb Angelo Borsotti <angelo.borsotti@gmail.com>:

> Hello,
> 
> some VCS, e.g. ClearCase, allow to control the fetching of files so as
> to warn, or
> disallow parallel changes to the same files.
> As of today, there is no way to implement the same kind of workflow
> with git because there are no fetch hooks.
> Would it be a good idea to provide them?


I've actually implemented a 'git lock' command to lock pathnames from
concurrent editing for a customer. Normally one would say this is a
rather ill and ugly feature for git but there where some reasons to do
it anyways (imagine robots crashing into each other on a production
line because of bad (developer-)communication).

The code is GPL and I can distribute it, but I didn't consider it ready
for an open announcement yet. Noteworthy some problems with msys led
to some ugly solution (the uniq command doesn't know the -z option
there).

I hope this might be useful to you. I'd also like to get contributions
and fixes if there are any problems I am not aware of.

Short into; the doc:

 http://git.pipapo.org/?p=git;a=blob_plain;f=Documentation/git-lock.txt;h=dcc7a5c34dea657ab5819e8def54e154d5d97219;hb=25ee09cf35daa03a7c2ef10537561a50db2d17b2

the code is available at

 git://git.pipapo.org/git

in the 'ct/git-lock' branch.

It is a bit fallen behind the current git version, I will update/merge
it sometime next (to keep in par with msysgit, thats what is required
here)

	Christian




> 
> -Angelo Borsotti
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
