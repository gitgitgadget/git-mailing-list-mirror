From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 16:56:35 +0100
Message-ID: <200811101656.35887.robin.rosenberg@dewire.com>
References: <200811101522.13558.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 16:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzZ9G-0007XV-1s
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 16:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYKJP4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 10:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYKJP4j
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 10:56:39 -0500
Received: from mail.dewire.com ([83.140.172.130]:10154 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbYKJP4j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 10:56:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 75C6F147D0C5;
	Mon, 10 Nov 2008 16:56:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XTPtY08FTae; Mon, 10 Nov 2008 16:56:36 +0100 (CET)
Received: from sleipner.localnet (sleipner.dewire.com [10.1.2.197])
	by dewire.com (Postfix) with ESMTP id C18828026F0;
	Mon, 10 Nov 2008 16:56:36 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <200811101522.13558.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100527>

m=E5ndag 10 november 2008 15:22:13 skrev Francis Galiegue:
> Hello,
>=20
> A very nice git feature, without even going as far as merges, is the =
cherry=20
> pick feature.
>=20
> For this to be doable from within the Eclipse Git plugin, a diff/patc=
h=20
> implementation needs to be found, in a license compatible with the cu=
rrent=20
> JGit license (3-clause BSD, as far as I can tell). Or a new implement=
ation=20
> can be rewritten from scratch, of course.
>=20
> I found this:
>=20
> http://code.google.com/p/google-diff-match-patch
>=20
> Its license is the Apache 2.0 license. It implements the same algorit=
hm than=20
> git's internal diff engine ("An O(ND) Difference Algorithm and its=20
> Variations", by Eugene Myers), and as far as I can tell so far (IANAL=
, far=20
> from it), it is compatible with JGit's current license.
>=20
> Could this be a viable candidate?

Our approach was to do just that, for the very reasons you mention.=20
I'll have a look. Thanks for doing some research for us. That project w=
as
unknown to me..

-- robin
