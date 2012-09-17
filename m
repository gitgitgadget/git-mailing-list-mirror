From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 6/8] Doc add: link gitignore
Date: Mon, 17 Sep 2012 23:01:30 +0100
Organization: OPDS
Message-ID: <6AB419E032004F8A890B01EC04731CD2@PhilipOakley>
References: <1347793083-4136-7-git-send-email-philipoakley@iee.org> <7vhaqxw635.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "gitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:01:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDjNi-0001U2-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab2IQWBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:01:22 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:21459 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755997Ab2IQWBV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 18:01:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At8KAECdV1BZ8rU+/2dsb2JhbABFi0avWgJ/gQiCGwUBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGHc7pQjQkdIoNhYAOIIYVEmB6CZw
X-IronPort-AV: E=Sophos;i="4.80,438,1344207600"; 
   d="scan'208";a="398913709"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip03ir2.opaltelecom.net with SMTP; 17 Sep 2012 23:01:20 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205759>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Include the gitignore link with the paired gitrepository-
>> layout link.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>
>> without the gitignore link users are unlikely to realise the
>> significance of the repository layout link, nor what to look for
>> within it
>>
>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index 9c1d395..311be9a 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -155,7 +155,8 @@ Configuration
>>  The optional configuration variable `core.excludesfile` indicates a 
>> path to a
>>  file containing patterns of file names to exclude from git-add, 
>> similar to
>>  $GIT_DIR/info/exclude.  Patterns in the exclude file are used in 
>> addition to
>> -those in info/exclude.  See linkgit:gitrepository-layout[5].
>> +those in info/exclude.  See linkgit:gitrepository-layout[5] and
>> +linkgit:gitignore[5].
>
> A reader of git-add shouldn't have to refer to gitrepository-layout[5]
> in the first place when we talk about "add $pathspec" may ignore
> paths that are configured to be ignored.  gitignore[5] should give
> everything necessary to him.

True. Now that 5/8 makes the details in gitignore clearer it should be 
OK to change from linking repository layout to the gitignor page.
>
> This section (even before the precontext we can see in the patch)
> may need a bit larger rewrite so that it just refers to gitignore[5]
> and leave the details of where the exclude information comes to that
> manual page.

I'll see if I can do something on that as a separate patch.

Philip 
