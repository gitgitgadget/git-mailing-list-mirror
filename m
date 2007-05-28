From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
	after-the-fact annotations on commits
Date: Mon, 28 May 2007 20:42:05 +0300
Message-ID: <20070528174205.GB7295@mellanox.co.il>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
	<200705102006.08624.johan@herland.net>
	<alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
	<200705271608.02122.johan@herland.net>
	<alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org>
	<20070528172949.GA7295@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon May 28 19:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsjEe-0004vt-94
	for gcvg-git@gmane.org; Mon, 28 May 2007 19:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbXE1RmM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 13:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXE1RmM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 13:42:12 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:37824 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbXE1RmL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 13:42:11 -0400
Received: by py-out-1112.google.com with SMTP id a29so480177pyi
        for <git@vger.kernel.org>; Mon, 28 May 2007 10:42:10 -0700 (PDT)
Received: by 10.64.184.16 with SMTP id h16mr11043241qbf.1180374130090;
        Mon, 28 May 2007 10:42:10 -0700 (PDT)
Received: from ?127.0.0.1? ( [85.250.15.252])
        by mx.google.com with ESMTP id e16sm11618627qba.2007.05.28.10.42.07;
        Mon, 28 May 2007 10:42:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070528172949.GA7295@mellanox.co.il>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48630>

> Quoting Michael S. Tsirkin <mst@dev.mellanox.co.il>:
> Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
> 
> > Quoting Linus Torvalds <torvalds@linux-foundation.org>:
> > Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
> > 
> > 
> > 
> > On Sun, 27 May 2007, Johan Herland wrote:
> > > 
> > > I've been working on combining tag objects and --decorate into a useful
> > > proof-of-concept that provides the after-the-fact commit annotations I
> > > requested above, and here's the result:
> > 
> > Ok, looks fine to me. I do have a few questions:
> >  - why don't you just let people name their notes, the same way we name 
> >    tags (and then actually using it as the note name?)
> > 
> >    Putting them in the refs/notes/ filesystem by their SHA1 seems a bit 
> >    wasteful, and it would seem that it could be quite nice to name the 
> >    notes some way?
> > 
> >  - This will probably scale horribly badly if you have tens of thousands 
> >    of notes, even when they are packed. Do we care?
> 
> Maybe note names could include the object they point to?
> Would this help with the scalability too (i.e. only get
> names for objects we want)?

Hmm, I just noticed there's refs/notes/{object-sha}/{note-sha}
that does exactly that. So - this seems to be clear to everyone
else, but I seem to miss the reason why does this not scale well?
We can just get the notes for objects we pull, right?

-- 
MST
