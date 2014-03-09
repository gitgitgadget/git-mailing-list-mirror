From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit/reword/delete a single commit
Date: Sun, 09 Mar 2014 17:30:24 +0100
Message-ID: <vpqeh2bl4gv.fsf@anie.imag.fr>
References: <53159601.8020702@alum.mit.edu>
	<1394333354-16257-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, philipoakley@iee.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 17:31:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMgd6-00081z-VS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 17:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbaCIQan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 12:30:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33255 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbaCIQam (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 12:30:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s29GUNXa026099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Mar 2014 17:30:23 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s29GUO5b007442;
	Sun, 9 Mar 2014 17:30:24 +0100
In-Reply-To: <1394333354-16257-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 9 Mar
 2014 09:49:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 09 Mar 2014 17:30:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s29GUNXa026099
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394987424.4476@9q3fuZBDSxkThfT/BZ8LUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243697>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  Documentation/git-rebase.txt | 11 +++++++++++
>  git-rebase--interactive.sh   | 17 ++++++++++++++---
>  git-rebase.sh                | 22 +++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 4 deletions(-)

This would deserve a few tests ...

>  'git rebase' --continue | --skip | --abort | --edit-todo
> +'git rebase' [--edit | -E | --reword | -R | --delete | -D ] <commit-=
ish>
[...]
> +-E=3D<commit>::
> +--edit=3D<commit>::
> +-R=3D<commit>::
> +--reword=3D<commit>::
> +-D=3D<commit>::
> +--delete=3D<commit>::

I first thought the two versions were inconsistant, but they're
technically correct since the current patch allows only one instance of
the option. I find it a bit weird to have two different descriptions,
but that may be just me.

> +	Configuration variable `rebase.autostash` is
> +	ignored.

I first found it really strange, and then understood it's a typo.

s/autostash/autosquash/

;-)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
