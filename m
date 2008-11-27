From: Simon Hausmann <simon@lst.de>
Subject: Re: git fsck segmentation fault
Date: Thu, 27 Nov 2008 20:10:20 +0100
Message-ID: <200811272010.20891.simon@lst.de>
References: <200811271814.06941.simon@lst.de> <alpine.LFD.2.00.0811271243250.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 20:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5mHA-0005e5-MJ
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 20:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbYK0TK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 14:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbYK0TK2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 14:10:28 -0500
Received: from hoat.troll.no ([62.70.27.150]:58256 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbYK0TK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 14:10:27 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 4535620C2A;
	Thu, 27 Nov 2008 20:10:22 +0100 (CET)
Received: from rani.localnet (unknown [172.20.1.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2AA5220A95;
	Thu, 27 Nov 2008 20:10:22 +0100 (CET)
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; i686; ; )
In-Reply-To: <alpine.LFD.2.00.0811271243250.14328@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101821>

On Thursday 27 November 2008 18:47:41 Nicolas Pitre wrote:
> On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > Hi,
> >
> > when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a medium
> > sized
>
> That version doesn't exist in the git repo.

Ah, oops, it was a merge commit, corresponding to maint as of 5aa3bd.

> > (930M) repository I get a segfault.
> >
> > The backtrace indicates an infinite recursion. Here's the output from the
> > last few lines:
>
> [...]
>
> Could you try with latest master branch please?  It is more robust
> against some kind of pack corruptions that could send the code into
> infinite loops.

Same problem with git version 1.6.0.4.790.gaa14a

:-/

Simon
