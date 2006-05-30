From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Tue, 30 May 2006 18:01:58 +1200
Message-ID: <46a038f90605292301h667291cdo7260683f8e746933@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
	 <447215D4.5020403@gentoo.org>
	 <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
	 <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>
	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
	 <447B7669.8050805@gentoo.org>
	 <46a038f90605291719r292269bct61bf2817a9791e3d@mail.gmail.com>
	 <447BD8C1.6090402@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 30 08:02:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkxIq-00079i-4d
	for gcvg-git@gmane.org; Tue, 30 May 2006 08:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWE3GCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 02:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWE3GCA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 02:02:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:43294 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932121AbWE3GB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 02:01:59 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1033078wra
        for <git@vger.kernel.org>; Mon, 29 May 2006 23:01:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZQJcULPZuOCVAVqfvcPnTtDsLQxE0xTRDYxHDoI26vBv9kBCR3HRg/J045uGdQl+8KLKjkqGEdboASrbog6dNFd19qxhUrIz0iNtcLHgHkCVAqKO5Od6iJs1S5IuCP2G6op1Ap5UVxBU35vjQwvl1i9rMGKx7+riDFCR8YnxTTM=
Received: by 10.54.79.14 with SMTP id c14mr2882796wrb;
        Mon, 29 May 2006 23:01:58 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Mon, 29 May 2006 23:01:58 -0700 (PDT)
To: "Donnie Berkholz" <spyderous@gentoo.org>
In-Reply-To: <447BD8C1.6090402@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21017>

On 5/30/06, Donnie Berkholz <spyderous@gentoo.org> wrote:
> All I can think of is that I somehow OOM'd when I manually ran a repack
> and didn't notice it. But that should've at least made me unable to
> resume the cvsimport process, which happily kept chugging along later on.

Sounds likely -- and cvsimport restarts gracefully, though you might want to do

   git checkout HEAD

to get a usable checkout if the very first import failed. However, the
default head is master, and what you want to look at is origin or
whatever you passed as your -o parameter. I use cvshead normally, so I
do

   git log cvshead

> > My dmesg talks about an earlier cvs segfault. Nasty tree you have here
> > -- it's breaking all sorts of things... and teaching us a thing or two
> > about the import process.
> >
> >> Committed patch 249100 (origin 2005-08-20 05:05:58)
> >
> > Hmmm? How can you be at patch 249100 and still be a good year ahead of
> > me? Have you told cvsps to cut off old history?
>
> Nope. I ran the exact cvsps flags you posted earlier to create it.

Oh, that was an earlier PEBKAK at my end: I did git log HEAD instead
of git log cvshead. My import is now at  293145 (cvshead +0000
2005-12-25 12:24:42) which looks promising.

cheers,


martin
