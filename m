From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 08:35:36 -0400
Message-ID: <20070728083536.540e471d.seanlkml@sympatico.ca>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 14:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IElXV-0002oc-MI
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 14:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXG1Mgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 08:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbXG1Mgn
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 08:36:43 -0400
Received: from bay0-omc2-s33.bay0.hotmail.com ([65.54.246.169]:43871 "EHLO
	bay0-omc2-s33.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725AbXG1Mgm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 08:36:42 -0400
Received: from BAYC1-PASMTP02.bayc1.hotmail.com ([65.54.191.162]) by bay0-omc2-s33.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 28 Jul 2007 05:36:42 -0700
X-Originating-IP: [69.156.137.240]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.137.240]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 28 Jul 2007 05:36:41 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IElXE-0001lg-QL; Sat, 28 Jul 2007 08:36:40 -0400
In-Reply-To: <7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 28 Jul 2007 12:36:41.0974 (UTC) FILETIME=[F34B7160:01C7D113]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54027>

On Sat, 28 Jul 2007 05:14:26 -0700
Junio C Hamano <gitster@pobox.com> wrote:

Hi,

> Benoit SIGOURE <tsuna@lrde.epita.fr> writes:
> 
> > git version 1.5.2.3 over here, I've googled and searched in the ML
> > archives but did not find this:  when I git-svn rebase, my commits in
> > Git (that are temporarily removed and then re-applied) get their
> > commit message flattened on a single line...
> 
> Do you mean by "my commits in Git" a commit you created with git
> in your git repository?
> 

Tested this here (rc3.24.g83b3d) and can confirm the reported problem.
After making a commit in git and then running "git svn rebase" to
receive updates from the svn repo, the rebased commit has a borked
description (multi-lined commit message appears all on one line).

Sean
