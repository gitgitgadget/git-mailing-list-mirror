From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Wed, 02 May 2012 08:38:13 +0200
Message-ID: <vpqfwbjnl4a.fsf@bauges.imag.fr>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 08:38:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPTCp-00062A-4J
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 08:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab2EBGiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 02:38:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45318 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185Ab2EBGiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 02:38:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q426VM89021232
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 May 2012 08:31:22 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SPTCY-0001co-QS; Wed, 02 May 2012 08:38:14 +0200
In-Reply-To: <CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 1 May 2012 14:00:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 May 2012 08:31:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q426VM89021232
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336545084.68397@ZefsMZUunLzADDB4+P+XAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196788>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 1 May 2012 13:33, Junio C Hamano <gitster@pobox.com> wrote:
>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>
>>> Is there any way to get (some of) the Git hooks to run for everyone
>>> without everyone having to install them separately? If no, is this =
by
>>> design or simply a feature nobody has asked for (yet)?
>>
>> By design. =A0Do you want me to include "rm -fr ~hilco" in some hook=
 of
>> git.git repository?
>
> Mmm, well, I might get quite famous if you did... ;-)
>
> But if you wanted to be evil then you could easily find another place
> (the build scripts, the code itself, et cetera).

Yes, but at least, you have the opportunity to examine the other places
before they are ran. Hooks would be really, really nasty security-wise.
=46or example, "git clone" does a checkout, so should probably run the
checkout hooks.

> So I don't think this is a good argument. Moreover, I do not work wit=
h
> people that would ever consider such nastiness. You need to realize
> that this is all closed source. Your argument would be more valid in
> an open source environment (like git.git).

That may be acceptable for you, but you can't ask for such feature to b=
e
included in Git itself. At best, a standardized way to setup hooks (but
something that would require a user-action to be set up) would be
acceptable.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
