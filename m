From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit 1.1.1
Date: Mon, 20 Mar 2006 17:32:16 +0100
Message-ID: <e5bfff550603200832h4373dcb4vda4a6c622d9ab6bc@mail.gmail.com>
References: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
	 <20060319214907.GA7294@elte.hu>
	 <e5bfff550603191401h2c206950w1a0e04cd50fc5370@mail.gmail.com>
	 <e5bfff550603191404l7511e76awe980fad51ffde98d@mail.gmail.com>
	 <20060320102022.GA21917@elte.hu>
	 <e5bfff550603200413i22a37a43n4d5a9b0ba63e880d@mail.gmail.com>
	 <20060320144613.GA25617@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, proski@gnu.org
X-From: git-owner@vger.kernel.org Mon Mar 20 17:32:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLNIt-0001ZN-5R
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 17:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWCTQcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 11:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWCTQcT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 11:32:19 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:38383 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965106AbWCTQcS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 11:32:18 -0500
Received: by wproxy.gmail.com with SMTP id i14so1034693wra
        for <git@vger.kernel.org>; Mon, 20 Mar 2006 08:32:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CWAWZ8BDPJqeyKcuFr+VIDRqzA2f2jylJK4qeGx9XcwkzEZc9QHNrnFIlvJt6jIkLDfJ9xX/q73voPIoyuIsf4NXv82mDV0WivZhxoQ2CqELfQQKYiBWCiXi5vA4kLh5REWU/Educ0k9kDbTTytuebEjUf5GP8/LOLh0fwTLDks=
Received: by 10.64.249.4 with SMTP id w4mr102585qbh;
        Mon, 20 Mar 2006 08:32:16 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Mon, 20 Mar 2006 08:32:16 -0800 (PST)
To: "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <20060320144613.GA25617@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17758>

On 3/20/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Marco Costalba <mcostalba@gmail.com> wrote:
>
> > The wrong command is git-diff-tree -r -c -p 46571...
> >
> > I think it's about the quite new option -c of git-diff-tree.
> >
> > Please upgrade your git to latest version, better upstream one, but
> > 1.2.4 should be enough.
>
> ok, that did the trick.
>
> there's a weird rendering artifact as well, see the white line in the
> screenshot [that i'll send you in a separate mail]. It goes away if i
> drag another window in front of the qgit window. It happens if i
> double-click a 'merge' branch, exit qgit and start it again [and the
> separator line needs to obscur the commit line just partially]. This is
> an uptodate FC4 installation.
>
Yes, sometimes I see it either. To remove I use the scrollbar to
hide/unhide the line,
i.e. to force a repaint.

I think it is something related to Qt rendering engine, I doubt I
could do something about it.

BTW someone off list suggested me to implement a 'git version check'
control and related message box to avoid your troubles to someone
else: I'm surely going to do it.

Marco
