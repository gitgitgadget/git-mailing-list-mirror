From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 11:01:53 +0100
Message-ID: <200901151101.53441.johan@herland.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
 <496EE74F.6000205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 11:03:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNP4w-0002K1-7u
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 11:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbZAOKCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 05:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755923AbZAOKCg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 05:02:36 -0500
Received: from smtp.getmail.no ([84.208.20.33]:40738 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341AbZAOKCf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 05:02:35 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KDI00L2NBW83D00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 15 Jan 2009 11:02:32 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KDI00953BV52K40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 15 Jan 2009 11:01:53 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KDI002ZEBV5YUL5@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 15 Jan 2009 11:01:53 +0100 (CET)
In-reply-to: <496EE74F.6000205@viscovery.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105777>

On Thursday 15 January 2009, Johannes Sixt wrote:
> Johannes Schindelin schrieb:
> > On Thu, 15 Jan 2009, Anders Melchiorsen wrote:
> >> Previously, the interactive rebase edit mode placed the user after the
> >> commit in question. That was awkward because a commit is supposedly
> >> immutable. Thus, she was forced to use "git commit --amend" for her
> >> changes.
> >
> > Maybe, maybe not.  I frequently rebase with "edit" when I actually mean
> > "stop" (but "s" was taken from "squash" already).  Then I test things,
> > possibly fixing them.
> >
> > So in that case, I do not want a git reset --soft HEAD^.
>
> Absolutely! I use "edit" for this purpose as well quite frequently.

What about providing both options?

"modify" does the "git reset --soft HEAD^" (Anders' suggestion)
"amend" requires a "git commit --amend" (current behaviour)
"edit" == "amend", but is deprecated and goes away in the future


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
