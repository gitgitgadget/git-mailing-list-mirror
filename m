From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] Remove duplication in t9119-git-svn-info.sh
Date: Tue, 1 Jan 2008 19:54:32 -0800 (PST)
Message-ID: <526767.57295.qm@web52401.mail.re2.yahoo.com>
References: <20080102034317.GB11711@untitled>
Reply-To: ddkilzer@kilzer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 04:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9uh4-0001XB-To
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 04:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbYABDyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 22:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbYABDyg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 22:54:36 -0500
Received: from web52401.mail.re2.yahoo.com ([206.190.48.164]:31949 "HELO
	web52401.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754390AbYABDyf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2008 22:54:35 -0500
Received: (qmail 57401 invoked by uid 60001); 2 Jan 2008 03:54:32 -0000
X-YMail-OSG: 0BSyms4VM1lQRkthPjJMzr1gvYlGFr6ChI8grDkotL.1iXWSa4oZPDU.LKEQB1Azde7jLSCt1TwK.BIxkoFrTYI9qlxr3ykv3ou2aRf6Pprz6ujXn7ifcAPujx2nEZlOnYBitdti9oMfJIamwRuKMA--
Received: from [24.7.124.164] by web52401.mail.re2.yahoo.com via HTTP; Tue, 01 Jan 2008 19:54:32 PST
X-RocketYMMF: ddkilzer
In-Reply-To: <20080102034317.GB11711@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69453>

Eric Wong <normalperson@yhbt.net> wrote:

> Not reading Junio's mind, I think he meant that you were swapping the
> "gitwc/" and "svnwc/" args everywhere in your changeset.

I did not switch them everywhere.  The original patch to fix the race condition
required switching the arguments because I had to treat the svnwc path
differently than the gitwc path.

> Nevertheless, does your change make things work with older
> versions of SVN?  I'm running 1.4.x everywhere these days, but
> I seem to recall the version of SVN on kernel.org was giving
> Junio trouble with the tests.

Was it the "race condition" he was seeing, where the tests were failing because
of a difference in one second between the svn output and the git output?  If
so, that was fixed with the first patch.  I was able to reproduce the race
condition locally with svn-1.4.5 on my PowerBook G4.

I don't have an easy way to test with svn-1.3.

Dave
