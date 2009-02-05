From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: revert committed and pushed tag
Date: Thu, 05 Feb 2009 09:02:33 +0100
Message-ID: <498A9D19.7070902@cetrtapot.si>
References: <4988586D.603@cetrtapot.si> <706b4240902031417p1a98f3fdtb2240ea5ae5b31a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matt Pearson <404emailnotfound@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzEA-0000q7-VG
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbZBEIDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 03:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbZBEIDY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:03:24 -0500
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:57252 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbZBEIDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:03:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 48C7A19FA2D;
	Thu,  5 Feb 2009 09:03:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra-mta.cetrtapot.si
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8blbl8U-CQQf; Thu,  5 Feb 2009 09:03:21 +0100 (CET)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id CF57419FA20;
	Thu,  5 Feb 2009 09:03:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <706b4240902031417p1a98f3fdtb2240ea5ae5b31a5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108522>

Matt Pearson wrote:
> 2009/2/3 Hinko Kocevar <hinko.kocevar@cetrtapot.si>:
>> Hi,
>>
>> Is there a way to 'revert' committed and pushed tag?
>> I've noticed that some files were not included in the commit (new fi=
les)
>> and I would like to squeeze them in before the tag was
>> created/committed/pushed to the remote server.
>=20
> You do it the same way you delete a branch (see git-push(1)):
> git push origin :refs/tags/rc3
>=20
> Note that anybody that has fetched from your public repository will
> _not_ have their current 'rc3' tag overwritten with the new version
> without them deleting it first and letting fetch recreate it.
>=20

Thank you, that worked just the way I wanted!

Regards,
Hinko

--=20
Hinko Ko=C4=8Devar, OSS developer
=C4=8CETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si
