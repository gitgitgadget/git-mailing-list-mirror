From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Dec 2014, #05; Mon, 29)
Date: Fri, 2 Jan 2015 00:18:15 -0000
Organization: OPDS
Message-ID: <FA848958B0844C17A5F701B0A336A178@PhilipOakley>
References: <xmqq387yywm6.fsf@gitster.dls.corp.google.com><AC1A0FA97BFC4A1CA4D89EA6F74C9447@PhilipOakley> <xmqqiogtt9mb.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 01:17:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6pvy-0007r9-QE
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 01:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbABARh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2015 19:17:37 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:17085 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbbABARh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2015 19:17:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIZAFnipVROl3wVPGdsb2JhbABcgwaBKoYvbMUDBAKBBhcBAQEBAQEFAQEBATggG4QHBgEFCAEBLh4BARUMCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIH7UfjVmDC4k8gzCDHYETBYkhhHRNiTOIUIFihhGCMYFfPjGCQwEBAQ
X-IPAS-Result: AgIZAFnipVROl3wVPGdsb2JhbABcgwaBKoYvbMUDBAKBBhcBAQEBAQEFAQEBATggG4QHBgEFCAEBLh4BARUMCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIH7UfjVmDC4k8gzCDHYETBYkhhHRNiTOIUIFihhGCMYFfPjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,681,1413241200"; 
   d="scan'208";a="579880795"
Received: from host-78-151-124-21.as13285.net (HELO PhilipOakley) ([78.151.124.21])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 02 Jan 2015 00:17:35 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261973>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>
>>> * po/doc-core-ignorestat (2014-12-12) 1 commit
>>>  (merged to 'next' on 2014-12-23 at d2b3e84)
>>> + doc: core.ignoreStat clarify the --assume-unchanged effect
>>>
>>> Will merge to 'master'.
>>>
>> I was hoping to re-roll but family Christmas / New Year visits have
>> disrupted plans.
>>
>> Could you hold for another week or so? (though happy either way)
>
> Surely I will as requested, but I think the patch is an improvement
> with or without a further incremental updates ;-)
>
This has become that anti-pattern "when in a hole keep digging"...

I wanted to ensure that the user's manual actions were better 
identified,
and include part of Johannes suggestions ($gmane/261308/focus=261348).
However, on checking my expectation (of using 'git add'), it created a
'learning experience', so hopefully the update is better for it.

The updated patch V2 should follow.
Comments welcome.
--
Philip
