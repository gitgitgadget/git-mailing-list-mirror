From: Dieter Komendera <dieter@komendera.com>
Subject: Bug report: git add . -p "Argument list too long"
Date: Mon, 31 Mar 2014 23:04:27 +0200
Message-ID: <2893758C-2196-4A0F-8FD7-69C13B1EDBA4@komendera.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 23:14:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjWm-0000Vj-4o
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbaCaVNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Mar 2014 17:13:52 -0400
Received: from mx02.posteo.de ([89.146.194.165]:52030 "EHLO posteo.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751199AbaCaVNv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 17:13:51 -0400
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2014 17:13:51 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.posteo.de (Postfix) with ESMTP id E00D499E1FB
	for <git@vger.kernel.org>; Mon, 31 Mar 2014 21:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at posteo.de
Received: from posteo.de ([10.125.125.178])
	by localhost (amavis1.posteo.de [10.125.125.165]) (amavisd-new, port 10026)
	with ESMTP id TsvrXYzpOIkL for <git@vger.kernel.org>;
	Mon, 31 Mar 2014 23:04:29 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by mail.posteo.de (Postfix) with ESMTPSA id E23132C0429
	for <git@vger.kernel.org>; Mon, 31 Mar 2014 23:04:28 +0200 (CEST)
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245533>

Hi there,

since a while when I want to stage diffs in one of my big repos with "g=
it add . -p=94 I get this error:

Can't exec "git": Argument list too long at /usr/local/Cellar/git/1.9.1=
/libexec/git-core/git-add--interactive line 180.
Died at /usr/local/Cellar/git/1.9.1/libexec/git-core/git-add--interacti=
ve line 180.

Mac OS X 10.9.2
git 1.9.1 (installed via homebrew)

I=92ve also tried the latest versions of the 1.7 and 1.8 branches which=
 also yielded the same error in that repo.
git add . -p works fine in other (smaller) repos. Unfortunately I=92m n=
ot able to share this private repo.

I found this rather old posting in the mailing list archive, unfortunat=
ely the link to the "quick and easy fix=94 looks dead:
http://article.gmane.org/gmane.comp.version-control.git/142863/match=3D=
argument+list+too+long+git+add

Anybody can help?

Thanks,
Dieter
