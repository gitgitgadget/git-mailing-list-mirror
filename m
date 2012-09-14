From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Suggestions for "What's cooking"
Date: Fri, 14 Sep 2012 07:00:53 +0100
Organization: OPDS
Message-ID: <03339FB2E0624FCA858255742B9CA7FD@PhilipOakley>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org> <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org> <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley> <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com> <7vmx0t94rc.fsf@alter.siamese.dyndns.org> <CAH5451n3bAkidWrtu4sy=NXPYZ7wWc+WFoReOm98xq2S22+55w@mail.gmail.com> <7vboh99w1z.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jens Lehmann" <Jens.Lehmann@web.de>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Andrew Ardill" <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 08:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCOxf-0004mg-5a
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 08:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2INGAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 02:00:53 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:56769 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754476Ab2INGAu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 02:00:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuUKAE6wUlBZ8rU+/2dsb2JhbABFi0avNwJ7gQiCGwUBAQUIAQEuHgEBIQsCAwUCAQMVAQIJJRQBBAgSBgcXBgESCAIBAgMBh20DELFJDYlTijJjgUobGYNZYAOIIIVEhieMbIUKgmc
X-IronPort-AV: E=Sophos;i="4.80,421,1344207600"; 
   d="scan'208";a="393539197"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip05ir2.opaltelecom.net with SMTP; 14 Sep 2012 07:00:48 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205456>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, September 14, 2012 3:29 AM
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> On 14 September 2012 04:06, Junio C Hamano <gitster@pobox.com> wrote:
>>> Andrew Ardill <andrew.ardill@gmail.com> writes:
>>>
>>>> <short-branch-description>
>>>>   <long-branch-description>
>>>>   <notes>
>>>>   <next-steps>
>>>>   * <branch-name> (<creation-date>) <number-of-commits>
>>>>     (<merge-status>)
>>>>    [list-of-commits]
>>>>     (<branch-usage>)
>>>
>>> I do not see how it makes any sense to have the "This is where the
>>> section begins with, and its name is this" line in the middle of a
>>> block indented in such a way.  Care to explain?
>>
>> I'm not quite sure what aspect you are referring to,...
>
> Just this part, as I do not have much time.  Here is your reordered
> one I will reject:
>
>  A > jc/maint-blame-no-such-path
>    >   "git blame MAKEFILE" run in a history that has "Makefile" but 
> not
>    >   "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
>    >   confused on a case insensitive filesystem.
>    >
>  B >   * jc/maint-blame-no-such-path (2012-09-10) 1 commit
>    >    - blame $path: avoid getting fooled by case insensitive 
> filesystems
>
> I was noting that B which *is* formatted as a header line (it EVEN
> has a leading asterisk to make it clear that it begins something
> new) is in the middle, and you added a redundant A that is not even
> marked clearly as a header line.
>
Are we all working with Black text on a White background? (or is it vice 
versa) as this changes which bits of emphasis the eye will pick up. I'm 
reading the emails as black text against a white background.

I find that for black text, in a block format, that one does not notice 
any special inital character, such as the '*', when it is part of a 
rectangular block. In fact I feel I tend to, if anything, down grade 
text begining with special characters as being bullet points below some 
main block text. Hence my suggestion to have either a visual break 
(extra line above), or a block indent (extra left hand space).

Changing the contrast to white text on a black background totally 
changes what the eye/brain will see/notice [$dayjob is electro-optic 
vision systems where contrast inversion is a standard requirement for 
that reason]. It maybe that we are seeing different personal effects 
because of our set-ups.
