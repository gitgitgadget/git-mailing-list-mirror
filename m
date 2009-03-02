From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone: Add option --branch to override initial
 branch
Date: Tue, 3 Mar 2009 00:48:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
References: <1236031882-2052-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1482237083-1236037737=:10279"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeHsc-0005jy-Si
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 00:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbZCBXrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbZCBXrf
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 18:47:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:37551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752787AbZCBXre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 18:47:34 -0500
Received: (qmail invoked by alias); 02 Mar 2009 23:47:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 03 Mar 2009 00:47:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EHTQkTlmEmQEn/pIHgVdaUpRzKjLOCnVMIJfSqH
	69D9/zIJT80IXA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1236031882-2052-1-git-send-email-torarnv@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111978>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1482237083-1236037737=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 2 Mar 2009, Tor Arne Vestbø wrote:

> The options --branch and -b allow the user to override the initial 
> branch created and checked out by git-clone. Normally this is the active 
> branch of the remote repository, which is also the fallback if the 
> selected branch is not found.

I do not think that falling back if the selected branch is not found is a 
wise choice.

Besides, the common way to check out something different than the remote's 
HEAD is like this:

	$ git clone -n $URL
	$ cd $DIR
	$ git checkout -t origin/$BRANCH

I am undecided if that is good enough, or your patch is needed.

Ciao,
Dscho

--8323328-1482237083-1236037737=:10279--
