From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: Git push from bare repo
Date: Fri, 28 May 2010 08:59:37 -0400
Message-ID: <36AD1DE8-9E28-4373-94CF-72E88ABBB309@bjhargrave.com>
References: <3197051701046e645c8ff2ae7dca872a@ns-linux.org> <4BFF89A5.7020802@op5.se> <3529f1c81d1062a941056914c612d8c2@ns-linux.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?Q?Goran_Meki=C4=87?= <meka@ns-linux.org>
X-From: git-owner@vger.kernel.org Fri May 28 14:59:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHzAH-0003YR-BK
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 14:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab0E1M7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 08:59:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32999 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0E1M7r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 08:59:47 -0400
Received: by gwaa12 with SMTP id a12so874103gwa.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 05:59:46 -0700 (PDT)
Received: by 10.150.235.4 with SMTP id i4mr1340074ybh.356.1275051586663;
        Fri, 28 May 2010 05:59:46 -0700 (PDT)
Received: from macbookpro2.hargrave.local (125.69.205.68.cfl.res.rr.com [68.205.69.125])
        by mx.google.com with ESMTPS id w3sm19393587ybi.9.2010.05.28.05.59.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 05:59:40 -0700 (PDT)
In-Reply-To: <3529f1c81d1062a941056914c612d8c2@ns-linux.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147927>


On May 28, 2010, at 08:28 , Goran Meki=C4=87 wrote:
>    There's more then one developer and 600 is set to just one user.
> Post-receive hook is executed as developer doing push. The accounts a=
re in
> LDAP, but I can't set all their UID number to same number because it'=
s
> used
> for PAM. I was thinking about ACL. Is that even a solution? The dumb =
one
> would be cron, but I wish I avoid pushing when there's no change.
>=20

What about having a script which does the push have setuid to the owner=
 of the key. Then the post-receive hook can invoke that script which wi=
ll have access to the ssh key to do the push.
--=20

BJ
