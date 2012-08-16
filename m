From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 20:59:52 +0100
Organization: OPDS
Message-ID: <2BB1E674DD214C66B06660612F34109D@PhilipOakley>
References: <20120816095018.GD5489@suse.cz> <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 16 22:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T26FE-0005m4-Cd
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 22:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933250Ab2HPUAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 16:00:13 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:45287 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933217Ab2HPUAI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2012 16:00:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4NACxPLVBZ8rQi/2dsb2JhbABFi0CtcgQBAQJ1gQiCGwUBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYBEggCAQIDAYgAuw6LClc0gQeDZWADiBmFQpgGgmA
X-IronPort-AV: E=Sophos;i="4.77,780,1336345200"; 
   d="scan'208";a="401019907"
Received: from host-89-242-180-34.as13285.net (HELO PhilipOakley) ([89.242.180.34])
  by out1.ip02ir2.opaltelecom.net with SMTP; 16 Aug 2012 21:00:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, August 16, 2012 5:22 PM
> Miklos Vajna <vmiklos@suse.cz> writes:
>
>> ---
>>  Documentation/git-pull.txt |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
>> index defb544..67fa5ee 100644
>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -101,6 +101,7 @@ include::merge-options.txt[]
>>
>>  :git-pull: 1
>>
>> +-r::
>>  --rebase::
>>  Rebase the current branch on top of the upstream branch after
>>  fetching.  If there is a remote-tracking branch corresponding to
>
> I am not sure if this is worth it, as it comes from a natural
> "abbreviated options" support, i.e.

I wasn't aware of the  "abbreviated options" capability. Is meant to be 
in the man pages as I couldn't find it, or is it described differently?

Just adding the '-r' part of the option did seem sensible to me as a 
relative newbie.

>
> -r|--r|--re|--reb|--reba|--rebas|--rebase)
> rebase=true
>
> And I do not think we particularly want to do
>
>    +-r::
>    +--r::
>    +--re::
>    +--reb::
>    +--reba::
>    +--rebas::
>     --rebase::
>            Rebase the current...
>
> for obvious reasons.
> --

The extra one liner (-r|--r|--re|--reb|--reba|--rebas)  would be 
readable though not pretty, but the seven line version would be 
horrible!

Philip 
