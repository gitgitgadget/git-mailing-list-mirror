From: Steve Diver <squelch2@googlemail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 1 Feb 2010 11:52:51 +0000
Message-ID: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, Mark Lodato <lodatom@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 12:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbupu-0003Xp-Im
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 12:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab0BALwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 06:52:53 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:36438 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0BALww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 06:52:52 -0500
Received: by pxi12 with SMTP id 12so4243811pxi.33
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 03:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=BuB1WBXdhTOmW2TfLXGNdTtrriU54R39CHz+1VaUZ8k=;
        b=ilv3JQV/tRbBzUNn5QSjlZt/L60FMdk/+EPKvGoOiKc9qTXglTtyl2a6j0b8n1iiQX
         yyiEhBHpS8lVngMH3kMMAuBIb9iYERGrDntfad7KTIZGV+LpyKpQEAK5LP5WciT4zIkt
         zOP1LX4dblYfUkd8TDNrWwBligxPEmeINmfNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=iCU4mhwNostZV8g1yB8ZNGJbspuZmDoSXP0IO8b+1/hJ7rORm6XQlLJXC8QKnwHoyT
         AKfUI++ZGVvX14UEgGNRXy1ireSzzxIN1iUo5b43m4Lu6riCwkEQQL2tRrWrPwAyekYH
         6u6HaeIm7RJHXJF5daaOqxtkcxC7oVfGQCD2Q=
Received: by 10.140.247.17 with SMTP id u17mr3115440rvh.246.1265025171819; 
	Mon, 01 Feb 2010 03:52:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138603>

On 30/01/2010 06:03, Junio C Hamano wrote:

>Nicolas Pitre <nico@fluxnic.net> writes:

>>First, I'm afraid that "Checking out commit 'foobar'" might be confusing
>>as this may happen through either a remote branch, a tag, or any random
>>commit.  It seems to me that "Checking out 'v2.5'" is less confusing

>>than "Checking out commit 'v2.5'".  But that's a minor detail and
>>probably a personal preference.
...
>>To the contrary: this "detached HEAD" is exactly what you need if you
>>want to relate to any documentation or perform a search for more

>>information.  Like it or not, this detached HEAD term is exactly what
>>this Git concept is all about and how it is designated everywhere.  The
>>sooner Git users see and learn about it the better.

>As I am not good at keeping track of different proposals to change this
>word here and that word there, I expect this will probably need at least
>few rotations of earth to get input from people in different timezones,

>and I think this is post 1.7.0 item anyway, I'll queue the attached draft
>in 'pu' and keep it there, to make it easier for others to tweak the
>message.


Would it be a safe assumption to describe a 'detached HEAD' state as
being synonymous with a (local) personal scratchpad or temporary
workspace based on and from the original committed object?

If this assumption is correct, then maybe this notion of a scratchpad
may be more intuitive and conceptual to new users without getting
bogged down with the necessary semantics of the terms used, but can
also preserve references to 'detached HEAD' in the documentation for a
fuller explanation.


A scratchpad or temporary workspace description alludes to its semi
permanent nature, and can warn that the subsequent commits may be lost
through aging and garbage collection until the user "commits" to
saving their progress through the creation a new branch, and thereby
making them permanent.


I must say the explanations presented in this thread have shed some
light on what is on the face of it a common trap that leaves new users
wondering "What happened to my work!" and I thank you all.

Steve
