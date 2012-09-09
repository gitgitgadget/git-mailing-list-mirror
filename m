From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 00:25:36 +0100
Organization: OPDS
Message-ID: <498B6DF9C7714C278DC3DC9F3EF4A178@PhilipOakley>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com> <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com> <7vsjayew50.fsf@alter.siamese.dyndns.org> <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com> <7vd322ebsz.fsf@alter.siamese.dyndns.org> <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com> <7vpq61dfn9.fsf@alter.siamese.dyndns.org> <7v8vcpdat2.fsf@alter.siamese.dyndns.org> <7vk3w5woc4.fsf@alter.siamese.dyndns.org> <3DA7C9D97E19414C81F8D73CB66171DA@PhilipOakley> <7voblfub16.fsf@alter.siamese.dyndns.org> <vpq627ntii0.fsf@bauges.imag.fr> <7vd31vqcmd.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 10 01:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAqsj-00076g-UY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 01:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab2IIXZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 19:25:30 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:46445 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756194Ab2IIXZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 19:25:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuAKAAgkTVBZ8rU+/2dsb2JhbABFi0avAgKBB4EIghsFAQEEAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBCodvCroJjGuDfmADiB6FQ5gZgmc
X-IronPort-AV: E=Sophos;i="4.80,126,1344207600"; 
   d="scan'208";a="402862438"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 10 Sep 2012 00:25:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205105>

From: "Junio C Hamano" <gitster@pobox.com>
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>> Having said that, it would therefore be better to point folk at 
>>>> gitcli
>>>> in a few more places, not just the 'see also' line at the very end 
>>>> of
>>>> the general 'git' page, and buried within rev-parse.
>>>
>>> Didn't we update the very early part of git(1) for exactly for that
>>> reason recently?

Oops I'd forgotten that specific change.

>>
>> I don't think many people read git(1) directly, as there are many 
>> other
>> starting points to learn Git (official tutorial, user-manual, and 
>> tens
>> of very good tutorial on the web).
>
> Many of which is outside what patches made against to my tree would
> be able to fix.  I wonder if we can have some mechanism to easily
> notify and help the owners of these material to keep them up to
> date.
>
>> On the other hand, reading git-<command> is probably much more
>> common, as it is the only place to find exhaustive documentation
>> about a particular command.
>
> That "people diving into 'git --help <subcmd>', assuming everything
> can be learned there" is a problem within the scope of what we could
> control.  For obvious reasons, including "glossary-contents" and
> "gitcli" at the beginning of documentation for each and every
> subcommand is not a useful solution, and referring the prerequisite
> reading for them in git(1) was done as the first step to solve that
> issue, and you are essentially saying that it is not enough.
>
> So what is the right second step?

a simple link to the gitcli page? or, add the <pathspec> into the 
checkout options list and a link to a suitable place for that, which can 
then point to the gitcli.

>
From my perspective the majority of the top twenty git commands should, 
within each of their help pages, have an in-text link into one or other 
of the various 'guide' style articles, which can then be interconnected 
to each other. This should give the beginner help by directing them away 
from the details of a man page for the general issues. That is, 
distinguish which parts are help for those who aren't sure what they 
need to know, from the those parts that provide the specfic details for 
those do know.

I hope to have some documentation patches in the next few days on other 
small misunderstandings I've seen/made. Just battling my windows / 
msysgit / pu set-up at the moment. 
