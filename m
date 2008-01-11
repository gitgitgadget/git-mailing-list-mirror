From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 21:12:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801112111170.31053@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>  <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>  <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>  <alpine.LSU.1.00.0801111348230.31053@racer.site> 
 <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>  <m3odbsmlkr.fsf@roke.D-201> <30e4a070801110815q1dee8f0cr7966fc2896e4c790@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRCj-0002oQ-W4
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761629AbYAKVNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbYAKVNL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:13:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:58702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761608AbYAKVNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:13:09 -0500
Received: (qmail invoked by alias); 11 Jan 2008 21:13:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 11 Jan 2008 22:13:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19o8Nwt9Nlo3Ga7Vcn0BHp/V68u9Ag13saRfBosAt
	66l5aeIUEBjETs
X-X-Sender: gene099@racer.site
In-Reply-To: <30e4a070801110815q1dee8f0cr7966fc2896e4c790@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70202>

Hi,

On Fri, 11 Jan 2008, Mark Levedahl wrote:

> On Jan 11, 2008 10:25 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > Mark, if this change is mainly about the fact that git doesn't allow 
> > to specify default remote to fetch for detached HEAD (and submodules 
> > use detached HEAD), why not provide "branch.HEAD.remote" etc., which 
> > would be used _only_ if we are on detached HEAD (i.e. branch has no 
> > name).
>
> Practically speaking, this would just change the name of the config 
> variable (from remotes.default to branch.HEAD.remote). However, this 
> value is used *whenever* the current branch does not have corresponding 
> branch.<name>.remote, and that is not restricted to detached heads, it 
> applies anytime the current HEAD is not a tracking branch. So, I believe 
> remotes.default better reflects this generality than does 
> branch.HEAD.remote.

Practically speaking, I have enough experience to _know_ that your 
solution will not help very much.  It will just add to confusion.

You stated quite clearly -- _after_ I asked -- what your problem is, and I 
am quite certain that you _still_ have to look up _something_ (as I 
remarked in the email you responded to).

So it is still _utterly_ unclear to me how your patch helps anything.

Ciao,
Dscho
