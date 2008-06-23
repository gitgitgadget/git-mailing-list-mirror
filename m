From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT RFC PATCH] Add a stdio prompt for SSH connection information.
Date: Mon, 23 Jun 2008 08:23:20 +0200
Message-ID: <200806230823.20534.robin.rosenberg.lists@dewire.com>
References: <200806222306.25434.robin.rosenberg.lists@dewire.com> <20080622231355.GH11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 08:28:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAfXc-0003eM-Vc
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 08:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbYFWG1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 02:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYFWG1S
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 02:27:18 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:59270 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYFWG1Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 02:27:16 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E50D338287; Mon, 23 Jun 2008 08:16:12 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id BB227381F4; Mon, 23 Jun 2008 08:16:12 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id D8E2037E48;
	Mon, 23 Jun 2008 08:27:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080622231355.GH11793@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85836>

m=C3=A5ndagen den 23 juni 2008 01.13.55 skrev Shawn O. Pearce:
> I think that services on Windows have no console, and also can't
> talk to the desktop UI, so its both headless and without a console.

On Windows a service in Java throws up dialogs in void. Your programs w=
ill just hang. You have to tell awt that you are headless or your servi=
ces may just hang. There is an option on services that makes it show wi=
ndows on the console, but it's not the default and seems to have no eff=
ect on the headless property. As for the console() returning null or no=
t I haven't tried it yet.

> > I'm also a little unsure about how to invoke the promptKeyboardInte=
ractive method.
>=20
> I think you implemented this method correctly.  Its a confusing API,
> but it does seem to make sense.

No idea on how to make JSch inoke it?

-- robin
