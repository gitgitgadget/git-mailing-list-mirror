From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 10/18] git notes merge: Handle real,
 non-conflicting notes merges
Date: Thu, 30 Sep 2010 01:25:29 +0200
Message-ID: <201009300125.30301.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-11-git-send-email-johan@herland.net>
 <AANLkTingYp89fY9QxzmdJgF587C29cArxyBU--QcBY5G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 01:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P161q-0006MJ-EJ
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 01:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab0I2XZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 19:25:33 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59348 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab0I2XZd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 19:25:33 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9J00E4A7QJAL80@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Sep 2010 01:25:31 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 4368A1798F95_CA3CAEBB	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 23:25:31 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 319D41797304_CA3CAEBF	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 23:25:31 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9J009047QJTU10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 30 Sep 2010 01:25:31 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.1; x86_64; ; )
In-reply-to: <AANLkTingYp89fY9QxzmdJgF587C29cArxyBU--QcBY5G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157620>

On Wednesday 29 September 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
> On Wed, Sep 29, 2010 at 00:23, Johan Herland <johan@herland.net> wrot=
e:
> > +       o.commit_msg =3D msg.buf + 7; // skip "notes: " prefix
>=20
> Don't use C99 comments.

Thanks. Fix will be in the next iteration.

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
