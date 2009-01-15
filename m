From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 01:53:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGUK-0001gT-OY
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbZAOAwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbZAOAwM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:52:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:40370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753907AbZAOAwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:52:10 -0500
Received: (qmail invoked by alias); 15 Jan 2009 00:52:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 15 Jan 2009 01:52:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nDO4crK7nALydTiM0ZAFcGFRdN/j3fuy/mKX6jV
	NXwg8Ut+9xkrzn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ab9th0rh.fsf@cup.kalibalik.dk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105747>

Hi,

On Thu, 15 Jan 2009, Anders Melchiorsen wrote:

> Previously, the interactive rebase edit mode placed the user after the 
> commit in question. That was awkward because a commit is supposedly 
> immutable. Thus, she was forced to use "git commit --amend" for her 
> changes.

Maybe, maybe not.  I frequently rebase with "edit" when I actually mean 
"stop" (but "s" was taken from "squash" already).  Then I test things, 
possibly fixing them.

So in that case, I do not want a git reset --soft HEAD^.

In any case, there is a pretty obvious difference between a merge conflict 
and a stop at "edit": the latter even shows you a pretty verbose 
explanation what to do next.

I also have to admit that it escapes me why you would want to force a new 
commit if nothing was changed to begin with.

However, I often would like to have "amend message" or some such, and I 
remember having seen patches, but I do not remember why they did not make 
it in.

Ciao,
Dscho
