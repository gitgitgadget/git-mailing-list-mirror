From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: A note from the interim Git maintainer
Date: Wed, 17 Oct 2007 03:13:30 -0400
Message-ID: <20071017071329.GY13801@spearce.org>
References: <20071016055448.GA13801@spearce.org> <20071017063132.GA458@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Eygene Ryabinkin <rea-git@codelabs.ru>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:14:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii36J-0005LX-6G
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbXJQHNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbXJQHNn
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:13:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60270 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbXJQHNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:13:42 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii35u-0005us-UY; Wed, 17 Oct 2007 03:13:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5CD4C20FBAE; Wed, 17 Oct 2007 03:13:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071017063132.GA458@soma>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61341>

Eric Wong <normalperson@yhbt.net> wrote:
> I've pushed out Benoit's and Eygene's latest git-svn changes to master
> on http://git.bogomips.org/git-svn.git  These changes are against
> spearce/master.
> 
> I've amended Benoit's commit messages a bit and fixed one bug in
> git svn propget (also amended).

Thanks.  I originally skipped over Benoit's changes as I hadn't see
anything from you on the subject.  But I have now cherry-picked them
from your bogomips git-svn tree into spearce/master.  Pushing it
out in a minute.
 
> Benoit Sigoure (5):
>       git-svn: add a generic tree traversal to fetch SVN properties
>       git-svn: implement git svn create-ignore
>       git-svn: add git svn propget
>       git-svn: add git svn proplist
>       git-svn: simplify the handling of fatal errors
> 
> Eygene Ryabinkin (2):
>       git-svn: respect Subversion's [auth] section configuration values
>       git-svn: use "no warnings 'once'" to disable false-positives

I apparently already had that first one from Eygene ("[auth]
section") in spearce/master; it went out last night.  Perhaps you
ran the shortlog above against Junio's tree and not mine?

The second one from Eygene ("no warnings once") I already had in
my master from the resend you had earlier made to the list with
your Ack and fixups.

-- 
Shawn.
