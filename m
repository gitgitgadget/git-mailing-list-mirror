From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Fixed trivial warnings. Mainly parametrized raw types,   added serialVersionUID, removed unnecessery throws.
Date: Tue, 6 Jan 2009 01:54:55 +0100
Message-ID: <200901060154.55865.robin.rosenberg.lists@dewire.com>
References: <gjrcni$9q$1@ger.gmane.org> <gjrgip$al9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Vasyl' Vavrychuk" <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 01:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK0F6-0004Rb-MQ
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 01:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbZAFAzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jan 2009 19:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbZAFAzA
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 19:55:00 -0500
Received: from mail.dewire.com ([83.140.172.130]:3815 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbZAFAzA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 19:55:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4D1021484F5F;
	Tue,  6 Jan 2009 01:54:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcodVyTUYAXD; Tue,  6 Jan 2009 01:54:56 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B68F71484F58;
	Tue,  6 Jan 2009 01:54:56 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <gjrgip$al9$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104611>

m=E5ndag 05 januari 2009 00:26:02 skrev Vasyl' Vavrychuk:
> Not sure what is right:
> public abstract class AnyObjectId implements Comparable<ObjectId> {
> or
> public abstract class AnyObjectId implements Comparable<AnyObjectId> =
{
>=20
> IMHO second, but class AnyObjectId contains some compareTo(ObjectId).
>=20
> Also not sure if this bunch of changes is complete enough. Maybe it's=
 better to make more fixes in this direction and then commit.

I broke up the patch and applied it just to be nice, with the exception=
 of this change.

-- robin
