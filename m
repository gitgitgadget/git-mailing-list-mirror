From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 7/8] Doc clean: add See Also links
Date: Mon, 17 Sep 2012 23:19:33 +0100
Organization: OPDS
Message-ID: <E8ECAAA8437C417DA26A2BD673D54903@PhilipOakley>
References: <1347793083-4136-8-git-send-email-philipoakley@iee.org> <vpqsjaiyxth.fsf@grenoble-inp.fr> <7vboh5xmyn.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "gitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDjfB-0003Ki-Em
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab2IQWTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:19:25 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:62836 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756741Ab2IQWTY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 18:19:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At8KAAqhV1BZ8rU+/2dsb2JhbABFi0avWgJ/gQiCGwUBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBgESCAIBAgMBh3O6UY0JHSKDYWADiCGFRJgegmc
X-IronPort-AV: E=Sophos;i="4.80,438,1344207600"; 
   d="scan'208";a="393834028"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip05ir2.opaltelecom.net with SMTP; 17 Sep 2012 23:19:22 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205762>

From: "Junio C Hamano" <gitster@pobox.com>
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Philip Oakley <philipoakley@iee.org> writes:
>>
>>> --- a/Documentation/git-clean.txt
>>> +++ b/Documentation/git-clean.txt
>>> @@ -63,6 +63,12 @@ OPTIONS
>>>  Remove only files ignored by git.  This may be useful to rebuild
>>>  everything from scratch, but keep manually created files.
>>>
>>> +SEE ALSO
>>> +--------
>>> +linkgit:gitignore[5]
>>> +linkgit:gitrepository-layout[5]
>>> +The optional configuration variable `core.excludesfile` 
>>> linkgit:git-config[1]
>>
>> I think linkgit:gitignore[5] is enough. 
>> linkgit:gitrepository-layout[5]
>> is a very general documentation, it's not clear to the reader which 
>> part
>> is intended to be read in complement to git-clean, and indeed, the
>> relevant information is already in linkgit:gitignore[5]. Same for
>> core.excludesfile which is already documented in 
>> linkgit:gitignore[5].
>>
>> Otherwise, I suspect we'll end-up having the transitive closure of 
>> SEE
>> ALSO in each manpage ...
>
> Concurred.  Thanks.
> --
The improved layout of gitignore in patch 5/8 should cover it. The three 
links came about because of the initial 'git add' patch 6/8.

I'll update (though probably tomorrow night..). 
