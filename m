From: Bertrand Jacquin <beber.mailing@gmail.com>
Subject: Re: git-http-push and hooks
Date: Tue, 7 Feb 2006 21:51:25 +0100
Message-ID: <4fb292fa0602071251y173efc4dw98fe1e4c035741a3@mail.gmail.com>
References: <20060206205203.GA20973@guybrush.melee>
	 <20060206232231.GK3873@reactrix.com>
	 <20060207195458.GA7217@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 21:53:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6ZoC-0003ua-SB
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 21:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWBGUva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 15:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBGUva
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 15:51:30 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:16701 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbWBGUv3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 15:51:29 -0500
Received: by uproxy.gmail.com with SMTP id s2so50027uge
        for <git@vger.kernel.org>; Tue, 07 Feb 2006 12:51:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KkH6tH4tlloaObNlikJpyXBLdUtadj5gWjCsc+1Nj6r/AgW00DgBvOKr81bBbV9LTX/v904TO+jXkGCD+saUkY06RnC3XrnyX9bXUQywiRi0xW+qlRnnOAK/n/oa4wrxfNlfDPmBFlL3g1g5ZPbO1c/4hBJRwXRyNt9xkP6ZHNw=
Received: by 10.48.235.15 with SMTP id i15mr1696730nfh;
        Tue, 07 Feb 2006 12:51:25 -0800 (PST)
Received: by 10.49.5.3 with HTTP; Tue, 7 Feb 2006 12:51:25 -0800 (PST)
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060207195458.GA7217@c165.ib.student.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15714>

On 2/7/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
> On Mon, Feb 06, 2006 at 03:22:31PM -0800, Nick Hengeveld wrote:
> > On Mon, Feb 06, 2006 at 09:52:03PM +0100, Bertrand Jacquin (Beber) wrote:
> >
> > > Why aren't excute hooks/* (with +x perms) when I do a git-http-push ?
> > > Also if i push with cg-push on the same repo but with git+ssh
> > > protocol, hooks are execute.
> >
> > Hooks must run on the destination server when you're doing a push.  If
> > you use the git+ssh protocol, that server is running a git daemon that
> > knows how to execute hooks; if you use the http/DAV protocol, that
> > server does not.
> >
>
> I know basically nothing about DAV, but wouldn't it be possible to
> have a CGI-script which executes the hooks upon the client's request?

Svn can execute hooks :/ But maybe this is implemented in -D SVN
module for Apache. Donno

>
> - Fredrik
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Beber
#e.fr@freenode
