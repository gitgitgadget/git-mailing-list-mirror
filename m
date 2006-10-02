From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 2 Oct 2006 12:46:50 -0700 (PDT)
Message-ID: <20061002194650.12839.qmail@web31806.mail.mud.yahoo.com>
References: <7vd59b27c4.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 21:47:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUTke-0005bC-2I
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbWJBTqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965392AbWJBTqv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:46:51 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:47803 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965389AbWJBTqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:46:51 -0400
Received: (qmail 12841 invoked by uid 60001); 2 Oct 2006 19:46:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LYtFRtsueTvgY9hIBWOeEp1sobqyI+nc1lyx5JLgcpqxxDvAj67bePRmRCyhmMx4sSHw1Ud9YO7UZqq5tKML+C39IyqoEFm/Z4JwH+t9OpvFjEYC5dh8OvK1YXgz3JpFla08HOSuEz6Ikb854M11z052srUhy4V5nmUG+AB9sMI=  ;
Received: from [64.215.88.90] by web31806.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 12:46:50 PDT
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vd59b27c4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28231>

--- Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > ... That means that we cannot distinguish really well (at 
> > least color) between tree and blob entries.
> 
> Do we even say links are blue and underlined by forcing that in
> our css?
> 
> Doesn't leading drwxr-xr-x mean anything?
> 
> Why is making the distinction important in the first place?
> 
> > In the case of shortlog/log/history/heads/tags view, to clearly mark 
> > subject/title of a commit or tag as link, we would have to use default 
> > link decoration....
> > But underlined text is harder to read, and blue underlined text even 
> > more so...
> 
> This is something in which I can see some more sense than tree
> vs blob issue, but only as a principle issue.  In practice, the
> list of commit subjects is the first thing users encounter, and
> as long as there is some visual indication (e.g. mousing over it
> makes it obvious it is something that is clickable), I think
> users will quickly pick up that it will lead to the commit's
> detail.

Very well put.

   Luben
