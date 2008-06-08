From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and unwanted .gitattributes
Date: Sun, 08 Jun 2008 17:24:42 +0200
Message-ID: <484BF9BA.30400@lsrfire.ath.cx>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com> <m33anpxn63.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 17:26:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Mma-0001oL-0t
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 17:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258AbYFHPYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 11:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYFHPYq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 11:24:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:38490 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbYFHPYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 11:24:45 -0400
Received: from [10.0.1.200] (p57B7EC0B.dip.t-dialin.net [87.183.236.11])
	by india601.server4you.de (Postfix) with ESMTPSA id 7735D2F8068;
	Sun,  8 Jun 2008 17:24:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <m33anpxn63.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84280>

Jakub Narebski schrieb:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>=20
>> Currently attr.c will read .gitattributes on disk no matter there is=
 a
>> real worktree or not.=20
>=20
> Currently .gitattributes are read _only_ from the work tree.
> There isn't even infrastructure to read .gitattributes for commit
> (from a tree); git-check-attr, and I guess also internal git API,
> deals only with in-tree .gitattribute file.

Attributes are taken from three places (in order of increasing
precedence): a table of built-in defaults, .gitattributes files in the
work tree, and the file $GIT_DIR/info/attributes.

Ren=E9
