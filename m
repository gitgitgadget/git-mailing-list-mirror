From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Fix invalid menubar and toolbar entries in plugin.xml
Date: Thu, 14 Aug 2008 07:47:35 +0200
Message-ID: <200808140747.35753.robin.rosenberg.lists@dewire.com>
References: <48A3310A.8080306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTViW-0005az-G9
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYHNFsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 01:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYHNFsq
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:48:46 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:51938 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbYHNFsp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 01:48:45 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 3A8EE38329; Thu, 14 Aug 2008 07:48:44 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 0989237EAB; Thu, 14 Aug 2008 07:48:44 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id C716737E47;
	Thu, 14 Aug 2008 07:48:41 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48A3310A.8080306@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92323>

onsdagen den 13 augusti 2008 21.07.54 skrev Tor Arne Vestb=F8:
> The default toolbar is identified by the path 'Normal',
> and we use the default group, named by 'additions'.
>=20
> The menu entry was not used, and was causing an extra
> empty space in the menu bar.

So that's why. Thanks.=20

Please try to prefix the patch with EGIT (or JGIT for JGit-only patches=
)
so we won't waste the time of those on the list having no interesting i=
n this implementation.
I forgot it a few times myself.

-- robin
