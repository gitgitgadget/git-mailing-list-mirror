From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 7 May 2006 18:08:03 +1200
Message-ID: <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	 <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	 <87mzdx7mh9.wl%cworth@cworth.org>
	 <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org>
	 <e3fqb9$hed$1@sea.gmane.org>
	 <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org>
	 <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com>
	 <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 08:08:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FccRG-0004d0-2f
	for gcvg-git@gmane.org; Sun, 07 May 2006 08:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWEGGIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 02:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEGGIF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 02:08:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:45786 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751140AbWEGGIE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 02:08:04 -0400
Received: by wr-out-0506.google.com with SMTP id 68so780959wri
        for <git@vger.kernel.org>; Sat, 06 May 2006 23:08:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JmiYC1O8G7yQQi6nRDwqi81w8qWxY/9Jz7lpja3hb/hnN+Nx1YalK5BOVf2oquYLnipqnKEeE+yiRDP6nxcaHKnednwMr++e1pfonQtH96lScJwmYkJySMdI3K3qEvCgG2dP/XGCYg6/12LxOaTg8Gv5k1zI97/dgqcDMwsY4cY=
Received: by 10.54.86.16 with SMTP id j16mr1004523wrb;
        Sat, 06 May 2006 23:08:03 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Sat, 6 May 2006 23:08:03 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19692>

On 5/6/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> >
> > It means that for a merge or checkout involving stuff we "don't have",
> > it's trivial to know we are missing, and so we can  attempt a fetch of
> > the missing objects or tell the user how to request them them before
> > retrying.
> >
> > And in any case commits and trees are lightweight and compress well...
>
> Commit maybe, but is this based on a hard fact?

No hard facts here :( but I think it's reasonable to assume that the
trees delta/compress reasonably well, as a given commit will change
just a few entries in each tree.

I might try and hack a shallow local clone of the kernel and pack it
tightly to see what it yields.

cheers,



martin
