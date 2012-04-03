From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to add folder NON RECURSIVELY ?
Date: Tue, 03 Apr 2012 15:15:37 +0200
Message-ID: <vpqaa2tc5xi.fsf@bauges.imag.fr>
References: <20120403173111.5329d7ed@shiva.selfip.org>
	<vpqzkatc915.fsf@bauges.imag.fr>
	<201204031223.q33CMvQC004186@VM-MailSafe-02.soltecsis.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Apr 03 15:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF3aO-0002A1-2d
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 15:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab2DCNPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 09:15:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33543 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128Ab2DCNPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 09:15:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q33DABMt032125
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Apr 2012 15:10:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SF3aE-0003RG-5x; Tue, 03 Apr 2012 15:15:38 +0200
In-Reply-To: <201204031223.q33CMvQC004186@VM-MailSafe-02.soltecsis.com> (J.
	Bakshi's message of "Tue, 3 Apr 2012 17:52:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Apr 2012 15:10:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q33DABMt032125
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334063413.47742@RB+qbtXqRP+ZLtTEgGLDGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194620>

"J. Bakshi" <joydeep.bakshi@infoservices.in> writes:

> Could you please suggest how can I add foo/dir1/file1 ?
>
> guess
>
> touch foo/dir1/.gitignore
> git add foo/dir1/

Not if you want only "file1" to be added. As I said, Git doesn't know
and doesn't want to know about directories. So "git add directory/" is
just a shorthand that adds all (non-ignored) files in this directory.

> git add foo/dir1/file1

This last line alone will do it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
