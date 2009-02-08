From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 15:34:20 +0100
Message-ID: <200902081534.20854.robin.rosenberg.lists@dewire.com>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 15:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWAlF-0004Ul-GR
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 15:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbZBHOe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 09:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZBHOe0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 09:34:26 -0500
Received: from mail.dewire.com ([83.140.172.130]:18448 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbZBHOe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 09:34:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 21BE0147E89B;
	Sun,  8 Feb 2009 15:34:24 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9E1TtrZ8Eau; Sun,  8 Feb 2009 15:34:22 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id CF929147E89A;
	Sun,  8 Feb 2009 15:34:22 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <200902080347.25970.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108977>

s=F6ndag 08 februari 2009 03:47:25 skrev Robin Rosenberg:
>=20
> I've seen this. Running git gc on Windows, while having Elipse open c=
an kill your
> object database.=20
>=20
> Eclipse keeps the pack files open most of the time. Then you=20
> launch git gui which recommends the user to do a git gc. I never
> do (it *always* wants to do this), so I haven't encountered the=20
> issue, but if gc doesn't find a new optimal pack it tries to rewrite =
a=20
> new pack with the same id. So it rm's the idx file (fine) and the the
> pack file (not ok) and gives up, which means it has a .pack file with=
=20
> no index, so it cannot use it. Trying git gc again after eclipse exit=
s=20
> will execute the final stab on your objects.=20
>=20
> The underlying bug is ofcource that Windows locks files when
> they are open. A *nix* user does not suffer from this problem.
>=20
> I'll investigate more at some other time. This is a preliminary
> analysis.

A receipe for triggering is available at http://code.google.com/p/msysg=
it/issues/detail?id=3D189

-- robin
