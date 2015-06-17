From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 19:24:30 +0200
Message-ID: <vpqh9q6gsdt.fsf@anie.imag.fr>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>
	<5581A3A3.1070908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:24:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5H54-00029W-9M
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbbFQRYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 13:24:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40183 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940AbbFQRYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:24:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5HHORT2027965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 19:24:27 +0200
Received: from anie.imag.fr (ensi-vpn-247.imag.fr [129.88.57.247])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5HHOUsG014613;
	Wed, 17 Jun 2015 19:24:30 +0200
In-Reply-To: <5581A3A3.1070908@web.de> ("Torsten \=\?iso-8859-1\?Q\?B\=F6gersha\?\=
 \=\?iso-8859-1\?Q\?usen\=22's\?\= message of
	"Wed, 17 Jun 2015 18:43:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Jun 2015 19:24:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5HHORT2027965
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435166672.34551@kHXzJcozjfrwqlamTFUBng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271874>

Torsten B=F6gershausen <tboegi@web.de> writes:

> My v3 will probably use the original line:
> git-checkout - Checkout a branch or paths to the working tree

I think mentionning "Switch branch" was a real improvement. For someone
not familiar with the version control vocabulary, "checkout" does not
mean much (just looked in a dictionary, it talks about payment and
leaving a room in a hotel ...). And someone not understanding what
"checkout" means in this context won't be helped much reading the
description and getting "checkout" there.

(Ironically, Junio did almost the same remark when I proposed to
document "git describe" as "Describe ...", but the word "describe" does
not have the ambiguity problem that "checkout" has)

> 'git checkout <commit> -- <path>'
> will "copy" the version from another commit into the workspace.

If <commit> exists, it means that the state of this path existed
somewhere in <path> in the past (well, modulo "git add -p" and other
ways to cheat with history).

So, to me, "restore a previous version" does apply in this case. Perhap=
s
"restore a recorded state into the worktree" (my favorite up to now I
think).

But as you say, it copies into the workspace, so "copy a previous
version into the workspace" sounds good to me.

Basically, I'm fine with anything starting with "Switch branches or",
but please do change the headline ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
