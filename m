From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 30 May 2006 12:19:20 +1200
Message-ID: <46a038f90605291719r292269bct61bf2817a9791e3d@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
	 <44720C66.6040304@gentoo.org>
	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
	 <447215D4.5020403@gentoo.org>
	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>
	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
	 <447B7669.8050805@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 30 02:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkrxM-00081F-2H
	for gcvg-git@gmane.org; Tue, 30 May 2006 02:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWE3ATV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 20:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWE3ATV
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 20:19:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:1854 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932093AbWE3ATU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 20:19:20 -0400
Received: by wr-out-0506.google.com with SMTP id i7so988101wra
        for <git@vger.kernel.org>; Mon, 29 May 2006 17:19:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rk+F4tfkyyOW+wApP21MhKkC8aS4N8F6v2JHcSLLdiOjc4y789krUOAKt4DJisI+JPzIPlkOiB2LBrazw2QqsTKppBCXZ5bJmV2BnKHjK4hbW7v5VwfOm5dO3rj8RL7vTk7OATzvlkuZskwd11M2E0AvbAYYUcoR4+PSJkI1ynk=
Received: by 10.54.101.13 with SMTP id y13mr2654142wrb;
        Mon, 29 May 2006 17:19:20 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Mon, 29 May 2006 17:19:20 -0700 (PDT)
To: "Donnie Berkholz" <spyderous@gentoo.org>
In-Reply-To: <447B7669.8050805@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20999>

On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
> Looking closer, I see that the memory suckers do appear to be git, from
> dmesg:
>
> Out of Memory: Kill process 17230 (git-repack) score 97207 and children.
> Out of memory: Killed process 17231 (git-rev-list).

That would mean that you do have Linus' patch then. Grep cvsimport for
repack and remove the -a -- and consider using his recent patch to
rev-list.

My dmesg talks about an earlier cvs segfault. Nasty tree you have here
-- it's breaking all sorts of things... and teaching us a thing or two
about the import process.

> Committed patch 249100 (origin 2005-08-20 05:05:58)

Hmmm? How can you be at patch 249100 and still be a good year ahead of
me? Have you told cvsps to cut off old history?

Another thing I found is that this import uses a lot of $TMPDIR, so if
your TMPDIR is small, you'll hit all sorts of problems.

cheers,



martin
