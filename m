From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Doc User-Manual: Patch cover letter, three dashes, and --notes
Date: Thu, 25 Oct 2012 23:45:57 +0100
Organization: OPDS
Message-ID: <F4D36C50EB6945CD8EB6E5AF73238148@PhilipOakley>
References: <1350855250-2844-1-git-send-email-philipoakley@iee.org> <1350855250-2844-2-git-send-email-philipoakley@iee.org> <20121025102638.GP8390@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Eric Blake" <eblake@redhat.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 00:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRWBb-0006oW-6k
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 00:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab2JYWpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 18:45:47 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:53921 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803Ab2JYWpq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 18:45:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArINAGXAiVBcHl58/2dsb2JhbABEhhaFP7VVBAEBAoEGgQmCGQUBAQQBCAEBGRUeAQEhCwIDBQIBAw4HAQICAgUhAgIUAQQaBgcXBhMIAgECAwGHbQqrIZJvgSCKQW8eQDqDUzJhA41xmEKCcA
X-IronPort-AV: E=Sophos;i="4.80,650,1344207600"; 
   d="scan'208";a="407908320"
Received: from host-92-30-94-124.as13285.net (HELO PhilipOakley) ([92.30.94.124])
  by out1.ip01ir2.opaltelecom.net with SMTP; 25 Oct 2012 23:45:44 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208423>

From: "Jeff King" <peff@peff.net> Sent: Thursday, October 25, 2012 11:26 
AM
> On Sun, Oct 21, 2012 at 10:34:08PM +0100, Philip Oakley wrote:
>
>> diff --git a/Documentation/user-manual.txt 
>> b/Documentation/user-manual.txt
>> index 85651b5..d918c53 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -1787,6 +1787,11 @@ $ git format-patch origin
>>  will produce a numbered series of files in the current directory, 
>> one
>>  for each patch in the current branch but not in origin/HEAD.
>>
>> +`git format-patch` can include an initial "cover letter". You can 
>> insert
>> +a commentary on individual patches using a three dash line after the
>> +commit message, and before the patch itself. `git 
>> format-patch --notes`
>> +(v1.8.1) will include the commit's notes in the similar manner.
>
> I'd rather not mention a version number here, as we do not yet know
> which version (if any) will contain the feature. Besides, we write our
> documentation to match the current version, so as long as this is 
> queued
> on top of the new code, I do not see any reason to mention a version 
> at
> all.

I'd included it because of the manual's title caveat "(for version 1.5.3 
or newer)", which I'd somehow thought was the matching date for the 
majority of text, hence my inclusion of the version. Begs the question 
what happened back then ;-)

>
> I'll tweak it while queueing.

Thank you.

>
> -Peff
> --
