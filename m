From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Fri, 29 Feb 2008 22:03:56 +0100
Message-ID: <200802292203.56899.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200802282140.30654.johannes.sixt@telecom.at> <alpine.LSU.1.00.0802290105150.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 22:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCPQ-0000iI-4i
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933807AbYB2VD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933796AbYB2VD7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:03:59 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:52126 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933790AbYB2VD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:03:58 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 5096910AC39;
	Fri, 29 Feb 2008 22:03:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1B4D556E3B;
	Fri, 29 Feb 2008 22:03:57 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802290105150.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75562>

On Friday 29 February 2008 02:07, Johannes Schindelin wrote:
> On Thu, 28 Feb 2008, Johannes Sixt wrote:
> > I thought about this, but I decided against it:  git-compat-util.h is
> > the place to look for compatibility functions. A file compat/mingw.h
> > only introduces an extra indirection and only *hides* stuff instead of
> > making it obvious.
>
> Well, the thing is, there are quite a few definitions and declarations
> that are _only_ _ever_ interesting if you are on MinGW32.
>
> So maybe it is a good idea to hide it to all the other users.

You get compat/mingw.h, but you don't get a zillion NO_<insert feature here>. 
The two are pretty much exclusive anyway. Deal?

-- Hannes
