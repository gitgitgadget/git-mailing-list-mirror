From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] Make get_git_dir() and 'git rev-parse --git-dir'
 absolute path
Date: Tue, 11 Mar 2008 17:20:07 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111716500.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com>  <20080302103348.GA8929@laptop>  <alpine.LSU.1.00.0803111420080.3873@racer.site>  <fcaeb9bf0803110806u43fbd8b8v3ec2adf84fa1cd5e@mail.gmail.com>  <alpine.LSU.1.00.0803111616050.3873@racer.site>
 <fcaeb9bf0803110839m582bed5cr5b3e198712e0fe8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:22:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ7E6-0005CX-SX
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYCKQUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbYCKQUF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:20:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:53454 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbYCKQUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:20:03 -0400
Received: (qmail invoked by alias); 11 Mar 2008 16:20:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 11 Mar 2008 17:20:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ehGc4z65eoKTCj1r4hHzYYwBoTOQ71ycf+YbTo8
	kiMXyRQ1vanriw
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0803110839m582bed5cr5b3e198712e0fe8e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76875>

Hi,

On Tue, 11 Mar 2008, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 11, 2008 at 10:18 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >  Besides, I remember that Junio specifically requested that I would 
> >  _not_ do something like that (this was for --show-cdup, but I think 
> >  it really applies here, too).
> 
> I might have lost track. Could you provide me the link for reference? 
> Thanks.

http://article.gmane.org/gmane.comp.version-control.git/53993/match=show+cdup

This is how you can find it yourself next time (and how I found it):

Go to gmane, search for "show-cdup", then select Junio as writer.  It is 
already the second hit, which was obvious by the email's title.

> >  I do not see the problem.  And therefore I do not see that this patch 
> >  solves anything.
> 
> It can simplify things (in other patches, such as builtin-config.c 
> changes). Though without it things just run fine (with a little more 
> complication in prefix handling). Recent mails about git-am running in 
> subdirectory (Message-ID: 
> 20080301062255.GA27538@coredump.intra.peff.net) made me think there was 
> room for this.

Okay, I see that you want to simplify things.  However, I am not at all 
convinced that your patch series does that.

However, instead of continuing this thread, I will try to find some time 
later this week to look into simplifying the work-tree logic again.

If I find things, I will discuss them on the list.

Ciao,
Dscho
