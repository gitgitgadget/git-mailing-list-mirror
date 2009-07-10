From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitweb: buggy 'commitdiff_plain' output
Date: Fri, 10 Jul 2009 14:05:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907101405480.3352@localhost.localdomain>
References: <alpine.LFD.2.01.0907100941060.3352@localhost.localdomain> <200907101933.39424.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 23:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPNNZ-00035e-8p
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 23:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbZGJVLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 17:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZGJVLa
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 17:11:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50054 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbZGJVL3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 17:11:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6AL5vEN002979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Jul 2009 14:05:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6AL5uB1026015;
	Fri, 10 Jul 2009 14:05:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <200907101933.39424.jnareb@gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123083>



On Fri, 10 Jul 2009, Jakub Narebski wrote:

> On Fri, 10 July 2009, Linus Torvalds wrote:
> > 
> > It turns out that that duplication is because they use gitweb as a strange 
> > patch distribution system (rather than emailing each other patches), and 
> > download the 'commitdiff_plain' version of the diff and then apply it with 
> > 'git am -s'.
> 
> First question: do they use gitweb from git.git repository, or a custom
> fork of gitweb (like git.kernel.org gitweb, which has caching, but IIRC
> does not have all new gitweb features)?

I have no idea. Afaik, it was on samba.org:

	http://git.samba.org/?p=jlayton/cifs.git;a=commitdiff_plain;h=acc11a88a4cb4ba16777099da00664347e0683f0

and I have no clue whether samba org uses plain git gitweb or something 
fancier.

		Linus
