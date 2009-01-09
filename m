From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH, resend] git-commit: colored status when color.ui is set
Date: Fri, 9 Jan 2009 17:24:59 +0100
Message-ID: <200901091724.59983.markus.heidelberg@web.de>
References: <200901081953.01418.markus.heidelberg@web.de> <7viqoo26rq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901091155210.30769@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 17:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLKBy-0005VX-S1
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 17:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbZAIQZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 11:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbZAIQZB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 11:25:01 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:60576 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722AbZAIQY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 11:24:59 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id E7F4BF8AA48F;
	Fri,  9 Jan 2009 17:24:57 +0100 (CET)
Received: from [89.59.79.124] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LLKAL-0002NB-00; Fri, 09 Jan 2009 17:24:57 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901091155210.30769@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX190EdWKyAM2mlG+bnjbNnYI5CI5sPXILYj/urRf
	aDLbXev6CqjJMoXIPRGRoZotYBlDtPYesMBKs0YYdyDtmj5uJk
	+HamYx203TdZcbzlWufA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105019>

Johannes Schindelin, 09.01.2009:
> Hi,
> 
> On Fri, 9 Jan 2009, Junio C Hamano wrote:
> 
> > Markus Heidelberg <markus.heidelberg@web.de> writes:
> > > When using "git commit" and there was nothing to commit (the editor
> > > wasn't launched), the status output wasn't colored, even though color.ui
> > > was set. Only when setting color.status it worked.
> > 
> > My first reaction was:
> > 
> > 	When the editor does get launched, what would the new code do with
> > 	your patch?  Would we see bunch of escape codes in the editor now?

Of course I tested this case :)

> > But we do disable color explicitly when we generate contents to feed the
> > editor in that case since bc5d248 (builtin-commit: do not color status
> > output shown in the message template, 2007-11-18), so that fear is
> > unfounded.
> 
> I had the same reaction, so I would like to see this reasoning in the 
> commit message.

wt_status_use_color could have already been set during git_config()
without this patch, just not with color.ui, but color.status, so this is
not really a new case. But I can understand the reaction and don't have
ocjections against this explanation in the commit message.

Markus
