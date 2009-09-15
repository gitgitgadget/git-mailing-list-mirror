From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: Pair Programming Workflow Suggestions
Date: Tue, 15 Sep 2009 11:14:13 -0700
Message-ID: <BLU0-SMTP195165E447A0C42386D083AEE30@phx.gbl>
References: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 20:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MncXv-0005B0-7f
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 20:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbZIOSOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 14:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZIOSOW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 14:14:22 -0400
Received: from blu0-omc3-s19.blu0.hotmail.com ([65.55.116.94]:20677 "EHLO
	blu0-omc3-s19.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057AbZIOSOV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Sep 2009 14:14:21 -0400
Received: from BLU0-SMTP19 ([65.55.116.72]) by blu0-omc3-s19.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Sep 2009 11:14:25 -0700
X-Originating-IP: [66.183.97.179]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([66.183.97.179]) by BLU0-SMTP19.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Sep 2009 11:14:23 -0700
In-Reply-To: <c115fd3c0909151043v3216a147v35e18710fbead515@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.5; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Sep 2009 18:14:24.0032 (UTC) FILETIME=[5AA12200:01CA3630]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128576>

On Tue, 15 Sep 2009 13:43:17 -0400
Tim Visher <tim.visher@gmail.com> wrote:

[...]
> It would be nicer to
> have an arbitrary number of authors that can all exist separately, but
> I'm fairly certain that git does not support that.

Tim,

If you're just looking for a way to quickly switch the author information
quickly between individual commits.  You could create a shell alias for
each of the programmers that does:

   export GIT_AUTHOR_NAME="some name" GIT_AUTHOR_EMAIL="name@where.com"

This will override the global and per repo configured author information
for all subsequent commits.

HTH,
Sean
