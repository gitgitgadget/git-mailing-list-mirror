From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Set process-environment instead of invoking env (follow-up 1)
Date: Fri, 18 Apr 2008 15:34:18 +0200
Message-ID: <87ej93l21x.fsf@lysator.liu.se>
References: <1f748ec60804180607v474ffc55ta7eeb62dd449344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Maintainer <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	piyo@users.sourceforge.net
X-From: git-owner@vger.kernel.org Sat Apr 19 14:41:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jmqk0-0003tG-EK
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbYDRNeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 09:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbYDRNeP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:34:15 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:45788 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYDRNeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 09:34:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 7A2E7200A36D;
	Fri, 18 Apr 2008 15:34:13 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 04571-01-14; Fri, 18 Apr 2008 15:34:12 +0200 (CEST)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C6444200A285;
	Fri, 18 Apr 2008 15:34:12 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 885F2E48001; Fri, 18 Apr 2008 15:34:18 +0200 (CEST)
In-Reply-To: <1f748ec60804180607v474ffc55ta7eeb62dd449344@mail.gmail.com> (Clifford Caoile's message of "Fri\, 18 Apr 2008 22\:07\:12 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79880>

"Clifford Caoile" <piyo@users.sourceforge.net> writes:

> According to the similar patch from David K=C3=A5gedal [1], "this wil=
l make
> it a little less posix-dependent and more efficient." However, there
> are two other areas that need to replaced, namely
> git-run-command-region and git-run-hooks. This patch implements the
> changes of [1] onto those Emacs Lisp functions.

Of course. Silly that I missed them.

--=20
David K=C3=A5gedal
