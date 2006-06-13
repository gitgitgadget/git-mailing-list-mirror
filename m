From: Sean <seanlkml@sympatico.ca>
Subject: Re: Problem upgrading to 1.4.0
Date: Mon, 12 Jun 2006 22:48:18 -0400
Message-ID: <BAYC1-PASMTP057F6CD43B793C898A6952AE8C0@CEZ.ICE>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
	<7v1wtwh246.fsf@assigned-by-dhcp.cox.net>
	<1150165982.4297.88.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 13 04:49:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpyyF-0001Mk-Rm
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 04:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWFMCtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 22:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWFMCtd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 22:49:33 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:10130 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932796AbWFMCtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 22:49:32 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Jun 2006 19:49:31 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 184D2644C2A;
	Mon, 12 Jun 2006 22:49:30 -0400 (EDT)
To: Pavel Roskin <proski@gnu.org>
Message-Id: <20060612224818.383b13ee.seanlkml@sympatico.ca>
In-Reply-To: <1150165982.4297.88.camel@dv>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jun 2006 02:49:31.0427 (UTC) FILETIME=[FEE31730:01C68E93]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Jun 2006 22:33:02 -0400
Pavel Roskin <proski@gnu.org> wrote:

> And while at that, it would be great to download and keep the list of
> the remote branches, perhaps when requested with a special switch.  It
> doesn't mean that all of the branches should be fetched, but it would be
> nice to have a list of the available remove branches somewhere.
> 
> As it stands now, this functionality is implemented in git-clone, which
> it probably not the best place.  Users should not be forced to clone the
> directory again to find out which branches are available.

Hi Pavel,

You can get a list of the remote branches whenever you want:

$ git ls-remote -h <remote>

So, to see available branches in the repo from which you initially
cloned:

$ git ls-remote -h origin

Or to see which branches are available in the official cogito repo,
without ever cloning it:

$ git ls-remote -h git://git.kernel.org/pub/scm/cogito/cogito.git

HTH,
Sean
