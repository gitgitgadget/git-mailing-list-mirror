From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv2 4/8] Doc: 'git' has a discussion section
Date: Wed, 19 Sep 2012 08:19:16 +0100
Organization: OPDS
Message-ID: <A2353F0975764FD3A89690A64FBC8694@PhilipOakley>
References: <1348010734-664-5-git-send-email-philipoakley@iee.org> <7vr4pyisc3.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "gitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 09:19:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEEZ0-0000IS-N3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 09:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab2ISHTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 03:19:05 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:44540 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473Ab2ISHTE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 03:19:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar0OANZwWVBZ8rU+/2dsb2JhbABFi0iwBQECAYEAgQmCGwUBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGHcwe6X4tVYoFegmhgA4ghhUSYH4Jn
X-IronPort-AV: E=Sophos;i="4.80,447,1344207600"; 
   d="scan'208";a="403735178"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 19 Sep 2012 08:19:01 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205910>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Highlight there is a further discussion section later in
>> git man page
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>>
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 34d8a1b..d932a3e 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -30,6 +30,7 @@ After you mastered the basic concepts, you can come 
>> back to this
>>  page to learn what commands git offers.  You can learn more about
>>  individual git commands with "git help command".  linkgit:gitcli[7]
>>  manual page gives you an overview of the command line command 
>> syntax.
>> +See also the Discussion and Further Documentation sections below.
>>
>>  Formatted and hyperlinked version of the latest git documentation
>>  can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
>
> I am not sure if this is appropriate.
>
> The primary objective of this paragraph is to nudge people who try
> to dive into the body of this document without understanding the
> fundamentals (which tends to waste their time) without spending too
> many words.  After they visit these pages, they are armed with
> sufficient prerequisite knowledge and are free to go directly to
> documentation for individual subcommands, and this page is one of
> such pages.  I do not think Discussion and Further Documentation
> sections are such prerequisites they should read before coming back
> here and looking at the list of subcommands.
>
It was more that _all_ man pages link back here, and these (hopefully 
useful ;-)  Discussion and Further Documentation sections are waaay off 
the bottom of the screen, so are easy to never see.

Actually I would have liked to make it an active link to the section for 
any html version, but wasn't sure how to achieve that - is there a 
method to link within a document?

Philip
