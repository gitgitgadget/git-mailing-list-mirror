From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Show diff when double-clicking on file in commit dialog
Date: Sun, 8 Mar 2009 22:59:35 +0100
Message-ID: <200903082259.35886.robin.rosenberg.lists@dewire.com>
References: <49B4260D.6070501@nibor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Stocker <robin@nibor.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 23:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgR4p-0005d3-Cc
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 23:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbZCHV7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 17:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbZCHV7q
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:59:46 -0400
Received: from mail.dewire.com ([83.140.172.130]:29384 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbZCHV7p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 17:59:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8283815E0DEA;
	Sun,  8 Mar 2009 22:59:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64ilP0YmhuWg; Sun,  8 Mar 2009 22:59:38 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id BF0F315E0DE0;
	Sun,  8 Mar 2009 22:59:38 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49B4260D.6070501@nibor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112651>

s=C3=B6ndag 08 mars 2009 21:09:49 skrev Robin Stocker <robin@nibor.org>=
:
> It only compares the index version to the working tree version for no=
w.
> So if the file was already added to the index, the diff is empty. Wha=
t
> it should show is the diff that will be in the commit.
>=20
> Signed-off-by: Robin Stocker <robin@nibor.org>
> ---
>=20
> Hi,
>=20
> An essential feature I miss in EGit at the moment (apart from the
> synchronize view [1]) is seeing what changes one is about to commit. =
In
> the Subclipse SVN plugin one can double-click a file in the commit
> dialog and the diff is shown.
Hi, Robin. I miss that too!

> This patch is a first step for adding this to EGit. It only compares =
the
> index version to the working tree version as I couldn't figure out an
> easy way to get the HEAD version.
You can look at how GitDocument does it.

>=20
> It's more a proof of concept than a final patch. What do you think?

I've started on an version with the diff integrated into the same dialo=
g, for
some reasons it's not done yet, but we might takes this meanwhile unles=
s
I complete the dialog real quick, as this is really useful, provided we=
 compare
with HEAD.

-- robin
