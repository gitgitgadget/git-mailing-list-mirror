From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Code Formatting vs Trailing Whitespaces
Date: Mon, 23 Jun 2008 22:31:38 +0200
Message-ID: <200806232231.38391.robin.rosenberg.lists@dewire.com>
References: <485FE856.1080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Florian =?iso-8859-1?q?K=F6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:36:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsm8-00025j-N0
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbYFWUfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 16:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYFWUfg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:35:36 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:47278 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbYFWUff convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 16:35:35 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 04CFD38086; Mon, 23 Jun 2008 22:35:34 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id D36D737E4C; Mon, 23 Jun 2008 22:35:33 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 6161E37E48;
	Mon, 23 Jun 2008 22:35:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <485FE856.1080808@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85920>

m=E5ndagen den 23 juni 2008 20.15.50 skrev Florian K=F6berle:
> Hi
>=20
> I noticed that Robin removed trailing whitespaces from my patch(thank=
s).
> It appears that if you enable code formatting and the removement of
> trailing whitespaces in the save actions option that the formatting
> option will win.
> It will add a space at the second line of a javadoc comment:
> /**
> ~ * <----
>=20
> I think this is a bug in eclipse, did any of you create a bug report =
for
> that? Or a feature request for an "no whitespace after javadoc" optio=
n
> in the code formatter page?

This one matches: https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D49619

> I want to have both options active, because I don't want to commit wr=
ong
> formatted patches.

When I have both options active, it adds the whitespace when formatting=
, but
removes it when saving in (version 3.3.2).

-- robin
