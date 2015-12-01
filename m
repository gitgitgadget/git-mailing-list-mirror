From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: Dependency query regarding contrib scripts
Date: Tue, 1 Dec 2015 16:52:10 +0000
Message-ID: <20151201165209.GA28230@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 17:52:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3oAB-00059a-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 17:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbbLAQwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 11:52:17 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:59367 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbbLAQwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 11:52:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 6090C460925
	for <git@vger.kernel.org>; Tue,  1 Dec 2015 16:52:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AOn4oK1Iz2sp for <git@vger.kernel.org>;
	Tue,  1 Dec 2015 16:52:12 +0000 (GMT)
Received: from salo (salo.dyn.ducie.codethink.co.uk [10.24.1.218])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id E7827460BCE
	for <git@vger.kernel.org>; Tue,  1 Dec 2015 16:52:11 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281840>

Hi,

Having read the docs for integrating new subcommands into git[1] I am l=
ooking
for some clarification of the following,

"While we strongly encourage coding in portable C for portability,
these [C, shell, perl] specific scripting languages are also acceptable=
=2E
We won=E2=80=99t accept more without a very strong technical case,
as we don=E2=80=99t want to broaden the Git suite=E2=80=99s required de=
pendencies"

Does this also mean that use of non-core modules by, for example, perl =
scripts,
is out of the question for contrib scripts? Or is it acceptable but ide=
ally
minimised?

In particular I'd like to be able to make use of Git::Raw[2] and also i=
deally
the Moo framework[3].

Thanks,
Richard Ipsum

[1]: ftp://www.kernel.org/pub/software/scm/git/docs/v2.4.0/howto/new-co=
mmand.html
[2]: http://search.cpan.org/~jacquesg/Git-Raw-0.58/lib/Git/Raw.pm
[3]: http://search.cpan.org/~haarg/Moo-2.000002/lib/Moo.pm
