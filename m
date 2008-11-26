From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 01:14:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 01:07:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L57wY-0001tP-I1
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 01:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYKZAGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 19:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYKZAGa
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 19:06:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:32812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750998AbYKZAGa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 19:06:30 -0500
Received: (qmail invoked by alias); 26 Nov 2008 00:06:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 26 Nov 2008 01:06:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zcOBdswlz6D6BXaHV6c3UzlDm8UWDi+zuZIOY5h
	24kQycv/SVKBho
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101697>

Hi,

On Tue, 25 Nov 2008, Ondrej Certik wrote:

> I would like to export our whole git repository to patches, and then 
> reconstruct it again from scratch. Following the man page of "git 
> fast-export":
>
> [...] 
> 
> However, the repository is very different to the original one. It 
> contains only 191 patches:

Can you try again with a Git version that contains the commit 
2075ffb5(fast-export: use an unsorted string list for extra_refs)?

Ciao,
Dscho
