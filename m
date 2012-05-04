From: Johan Herland <johan@herland.net>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Fri, 4 May 2012 08:10:57 +0200
Message-ID: <CALKQrgcTtjQtS34EZhay8nMKxFO2iCHv+YCZjXefB6oZsa93kw@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
	<vpqfwbjnl4a.fsf@bauges.imag.fr>
	<CAE1pOi3RZ+x7YcVZ-dLt70=wwRsvY9D6GQR-T+JZ9S7x8CFjPw@mail.gmail.com>
	<7v1un2idt0.fsf@alter.siamese.dyndns.org>
	<CAE1pOi1SLU5_eLr3ahiUjzQqPUnVPX70CPq=OW-o-85Lk43GwA@mail.gmail.com>
	<87ipgdskpx.fsf@thomas.inf.ethz.ch>
	<CAE1pOi39i4hg_bTuigq15ifuKtXVW7F-NukMP57E_4e=s0fMdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 08:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQC75-0007Lc-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 08:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2EDGfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 02:35:30 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:62377 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab2EDGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 02:35:30 -0400
X-Greylist: delayed 1467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 02:35:30 EDT
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1SQBjJ-00027N-7m
	for git@vger.kernel.org; Fri, 04 May 2012 08:11:01 +0200
Received: by obbtb18 with SMTP id tb18so3534533obb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 23:10:57 -0700 (PDT)
Received: by 10.60.172.231 with SMTP id bf7mr6532208oec.45.1336111857744; Thu,
 03 May 2012 23:10:57 -0700 (PDT)
Received: by 10.76.133.226 with HTTP; Thu, 3 May 2012 23:10:57 -0700 (PDT)
In-Reply-To: <CAE1pOi39i4hg_bTuigq15ifuKtXVW7F-NukMP57E_4e=s0fMdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196994>

On Thu, May 3, 2012 at 7:05 PM, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> On 3 May 2012 02:00, Thomas Rast <trast@student.ethz.ch> wrote:
>> Shouldn't those checks be made server-side with a pre-receive hook?
>
> Firstly, see my original email: we have no such access to the server.
> Secondly, (now that I've thought about it a bit more), it makes more
> sense to do it on the "client" instead of having the server do all the
> work for everybody. (Fail early, fail fast.)

No matter how you go about this, there is no way to _guarantee_ that a
given hook is run in all user repos (after all, the users have the
ultimate control over their own repos), so if you really _need_ the
hook to be run, then you have no other choice but to put it on the
server. Such is the nature of distributed version control.

If you still want a hook to run in user repos, you can only ask that
users enable the hook by including a script which copies the hook into
place, and then tell your users to run that script (e.g. in your
README).


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
