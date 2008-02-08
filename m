From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: Adding gitweb.owner, last shot
Date: Fri, 8 Feb 2008 11:51:50 -0200
Message-ID: <20080208135150.GB30264@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> <m3abmb4tyx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 14:53:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNTew-0002hB-Nn
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 14:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbYBHNwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 08:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbYBHNwV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 08:52:21 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:45881 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbYBHNwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 08:52:20 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 9E8BB700003D9;
	Fri,  8 Feb 2008 11:52:18 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <m3abmb4tyx.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73089>

On Fri, Feb 08, 2008 at 02:34:55AM -0800, Jakub Narebski wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> 
><snip> 
> Pasky, could you please try to benchmark this (well, at least without
> gitweb.owner set) on a _real_ large set of repositories?

And I'd like to know what this machine runs! If it is git dedicated, or
shares with something else.

If it is git dedicated, it makes time better as disk IO will not be severe.

>  
> > The idea of creating only the gitweb.owner can be a case of study to
> > centralize all gitweb repository configuration in one file. Maybe even
> > change the way $projects_list is formated, as gitweb.cgi needs to check
> > repository configuration to get repository description to generate
> > project_list page, we could just list repository's directories.
> 
> I was thinking about git-config-like format (but simplified to make it
> easy to parse it in Perl, just like git-cvsserver configuration), in
> the form of
> 
> [gitweb "<repository path, relative to $projectroot>"]
>         description = <project description>
>         url = <first URL>
>         url = <seconf URL>
>         owner = <repository owner>
> 
> The problem with parsing lies (among others) in the in-line comments,
> novalue keys, and key after section, I think...
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
