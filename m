From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 04 Dec 2009 18:36:06 +0100
Message-ID: <87fx7q4p6h.fsf@lysator.liu.se>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGciM-0006yg-Fu
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbZLDSQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2009 13:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbZLDSQ6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:16:58 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:35606 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbZLDSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:16:57 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C452440030;
	Fri,  4 Dec 2009 19:15:59 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id B9E7A4003A; Fri,  4 Dec 2009 19:15:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 7597340030;
	Fri,  4 Dec 2009 19:15:59 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 0BF7560737; Fri,  4 Dec 2009 18:36:06 +0100 (CET)
In-Reply-To: <87ljhi3cao.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	04 Dec 2009 19:59:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134561>

Sergei Organov <osv@javad.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>> Sergei Organov <osv@javad.com> writes:
>>
>>> What is format-spec function in current git-blame.el? Neither my GN=
U
>>> Emacs 22.2.1 nor Google knows anything about it.
>>
>> It's part of Emacs since more than 9 years, imported from Gnus.
>>
>
> Thanks, I now see it in Gnus on my own computer, in
> lisp/gnus/format-spec.el.gz.
>
> GNU Emacs 22.2.1 (i486-pc-linux-gnu, GTK+ Version 2.12.11) of 2008-11=
-10
> on raven, modified by Debian=20
>
> However, isn't it a bad idea to require Gnus(!) for git-blame to run?=
 Gnus
> is not installed on our server where I've encountered the problem. Wa=
s
> format-spec actually moved to core emacs recently?

That was not my intention when I posted the patch. I seem to recall tha=
t
I asked for testing, in particular from users with older Emacsen than
23. But I got no response, and only recently discovered that the patch
hade been accepted.

format-spec is included in Emacs 23, and is a useful function. But we
can rewrite git-blame.el to do the formatting manuall instead.

--=20
David K=C3=A5gedal
