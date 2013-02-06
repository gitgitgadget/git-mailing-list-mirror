From: demerphq <demerphq@gmail.com>
Subject: Re: CodingGuidelines Perl amendment
Date: Wed, 6 Feb 2013 19:44:16 +0100
Message-ID: <CANgJU+X=Bb=ncqOxsd1hZDWsnFkt-bJw=Zbtuz8_KC0gO-dLaQ@mail.gmail.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
	<871ucto4vj.fsf_-_@lifelogs.com>
	<7vvca5mmmt.fsf@alter.siamese.dyndns.org>
	<87vca5gvx6.fsf@lifelogs.com>
	<CANgJU+VbkQ+xa+_sSAu-3pMe+6gycHi9J4VR18M5YJt=pa9QUw@mail.gmail.com>
	<87ip65guj8.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39z7-0001P4-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab3BFSoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:44:18 -0500
Received: from mail-qc0-f182.google.com ([209.85.216.182]:38568 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab3BFSoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:44:17 -0500
Received: by mail-qc0-f182.google.com with SMTP id k19so661677qcs.27
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DaEilMuBsES5M6KUBnA5IuU5BPnzOwUNhwaqCvUt0ao=;
        b=W0KQ4b435Srutnmt1nQAxkchC3k6wivsrnRu41jYMGhADJe8rJd85JzOonPJ8MWlWX
         mFwNQsm/i5fO+4kRtdne3QNPzcibS1Vz9bQecMp7OiiA7a8uwtfNKXLZXb9EETmq0R9j
         i5nNlkP/NNsCYjRasZKBFO5rAQT0QHNi7l30KApyPsDn/7QMJB0glULdtdTiY4lLeaYD
         Yr5DvJ6HB0JmSajGtNx6936Dz8RlisKEapNtqRx02aGTg96hE4DLYf9wtObCdEJa7LA2
         8VGLAknNMo4ApZxGGjYDJ5Mlod48wMJmZEt/iAlfigVtzQrpnI6G0knEcnEPIN4mh7R9
         EH9g==
X-Received: by 10.224.52.68 with SMTP id h4mr21047144qag.17.1360176256959;
 Wed, 06 Feb 2013 10:44:16 -0800 (PST)
Received: by 10.49.94.196 with HTTP; Wed, 6 Feb 2013 10:44:16 -0800 (PST)
In-Reply-To: <87ip65guj8.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215621>

On 6 February 2013 19:35, Ted Zlatanov <tzz@lifelogs.com> wrote:
> On Wed, 6 Feb 2013 19:25:43 +0100 demerphq <demerphq@gmail.com> wrote:
>
> d> On 6 February 2013 19:05, Ted Zlatanov <tzz@lifelogs.com> wrote:
>>> On Wed, 06 Feb 2013 08:29:30 -0800 Junio C Hamano <gitster@pobox.com> wrote:
>>>
> JCH> Is it ever (as opposed to "not always") possible to omit braces?
>>>
>>> Oh yes!  Not that I recommend it, and I'm not even going to touch on
>>> Perl Golf :)
>
> d> I think you are wrong. Can you provide an example?
>
> d> Larry specifically wanted to avoid the "dangling else" problem that C
> d> suffers from, and made it so that blocks are mandatory. The only
> d> exception is statement modifiers, which are not only allowed to omit
> d> the braces but also the parens on the condition.
>
> Oh, perhaps I didn't state it correctly.  You can avoid braces, but not
> if you want to use if/elsif/else/unless/etc. which require them:
>
> condition && do_this();
> condition || do_this();
> condition ? do_this() : do_that();
>
> (and others I can't recall right now)
>
> But my point was only that it's always possible to get around these
> artificial restrictions; it's more important to ask for legible sensible
> code.  Sorry if that was unclear!

Ah ok. Right, at a low level:

if (condition) { do_this() }

is identical to

condition && do_this();

IOW, Perl allows logical operators to act as control flow statements.

I hope your document include something that says that using logical
operators as control flow statements should be used sparingly, and
generally should be restricted to low precedence operators and should
never involve more than one operator.

Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
