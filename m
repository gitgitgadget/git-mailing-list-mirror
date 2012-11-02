From: nisse@lysator.liu.se (Niels =?iso-8859-1?Q?M=F6ller?=)
Subject: Re: Wishlist: git commit --no-edit
Date: Fri, 02 Nov 2012 11:07:45 +0100
Message-ID: <nnpq3wiaha.fsf@stalhein.lysator.liu.se>
References: <nntxt8ice9.fsf@stalhein.lysator.liu.se>
	<vpqfw4sgx33.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUEAU-0004ma-LA
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 11:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab2KBKHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2012 06:07:50 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:58793 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab2KBKHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 06:07:49 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 87CA140012;
	Fri,  2 Nov 2012 11:07:47 +0100 (CET)
Received: from stalhein.lysator.liu.se (stalhein.lysator.liu.se [IPv6:2001:6b0:17:f0a0::cc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPS id 7946640002;
	Fri,  2 Nov 2012 11:07:47 +0100 (CET)
Received: from stalhein.lysator.liu.se (localhost [127.0.0.1])
	by stalhein.lysator.liu.se (8.14.4+Sun/8.14.4) with ESMTP id qA2A7k1N015568;
	Fri, 2 Nov 2012 11:07:47 +0100 (MET)
Received: (from nisse@localhost)
	by stalhein.lysator.liu.se (8.14.4+Sun/8.14.4/Submit) id qA2A7jlw015565;
	Fri, 2 Nov 2012 11:07:45 +0100 (MET)
X-Authentication-Warning: stalhein.lysator.liu.se: nisse set sender to nisse@lysator.liu.se using -f
In-Reply-To: <vpqfw4sgx33.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Fri, 02 Nov 2012 10:42:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (usg-unix-v)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208918>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Err, isn't this already working? (maybe your version of Git is too ol=
d,
> but my 1.7.9.5 does this at least)

It may be that I'm confused.

It doesn't work in the version I have (1.7.2.5, debian packaged).

And then I also had a quick look in the source code (of a fresh pull
from https://github.com/git/git.git). In builtin/commit.c, I didn't see
any no-edit flag (but I maybe it's in the OPT_BOOL magic (which is
different from OPT_BOOLEAN?)).

And it's also not mentioned in Documentation/git-commit.txt or on
http://kernel.org/pub/software/scm/git/docs/git-commit.html.

If commit --no-edit does work in recent versions, then all is fine,
except possibly the documentation of it. Thanks.

Regards,
/Niels

--=20
Niels M=F6ller. PGP-encrypted email is preferred. Keyid C0B98E26.
Internet email is subject to wholesale government surveillance.
