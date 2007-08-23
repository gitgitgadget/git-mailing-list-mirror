From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Thu, 23 Aug 2007 22:32:46 +0200
Message-ID: <20070823203246.GB3516@steel.home>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJMK-0001xX-OG
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbXHWUct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758743AbXHWUct
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:32:49 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:37906 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271AbXHWUcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:32:48 -0400
Received: from tigra.home (Faaab.f.strato-dslnet.de [195.4.170.171])
	by post.webmailer.de (klopstock mo22) (RZmta 10.3)
	with ESMTP id R0628fj7NISXyw ; Thu, 23 Aug 2007 22:32:47 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CD9C2277BD;
	Thu, 23 Aug 2007 22:32:46 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3EFA6BE01; Thu, 23 Aug 2007 22:32:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCoDQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56526>

V=E4in=F6 J=E4rvel=E4, Thu, Aug 23, 2007 21:58:31 +0200:
> With this flag, the user can choose to filter untracked files from th=
e
> status output. This can be used to either speed up the status output,=
 as
> the untracked files are not fetched at all, or to just cleanup the
> output without using gitignore.

"git diff -r --name-status; git diff --cached -r --name-status" is not =
enough?
