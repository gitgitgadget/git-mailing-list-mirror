From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH/RFC] Make help behaviour more consistent
Date: Mon, 11 Mar 2013 21:06:33 -0000
Organization: OPDS
Message-ID: <CD3017A6746B45FE8A5F242E4C597B51@PhilipOakley>
References: <1362937729-9050-1-git-send-email-kevin@bracey.fi> <vpq620yfj6g.fsf@grenoble-inp.fr> <7vppz592v5.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Kevin Bracey" <kevin@bracey.fi>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 22:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF9vs-00089g-16
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 22:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab3CKVG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 17:06:29 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:29161 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752738Ab3CKVG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 17:06:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuQKAItEPlFZ8rke/2dsb2JhbABDjWe2egEDAYFeF3SCJAUBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYBEggCAQIDAYgGCL9SjgAHHmmCZmEDiDyFaIlPj1eBL4FbPA
X-IronPort-AV: E=Sophos;i="4.84,825,1355097600"; 
   d="scan'208";a="65296296"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip07ir2.opaltelecom.net with SMTP; 11 Mar 2013 21:06:27 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217909>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, March 11, 2013 7:02 PM
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Kevin Bracey <kevin@bracey.fi> writes:
>>
>>> Two significant usability flaws here:
>>>  - If using man, "man git" to side-step "git help" is obvious. But 
>>> if
>>>    trying to use help.format=web, how to get the root html page? My
>>>    technique was "git help XXX" and click the "git(1) suite" link at 
>>> the
>>>    bottom. "git help git" is non-obvious and apparently undocumented
>>>    (it's not mentioned by "git", "git help", or "git help help"...).
>>
>> Can't this be solved by adding something like
>>
>>   See 'git help git' for general help about Git.
>>
>> to the output of "git help"? I think the fact that "git help" 
>> provides a
>> small amount of output (typically: fits on one screen) is a nice 
>> feature
>> that avoids scaring people too early with the actual doc.
>
> That sounds like a good direction to go in.

My earlier attempt, and Junio's reply 
http://thread.gmane.org/gmane.comp.version-control.git/217352

It is tricky making sure that the message covers help for git, help's 
own help,
the guides, and the commands, all in one compact usage line, while also
covering the -h and --help options (which may not be known to new Git
users on Windows, though probably obvious to Linux/Unix users).

Philip 
