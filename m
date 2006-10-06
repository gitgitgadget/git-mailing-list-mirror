From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Fri, 6 Oct 2006 15:16:03 -0700 (PDT)
Message-ID: <20061006221603.50873.qmail@web31815.mail.mud.yahoo.com>
References: <eg51fi$7rs$2@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Oct 07 00:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVxzJ-0000qC-6g
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 00:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbWJFWQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 18:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422994AbWJFWQH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 18:16:07 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:51569 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422993AbWJFWQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 18:16:04 -0400
Received: (qmail 50875 invoked by uid 60001); 6 Oct 2006 22:16:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vIsSEaP0fm7sQb5pxt0TMqh/40cV+6tJbdPgoEKe01hArw91MAL7Ala9SjWoTGSvloHtbsXjH0Qgdf63ME8NwDIi78lMAlF5snMVoyGY9d+ph/bG4GEczGwqZgs31I5oXKaZquGj9RFvP2oUzIu6qV2yrOhaofE0LaJSyZd35LU=  ;
Received: from [64.215.88.90] by web31815.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 15:16:03 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <eg51fi$7rs$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28447>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Gaah, the whole cae1862a3b55b487731e9857f2213ac59d5646d commit
> "gitweb: More per-view navigation bar links" is somewhat broken.
> Up to this point we used top navigation bar for commit (hash base)
> or whole project related links, while bottom part of navigation
> bar for "formats" i.e. links related to current view (passing hash)
> or for pagination.
> 
> So while "snapshot" link has it's place in top navigation bar
> (but by modyfying git_print_page_nav subroutine, not by adding it
> by hand), "history" for example IMHO doesn't; history link should be
> present in the bottom part of navigation bar. Perhaps we could
> reuse git_print_page_nav for formats, for example blob wiew would have
>         blob | _blame_ | _history_ | _raw_ | _HEAD_
> while tree view would have
>         tree | _snapshot_ | _history_ | _HEAD_
> (where _text_ indices link).  Perhaps _snapshot_ in tree view
> shouldn't be repeated, although top one might mean snapshot of commitish,
> bottom one snapshot of tree.

Only a single one: of committish please.

    Luben
