From: Matthias Kestenholz <lists@irregular.ch>
Subject: Re: Bug encountered while comitting
Date: Sat, 25 Mar 2006 02:15:30 +0100
Message-ID: <20060325011530.GA25951@spinlock.ch>
References: <20060324183951.GA23193@spinlock.ch> <442449E1.5060007@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 02:15:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMxNk-00019r-8O
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 02:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCYBPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 20:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCYBPx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 20:15:53 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:51190 "EHLO
	mail13.bluewin.ch") by vger.kernel.org with ESMTP id S1751363AbWCYBPw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 20:15:52 -0500
Received: from spinlock.ch (62.203.176.109) by mail13.bluewin.ch (Bluewin 7.2.071)
        id 441EA1DA0013B55D; Sat, 25 Mar 2006 01:15:49 +0000
Received: (nullmailer pid 26185 invoked by uid 1000);
	Sat, 25 Mar 2006 01:15:30 -0000
To: Andreas Ericsson <ae@op5.se>
Mail-Followup-To: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <442449E1.5060007@op5.se>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17945>

* Andreas Ericsson (ae@op5.se) wrote:
> Matthias Kestenholz wrote:
> >
> >The PHP script created directories under .git/objects
> 
> 
> Ouch... You're not really supposed to do that. The proper thing to do is 
> to do things in the working tree and commit them to git later.
> 

I think I did not express myself clearly. The PHP Script executes
git commands which in turn create or modify the mentioned
directories. I do not create them myself by hand.

> >When I tried to commit, I got a message saying "Unable to write sha1
> >filename".
> >
> 
> What file were you trying to write?
> 

Some file I was updating (in this case, a file holding some wiki
content)

> >The result was, that only part of the commit was recorded and that I
> >experienced repository corruption. refs/heads/master pointed to a
> >non-existant object.
> >
> 
> Did you use git tools to update .git/refs/heads/master ?
> 

Yes.

> 
> >The expected behavior would have been an error message telling me I
> >had insufficient write privileges and surely no repository
> >corruption.
> >
> 
> Didn't you get the strerror(3) message from that? If so, I'd consider it 
> a bug.

As I (only now) wrote in the other email, I got the
"Permission denied" message, and that was a sufficient hint what was
wrong.

-- 
:wq
