From: nisse@lysator.liu.se (Niels =?iso-8859-1?Q?M=F6ller?=)
Subject: Re: [PATCH] Document 'git commit --no-edit' explicitly
Date: Fri, 02 Nov 2012 12:24:15 +0100
Message-ID: <nnlieki6xs.fsf@stalhein.lysator.liu.se>
References: <nnpq3wiaha.fsf@stalhein.lysator.liu.se>
	<1351852770-13897-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUFMY-0003vj-6U
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 12:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762410Ab2KBLYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 07:24:21 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:49291 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2KBLYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 07:24:20 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 09D5640012;
	Fri,  2 Nov 2012 12:24:18 +0100 (CET)
Received: from stalhein.lysator.liu.se (stalhein.lysator.liu.se [IPv6:2001:6b0:17:f0a0::cc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPS id F0D3040002;
	Fri,  2 Nov 2012 12:24:17 +0100 (CET)
Received: from stalhein.lysator.liu.se (localhost [127.0.0.1])
	by stalhein.lysator.liu.se (8.14.4+Sun/8.14.4) with ESMTP id qA2BOGiK018872;
	Fri, 2 Nov 2012 12:24:17 +0100 (MET)
Received: (from nisse@localhost)
	by stalhein.lysator.liu.se (8.14.4+Sun/8.14.4/Submit) id qA2BOFnm018871;
	Fri, 2 Nov 2012 12:24:15 +0100 (MET)
X-Authentication-Warning: stalhein.lysator.liu.se: nisse set sender to nisse@lysator.liu.se using -f
In-Reply-To: <1351852770-13897-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 2 Nov 2012 11:39:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (usg-unix-v)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208921>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +--no-edit::
> +	Use the selected commit message without launching an editor.
> +	For example, `git commit --amend --no-edit` amends a commit
> +	without changing its commit message.

Looks clear enough to me. Thanks for fixing.

Are -c --no-edit and -C really equivalent in all cases? If so, maybe yo=
u
want to say that in the documentation for -C. (And if not, maybe they
*ought* to be equivalent).

Regards,
/Niels

--=20
Niels M=F6ller. PGP-encrypted email is preferred. Keyid C0B98E26.
Internet email is subject to wholesale government surveillance.
