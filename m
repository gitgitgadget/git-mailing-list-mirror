From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] contrib/difftool: use a separate config namespace for difftool commands
Date: Tue, 17 Mar 2009 20:54:45 +0100
Message-ID: <200903172054.46063.markus.heidelberg@web.de>
References: <1236589956-13486-1-git-send-email-davvid@gmail.com> <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com> <20090310070122.GB4523@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 20:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjfOK-0006vM-TC
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 20:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZCQTyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZCQTyb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 15:54:31 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46702 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZCQTya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 15:54:30 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id F3E02FBC222D;
	Tue, 17 Mar 2009 20:54:28 +0100 (CET)
Received: from [89.59.119.57] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LjfMq-0006cU-00; Tue, 17 Mar 2009 20:54:28 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090310070122.GB4523@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19htHfWpPv1rnGp4SeJwOVmsr4Gvxh7GOyD/i8A
	fpRCqUNZkg25RgcrF9g/QYM6XIBf9v2HBFOnZfhb+1d/pLUehI
	oJ8Kl3GJ57ynVrDv0Nuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113521>

David Aguilar, 10.03.2009:
> On  0, Jay Soffian <jaysoffian@gmail.com> wrote:
> > On Mon, Mar 9, 2009 at 5:12 AM, David Aguilar <davvid@gmail.com> wr=
ote:
> > > =A0contrib/difftool/git-difftool =A0 =A0 =A0 =A0| =A0 =A06 +++---
> >=20
> > Aside, (for Junio I guess...), what's the reason this command is in
> > contrib, and by what criteria might it graduate to being installed
> > with the rest of the git commands?
> >=20
> > j.
>=20
> My thoughts (also for Junio, I guess..):
>=20
> If y'all feel that it can live with the rest of the git
> commands then that would be great =3D)

I'd like to see it as a general git tool, too.
Maybe it can even share some common functionality with git-mergetool.

Markus
