From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 2 Mar 2009 22:21:09 +0100
Message-ID: <200903022221.10254.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <200903022058.33392.robin.rosenberg.lists@dewire.com>  <alpine.DEB.2.00.0903022146510.20047@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 02 22:26:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeFeR-0002JS-5a
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 22:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbZCBVYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 16:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbZCBVYo
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 16:24:44 -0500
Received: from mail.dewire.com ([83.140.172.130]:5234 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZCBVYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 16:24:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BF1471484142;
	Mon,  2 Mar 2009 22:24:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0jEn6+I4DPXp; Mon,  2 Mar 2009 22:24:39 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B73C7147EAC1;
	Mon,  2 Mar 2009 22:24:38 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <alpine.DEB.2.00.0903022146510.20047@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111965>

m=E5ndag 02 mars 2009 21:52:41 skrev Peter Krefting <peter@softwolves.p=
p.se>:
> Robin Rosenberg:
>=20
> > I'd be almost happy with a solution that works when people are inte=
racting=20
> > using the subset that is convertible between the character sets in =
use.
>=20
> You mean like the "invariant" character set? :-) Using Unicode intern=
ally=20
> (in whatever encoding) is nice, the problem is when you have to inter=
act=20
> with the world around you.

Not sure what that is. I mean that in a local nordic, setting people ca=
n use iso-8859-1|15/windows-1252/UTF-8 for their needs be means of conv=
erting the characters as-needed without loss, with very few practial re=
strictions.=20

=46or a larger setting that won't do, but then the need is typically le=
ss since people tend to use ASCII only, or you jump to all unicode.

Just because I use UTF-8 doesn't mean I use start using more characters=
 in practice.

-- robin
