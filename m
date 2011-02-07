From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Mon, 07 Feb 2011 13:09:19 +0100
Message-ID: <vpq1v3kf3m8.fsf@bauges.imag.fr>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vsjw0v11p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 13:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmPxe-0002ce-05
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 13:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab1BGMMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 07:12:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:42914 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab1BGMMr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 07:12:47 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p17C9K5U021907
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Feb 2011 13:09:20 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmPuB-0004eA-Um; Mon, 07 Feb 2011 13:09:19 +0100
In-Reply-To: <7vsjw0v11p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 06 Feb 2011 21\:58\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 Feb 2011 13:09:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166256>

[ Your mailer did something strange with my name and email ]

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> When -u was introduced in dfdac5d (git-add -u: match the index with
>> working tree., 2007-04-20), "add -u" (without pathspec) added
>> everything. Shortly after, 2ed2c22 (git-add -u paths... now works fr=
om
>> subdirectory, 2007-08-16) broke it while fixing something related.
>
> As long as the command takes pathspecs, it should never be tree-wide.
> Making it tree-wide when there is no pathspec is even worse.

This is against the common use in Git. As I mentionned in the other
thread, pretty much any git command taking an optional pathspec is
still tree-wide when called without argument. "git add -u" is the
exception.

> If "add -p" does not limit operation to the current directory, probab=
ly
> that is the inconsistency bug to be fixed.

Add "git log", "git status", "git commit", "git show", "git diff", and
a few others I've missed to the list of "exceptions" ...

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
