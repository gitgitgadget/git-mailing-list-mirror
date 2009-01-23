From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-am: Add --ignore-date option
Date: Fri, 23 Jan 2009 13:38:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901231336080.3586@pacific.mpi-cbg.de>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:39:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQLKA-0004FQ-IL
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 13:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbZAWMi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 07:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZAWMi0
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 07:38:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:52360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752035AbZAWMiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 07:38:25 -0500
Received: (qmail invoked by alias); 23 Jan 2009 12:38:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 23 Jan 2009 13:38:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ex9o0ahqeb22O7G995APy3GEUvbDIpXZAHv8rdn
	HUjN94yRB7TP/e
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090123172646.6117@nanako3.lavabit.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106876>

Hi,

[if you would have given a new mail subject to your mail, gitweb would 
 stand a chance to find it]

On Fri, 23 Jan 2009, Nanako Shiraishi wrote:

> Subject: [PATCH] git-am: Add --ignore-date option
> 
> This new option makes the command ignore the date header field recorded in
> the format-patch output.  The commits will have the timestamp when they
> are created instead.
> 
> You can work a lot in one day to accumulate many changes, but apply and
> push to the public repository only some of them at the end of the first
> day.  Then next day you can spend all your working hours reading comics or
> chatting with your coworkers, and apply your remaining patches from the
> previous day using this option to pretend that you have been working at
> the end of the day.

FWIW I have that problem in one of my workflows, and I do this:

	grep -v "^Date:" < $MBOX | git am

Of course, this assumes that none of my commit messages has the string 
"Date:" at the beginning of the line...

Ciao,
Dscho
