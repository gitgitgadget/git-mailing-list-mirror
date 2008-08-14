From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Fix invalid menubar and toolbar entries in plugin.xml
Date: Thu, 14 Aug 2008 19:42:55 +0200
Message-ID: <200808141942.55448.robin.rosenberg.lists@dewire.com>
References: <48A3310A.8080306@gmail.com> <200808140747.35753.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgso-0005Ys-NJ
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbYHNRoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 13:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbYHNRoH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:44:07 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:43697 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbYHNRoG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 13:44:06 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 509B2383A0; Thu, 14 Aug 2008 19:44:04 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 22F8438390; Thu, 14 Aug 2008 19:44:04 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id C450537E47;
	Thu, 14 Aug 2008 19:44:03 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200808140747.35753.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92378>

torsdagen den 14 augusti 2008 07.47.35 skrev Robin Rosenberg:
> onsdagen den 13 augusti 2008 21.07.54 skrev Tor Arne Vestb=F8:
> > The default toolbar is identified by the path 'Normal',
> > and we use the default group, named by 'additions'.
> >=20
> > The menu entry was not used, and was causing an extra
> > empty space in the menu bar.
>=20
> So that's why. Thanks.=20
>=20
> Please try to prefix the patch with EGIT (or JGIT for JGit-only patch=
es)
> so we won't waste the time of those on the list having no interesting=
 in this implementation.

When I applied this patch the Git menu disappeared. (3.3)

-- robin
