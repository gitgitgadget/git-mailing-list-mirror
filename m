From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Tue, 26 Feb 2008 00:08:34 +0100
Message-ID: <200802260008.36360.robin.rosenberg.lists@dewire.com>
References: <47AAA254.2020008@thorn.ws> <30e4a070802250535g72b59106yb1e4478eb9b9f47a@mail.gmail.com> <46a038f90802251159j591c16c2g1e5b5aa20e9edb00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mark Levedahl" <mlevedahl@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"martin f krafft" <madduck@madduck.net>,
	"Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 00:10:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTmSn-0000UO-T1
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 00:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbYBYXJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 18:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbYBYXJt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 18:09:49 -0500
Received: from [83.140.172.130] ([83.140.172.130]:25926 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbYBYXJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 18:09:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7AB89802816;
	Tue, 26 Feb 2008 00:09:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKmTC7NW5YK2; Tue, 26 Feb 2008 00:09:44 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id AA1EA80019B;
	Tue, 26 Feb 2008 00:09:44 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <46a038f90802251159j591c16c2g1e5b5aa20e9edb00@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75085>

m=E5ndagen den 25 februari 2008 skrev Martin Langhoff:
> On Tue, Feb 26, 2008 at 2:35 AM, Mark Levedahl <mlevedahl@gmail.com> =
wrote:
> >  2) Perform a screen geometry check at load time to see if the corn=
ers
> >  of the main window would be visible before applying the main windo=
w
> >  geometry.
>=20
> As a multi-screen-layouts, multi-machine user, this approach has my
> vote. I see a proto-patch from Edgar too. Even if the wm has similar
> capabilities, those will be limited to main window geometry, not
> inner-panel geometry so this is still useful.

The annoying part is that it remembers the position. Remembering siz
I can live with, but I don't want it popping up the wrong screen.

-- robin
