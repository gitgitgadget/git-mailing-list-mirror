From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] setup_git_directory: Setup cwd properly if worktree is
 found
Date: Tue, 27 Nov 2007 14:46:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271446080.27959@racer.site>
References: <20071112112408.GA5420@laptop>  <Pine.LNX.4.64.0711121139010.4362@racer.site>
  <fcaeb9bf0711120413w180c07e1qbf1b186753593d7@mail.gmail.com> 
 <Pine.LNX.4.64.0711121224430.4362@racer.site>
 <fcaeb9bf0711270612p52ce20eaue39eac1d529c3fd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1iM-0001aO-Ko
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbXK0Oqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbXK0Oqs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:46:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:50223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753113AbXK0Oqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:46:47 -0500
Received: (qmail invoked by alias); 27 Nov 2007 14:46:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 27 Nov 2007 15:46:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+J3kESePuJ4rLYZ1C4uWxmMN4ajvTkHKFVuMt/8p
	JTBqEZ70aDGnyK
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711270612p52ce20eaue39eac1d529c3fd3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66220>

Hi,

On Tue, 27 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> Question time. setup_git_directory_gently() can be happy even if there 
> is no repository. Now if we move version check into setup_..._gently and 
> it finds git program is too old to handle the repository, what would we 
> do? die() like in check_repository_format() or tell the caller there is 
> no repository?

In the interest of least surprise, die().

Ciao,
Dscho
 
