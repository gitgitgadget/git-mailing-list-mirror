From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-clone not fetching all tags?
Date: Sun, 30 Apr 2006 00:11:14 +0200
Message-ID: <20060429221114.557FC35288F@atlas.denx.de>
References: <200604292342.16306.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 30 00:11:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZxes-0007ln-Ry
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWD2WLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 29 Apr 2006 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWD2WLQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 18:11:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40615 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1750817AbWD2WLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 18:11:15 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D1C5171DEB;
	Sun, 30 Apr 2006 00:11:14 +0200 (CEST)
X-Auth-Info: jSXTL5UV+WJ+PjKZtfjClHjy4WqN4BprLY9DLU2Gfvc=
X-Auth-Info: jSXTL5UV+WJ+PjKZtfjClHjy4WqN4BprLY9DLU2Gfvc=
X-Auth-Info: jSXTL5UV+WJ+PjKZtfjClHjy4WqN4BprLY9DLU2Gfvc=
Received: from mail.denx.de (p54966E7A.dip.t-dialin.net [84.150.110.122])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id BCC9F91A88;
	Sun, 30 Apr 2006 00:11:14 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 65A7E6D0112;
	Sun, 30 Apr 2006 00:11:14 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 557FC35288F;
	Sun, 30 Apr 2006 00:11:14 +0200 (MEST)
To: Johannes Sixt <johannes.sixt@telecom.at>
In-reply-to: Your message of "Sat, 29 Apr 2006 23:42:16 +0200."
             <200604292342.16306.johannes.sixt@telecom.at> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19322>

In message <200604292342.16306.johannes.sixt@telecom.at> you wrote:
>
> There are two types of tags: They can point to
> 1. a commit object
> 2. a proper tag object (which in turn references the commit)
>=20
> git-update-server-info seems to generate info only for case 2, and so=
 are the=20
> only ones that http can fetch.

And git-cvsimport (at least older versions of it)  imports  CVS  tags
only as type 1 ?

That would perfectly explain the situation. How can this be fixed?

Best regards,
Viele Gr=FC=DFe,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There is a multi-legged creature crawling on your shoulder.
	-- Spock, "A Taste of Armageddon", stardate 3193.9
