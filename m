From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Thu, 3 May 2012 11:00:10 +0200
Message-ID: <87ipgdskpx.fsf@thomas.inf.ethz.ch>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
	<vpqfwbjnl4a.fsf@bauges.imag.fr>
	<CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com>
	<7v1un2idt0.fsf@alter.siamese.dyndns.org>
	<CAE1pOi1SLU5_eLr3ahiUjzQqPUnVPX70CPq=OW-o-85Lk43GwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 11:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPrth-000084-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 11:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab2ECJAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 05:00:19 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:48985 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245Ab2ECJAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 05:00:17 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 3 May
 2012 11:00:16 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 3 May
 2012 11:00:11 +0200
In-Reply-To: <CAE1pOi1SLU5_eLr3ahiUjzQqPUnVPX70CPq=OW-o-85Lk43GwA@mail.gmail.com>
	(Hilco Wijbenga's message of "Wed, 2 May 2012 12:42:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196893>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

>> Matthieu is *not* talking about auditing nastiness going into the
>> project's repository; he is talking is about a chance to audit whatever
>> comes from the project's repository that *could* potentially contain some
>> nastiness before it causes harm to your working environment. In other
>> words, not *having* to trust what is in the project's repository, but
>> having a way to verify.
>
> Perhaps these automatic hooks should only be applicable for "outgoing"
> changes like commit and push? That way you can review the hooks before
> they run but you still have a chance to prevent developer errors from
> getting to the server/other people (which is really all I care about,
> I am looking for a way to protect developers from making silly
> mistakes).

Shouldn't those checks be made server-side with a pre-receive hook?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
