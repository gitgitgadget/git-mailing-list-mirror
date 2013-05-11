From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Outdated and broken online versions of user-manual.html
Date: Sat, 11 May 2013 12:36:21 +0100
Organization: OPDS
Message-ID: <BE32A698F2774BD5B5235264B13A46C8@PhilipOakley>
References: <20130510190229.GA31708@odin.tremily.us> <loom.20130511T092853-808@post.gmane.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>, "Thomas Ackermann" <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sat May 11 13:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub864-0003F7-3O
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 13:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab3EKLgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 07:36:12 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:32681 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751148Ab3EKLgK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 07:36:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsRAMYrjlFOl3rN/2dsb2JhbABagwc3gzyFP7ciAQECfRd0ghoFAQEFCAEBGQ8BBR4BARUXAgMFAgEDFQEEAgUhAgIUAQQaBgcXBgESCAIBAgMBh2kDE6tPiEIFiDCBJossgT8tGIMbMmEDjmGJcZAPgxA7
X-IronPort-AV: E=Sophos;i="4.87,652,1363132800"; 
   d="scan'208";a="423610289"
Received: from host-78-151-122-205.as13285.net (HELO PhilipOakley) ([78.151.122.205])
  by out1.ip03ir2.opaltelecom.net with SMTP; 11 May 2013 12:36:08 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223957>

=46rom: "Thomas Ackermann" <th.acker@arcor.de>
Sent: Saturday, May 11, 2013 8:48 AM
> W. Trevor King <wking <at> tremily.us> writes:
>
>>
>> I'm also surprised that I couldn't find a more obvious link to the
>> manual from git-scm.com (I ended up taking a =E2=80=9CSee Also=E2=80=
=9D link from
>> gittutorial(7) [3]).  I'm not sure if this is intentional or not,
>> since git-scm.com does prominently link Pro Git, and that overlaps
>> fairly significantly with the manual.
>>
>> Folks with Git installed will generally have man pages, so it's not =
a
>> big deal, but having current docs somewhere online to link against
>> would be nice.  I'm also curious if I should be linking against a
>> particular location.
>>
>
> IMHO user-manual is a natural step for a Git beginner after reading=20
> one
> of the books like "Pro Git" and before he is ready to digest the man=20
> pages.
> But up to now there are several problems with user-manual besides the
> problems described by Trevor:
> (1) Very poor html formatting (document type "book" causes
> ugly TOCs per section and there's a "Part I" without a "Part II")
> (2) Partly outdated content
> (3) Sub-optimal structuring (to-do list as part of the document,
> glossary not at the end of the document)
> (4) User-manual.PDF uses an independent tool chain which makes it
> harder to do improvements for user-manual.html and also is the only
> pdf doc we are creating. IMHO we should remove this altogether.
> (5) Large overlapping with the tutorials. IMHO all of the
> tutorials should be blended into user-manual
>
> I am currently working on (1)-(4) and then aiming for (5).
> Comments are welcome ...
>
> ---
> Thomas

I too had noticed that both the User-Manual and git Everyday are not=20
formatted in a manner that allows them to be accessed via 'git help'.

I recently added a '--guides' option to 'git help' (v1.8.2-377-g73903d0=
)=20
which will show the common guides but was frustrated that I couldn't=20
include either the user-manual or everday in the list.

I'd welcome the provision of a 'man'/'html' formatted version of the tw=
o=20
guides. Are you expecting to make then compatible with the man format?

I would be a little cautious of your point 5 if it squoze everything=20
into one overlong document at the expense of losing the shorter=20
documents - one can't eat a whole melon in one bite ;-) That said there=
=20
is a significant opportunity for rationalisation and clarity=20
improvement, even if it is only a proper realisation of where we=20
deliberately duplicate information for ease of user learning.

I also liked the idea of all the documenation being collated into one=20
Humongous pdf as a reference (there was a patch a while back - don't=20
have a reference right now).

Philip=20
