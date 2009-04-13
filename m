From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] archive: do not read .gitattributes in working
        directory
Date: Mon, 13 Apr 2009 15:08:05 +0200
Message-ID: <49E33935.5090203@lsrfire.ath.cx>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com> 	<1239260490-6318-2-git-send-email-pclouds@gmail.com> <1239260490-6318-3-git-send-email-pclouds@gmail.com> 	<1239260490-6318-4-git-send-email-pclouds@gmail.com> <7vws9u2ov4.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0904090353s4ec770bfk3cd3f6559c367a20@mail.gmail.com> <49E316CD.7030001@lsrfire.ath.cx> <49E32D9F.2050906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 15:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtLv7-0008W8-J8
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 15:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbZDMNIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 09:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZDMNIU
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 09:08:20 -0400
Received: from india601.server4you.de ([85.25.151.105]:59689 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZDMNIU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 09:08:20 -0400
Received: from [10.0.1.101] (p57B7FFE1.dip.t-dialin.net [87.183.255.225])
	by india601.server4you.de (Postfix) with ESMTPSA id AB3DD2F8056;
	Mon, 13 Apr 2009 15:08:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <49E32D9F.2050906@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116437>

Ren=C3=A9 Scharfe schrieb:
>> I
>> think it makes sense to create a separate script for the new tests a=
nd
>> eventually move the existing archive attribute tests there.
>=20
> Something like this?

I forgot to add tests against bare repositories.  Otherwise I'd noticed
earlier that read_attr() is only called for non-bare repositories
currently, i.e. your patches won't allow reading of .gitattribute files
from the tree in bare repos.

Ren=C3=A9
