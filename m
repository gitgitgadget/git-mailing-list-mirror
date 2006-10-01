From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Sun, 1 Oct 2006 21:27:36 +0200
Message-ID: <200610012127.37113.jnareb@gmail.com>
References: <efc2no$eti$2@sea.gmane.org> <200610012041.15296.jnareb@gmail.com> <7vd59b27c4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 21:27:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6yD-0000pQ-Fr
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWJAT1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWJAT1W
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:27:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:4687 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932200AbWJAT1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 15:27:21 -0400
Received: by ug-out-1314.google.com with SMTP id o38so443020ugd
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 12:27:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FPbmIm/XWZsfJEpFDR6jstoUzdNF7P1uH709ACKdcZTRGnIpkZ68qmDe0Dd0pi6vKsRrbHu+gjw/JkbtmotCzFno4pZOZVCxFHF6Cr6jPrfU1iO2ei16s6BJGDDx6PQn1rTho1gqj4T1xd+TCSVp47paRd5RFAt8MMo2Ek+0hk0=
Received: by 10.67.119.5 with SMTP id w5mr2162777ugm;
        Sun, 01 Oct 2006 12:27:19 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id k30sm4526529ugc.2006.10.01.12.27.18;
        Sun, 01 Oct 2006 12:27:19 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <7vd59b27c4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28195>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > ... That means that we cannot distinguish really well (at 
> > least color) between tree and blob entries.
> 
> Do we even say links are blue and underlined by forcing that in
> our css?

That is default style of link element, as specified by default CSS
for HTML/XHTML.

> Doesn't leading drwxr-xr-x mean anything?

Neither d in drwxr-xr-x, nor trailing / in the name are significant
enough indicators of directory vs file (tree vs blob) indicator,
especially that by default git-ls-tree output mixes trees with blobs.
 
> Why is making the distinction important in the first place?

If you browse tree, you usually click on tree links, but not on blob
links.

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

Well, that is certainly the question of style (redundancy vs. uncluttered
output plus some coding issues).

By the way, I've planned to move printing those kind of links to separate
subroutine (output based on type of object the links are related to, and
somewhat als on the action/view we are in)...
-- 
Jakub Narebski
Poland
