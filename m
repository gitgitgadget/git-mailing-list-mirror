From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Fri, 10 Jan 2014 18:59:26 -0000
Organization: OPDS
Message-ID: <4E804EE705484C3EB397AF6A6E5EB0B0@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org><xmqqppo090m7.fsf@gitster.dls.corp.google.com><0AB7145111924BA986B1E172CD293B1D@PhilipOakley> <xmqqha9b909p.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 22:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1jlW-0000Qd-1g
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 22:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaAJVhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 16:37:14 -0500
Received: from b197.a.smtp2go.com ([216.22.18.197]:42181 "EHLO
	b197.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaAJVhN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 16:37:13 -0500
X-Greylist: delayed 9467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2014 16:37:12 EST
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240318>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>>I think we already use a nicer way to set up a page alias to keep
>>> old links working than making a copy in Documentation/; please mimic
>>> that if possible.
>>
>> This was mainly about ensuring that the 'git help' command could
>> access these extra extra guides that it currently misses. (Tt also
>> misses the 'user-manual', which isn't a man page, but could have a
>> link page to guide the seeker of truth between 'git help' and the
>> actual user-manual)
>>
>> The only method I can see for that (via help.c) is to get the 
>> filename
>> format correct.  Where you thinking of something else?
>
> I do not have an objection against the creation of giteveryday.txt;
> I was questioning the way the original everyday.txt was left behind
> to bit-rot.  It is good to keep _something_ there, because there may
> be old URLs floating around that point at Documentation/everyday.txt,
> but the contents of that file does not have to be a stale copy.

Ah, OK. I had indicated it would be deprecated, but had resisted stating 
a date for deletion (e.g. git 2.0).

I was thinking of a moderate two step deprecation period with the next 
step being a severely cut down residual stub, before it's removal.

>
> Cf. bd4a3d61 (Rename {git- => git}remote-helpers.txt, 2013-01-31)
> for how we renamed git-remote-helpers.txt to gitremote-helpers.txt

I'll have a look at re-using that approach.

Anything else needed before a re-roll?

Philip
