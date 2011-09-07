From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Thu, 8 Sep 2011 00:01:45 +0100
Organization: OPDS
Message-ID: <33309DB6F935472497D9790A26046452@PhilipOakley>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com> <4E6769E3.4070003@drmicha.warpmail.net> <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Kyle Neath" <kneath@gmail.com>,
	"Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 01:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1RLv-00042Y-6f
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 01:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab1IGXQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 19:16:12 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:38872 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755582Ab1IGXQM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 19:16:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAGz2Z05cHIS4/2dsb2JhbABDiiGdUHmBQQEEAQEFCAEBLh4BASELAgMFAgEDDgcDCSUUAQQIEgYHFwYBEggCAQIDAYdcCrdrhgtgBIc9lXiHFA
X-IronPort-AV: E=Sophos;i="4.68,347,1312153200"; 
   d="scan'208";a="511614441"
Received: from host-92-28-132-184.as13285.net (HELO PhilipOakley) ([92.28.132.184])
  by out1.ip06ir2.opaltelecom.net with SMTP; 08 Sep 2011 00:01:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180926>

From: "Kyle Neath" <kneath@gmail.com>
> Junio C Hamano <gitster@pobox.com> wrote:
>> If this were a new, insignificant, and obscure feature in a piece of
>> software with mere 20k users, it may be OK to release a new version with
>> the feature in an uncooked shape.
>
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> So, it's been a year or more that you've been aware of the importance of
>> this issue (from your/github's perspective), and we hear about it now,
>> at the end of the rc phase.
>
> I apologize if it sounds like that. I've been discussing this situation 
> with
> many people (including Jeff King) for a very long time now, and it was my
> understanding that the credential caching was done and simply waiting for 
> a
> new release. This is the first I've heard that it will not be included in
> 1.7.7, so I'm voicing my opinion now. Admittedly, late in the game - and I
> apologize for that.
>
> I'd be happy to help in any capacity I can. Unfortunately I'm no C hacker, 
> and
> I've accepted that as a character flaw (it's something I'm working on). 
> I'm
> afraid I can't be of much help with the actual code. What I can provide is 
> an
> alternate viewpoint to the core team. A viewpoint of someone who's spent 3
> years trying to make git easier for newcomers.

Help in any capacity :
Would it not be possible for GitHub to provide for those key users such a 
trial version
that includes the patches identified to obtain the "real-world success 
reports" that
are needed, as mentioned in the "Re: What's cooking in git.git (Aug 2011, 
#07; Wed, 24)"

This should help satisfy the needs from both sides, even if you can only 
push it to a few clients.

>>What's cooking in git.git (Aug 2011, #07; Wed, 24)
>> Looked mostly reasonable except for the limitation that it is not clear
>> how to deal with a site at which a user needs to use different passwords
>> for different repositories. Will keep it in "next" at least for one 
>> cycle,
>> until we start hearing real-world success reports on the list.
