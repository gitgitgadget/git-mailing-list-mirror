From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_merging_unmanaged_working_tree?=
Date: Mon, 15 Mar 2010 13:34:52 +0100
Message-ID: <46a29168.6d880e7c.4b9e296c.483a1@o2.pl>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	=?UTF-8?Q?=C5=81ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>
X-From: git-owner@vger.kernel.org Mon Mar 15 13:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr9WJ-0003gG-BE
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 13:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729Ab0COMfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 08:35:38 -0400
Received: from tur.go2.pl ([193.17.41.50]:58174 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab0COMfi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 08:35:38 -0400
Received: from mailout1.go2.pl (mailout1.go2.pl [193.17.41.11])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 70CE7230A77
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 13:35:36 +0100 (CET)
Received: from mailout1.go2.pl (unknown [10.0.0.104])
	by mailout1.go2.pl (Postfix) with ESMTP id 6BAFF3003B;
	Mon, 15 Mar 2010 13:34:53 +0100 (CET)
Received: from o2.pl (unknown [10.0.0.76])
	by mailout1.go2.pl (Postfix) with SMTP;
	Mon, 15 Mar 2010 13:34:53 +0100 (CET)
In-Reply-To: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142207>

> Hello.
>=20
> Is there a method to (dry?) run git-merge to detect conflicts
> on:
>=20
> * current HEAD (or working tree)
> * selected previous revision (the one used to "branch")
> * directory tree (or a single file) "branched" with git-archive
>=20
> I'd like to synchronize portable working tree but don't want to keep
> history in it.
>=20
> --=20
> Mi=C5=82ego dnia,
> =C5=81ukasz Stelmach
> --

Does "git-merge --squash" do what you want? You still need to have
the other tree managed by git (even for a while).

--=20
Daniel
