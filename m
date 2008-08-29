From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow 'git cmd -h' outside of repository
Date: Fri, 29 Aug 2008 13:35:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808291333010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1219958917-22780-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-255406520-1220009707=:24820"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 13:31:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ2Bv-0002Eb-MK
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 13:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbYH2L3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 07:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYH2L3x
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 07:29:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:60746 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753262AbYH2L3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 07:29:52 -0400
Received: (qmail invoked by alias); 29 Aug 2008 11:29:51 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 29 Aug 2008 13:29:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DfuUCmmhD1vqYeVGmVm9KqhnrsvgZXNujLC2YPE
	iNDpWtWtU/Rdl3
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1219958917-22780-1-git-send-email-szeder@ira.uka.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-255406520-1220009707=:24820
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 28 Aug 2008, SZEDER Gábor wrote:

> Printing usage strings of git commands should obviously not depend on 
> the command being run inside a git repository.  However, in case of a 
> command requiring a repository, the command line options are parsed only 
> after it is ensured that the command was started inside a repository, 
> resulting in a 'fatal: Not a git repository' if 'git cmd -h' wasn't 
> executed inside a repository.
> 
> To get around this issue, we will check early for the presence of '-h'
> option, and skip ensuring that the command is run inside a repository.

You miss the fact that "git grep -h" does not mean "show usage".  Oh, and 
"git ls-remote -h" neither.  Three times's a charm: "git show-ref -h" does 
not show the help either.

I am also not quite certain if we should not just tout "git help <cmd>" as 
the official way to request help.

Ciao,
Dscho
--8323329-255406520-1220009707=:24820--
