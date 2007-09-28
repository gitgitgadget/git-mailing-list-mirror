From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn eliminating master
Date: Fri, 28 Sep 2007 14:43:00 -0700
Message-ID: <7vlkaqo49n.fsf@gitster.siamese.dyndns.org>
References: <46FD5DAF.7030204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 23:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbNcE-00073k-B3
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 23:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbXI1VnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXI1VnJ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 17:43:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:43928 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbXI1VnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 17:43:08 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A1AE413DA00;
	Fri, 28 Sep 2007 17:43:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 222EA13D9A8;
	Fri, 28 Sep 2007 17:43:24 -0400 (EDT)
In-Reply-To: <46FD5DAF.7030204@gmail.com> (Russ Brown's message of "Fri, 28
	Sep 2007 15:01:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59423>

Russ Brown <pickscrape@gmail.com> writes:

> So I've been using git-svn for a while, and just decided to try
> publishing my repo via gitweb so I can experiment with showing others my
> local branches before I dcommit them to the subversion repository (i.e.
> allowing code review prior to commit).
>
> It's working pretty nicely: the only problem I have is the master
> branch. I don't use master at all, and I'm willing to be that a lot of
> other git-svn users don't either. I take all of my branches from either
> trunk or one of the other upstream svn server branches.
>
> The problem is gitweb appears to show the master branch by default,
> while I'd rather show trunk by default.

I think gitweb shows wherever HEAD points at.  Update the file
on the server and see if it helps.
