From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: importing mercurial patch
Date: Tue, 11 Nov 2008 13:00:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811111258260.30769@pacific.mpi-cbg.de>
References: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:55:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzrqK-0000lh-12
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403AbYKKLxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 06:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYKKLxL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 06:53:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50553 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755331AbYKKLxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 06:53:10 -0500
Received: (qmail invoked by alias); 11 Nov 2008 11:53:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 11 Nov 2008 12:53:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19o9UJHU0towXBiWwR53iyfmP92/+gJ09hmHSYWrh
	V2KdaT5o0u9nGT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100642>

Hi,

On Tue, 11 Nov 2008, Ondrej Certik wrote:

> I'd like git to be able to import mercurial-exported patches.

Have you seen

	http://repo.or.cz/w/fast-export.git/

?

I had many problems with it, so many that I started to write my own 
hg-fast-export together with Dirkjan Ochtman, a very nice Mercurial guy 
(actually, he started writing it, and I tried to fix it, but it still does 
not work due to merge mishandling).

But then I saw that finally, they started work on it again.  It is 
somewhat sloppy, having a large part in Python and a large part in shell, 
which could have been avoided, but at least it works.

Ciao,
Dscho
