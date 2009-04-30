From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/6] Re: cleanups for git-send-email
Date: Thu, 30 Apr 2009 10:11:15 +0200
Message-ID: <49F95D23.3050101@op5.se>
References: <7vws939skl.fsf@gitster.siamese.dyndns.org> <20090429194852.0976257034@viridian.itc.Virginia.EDU> <20090429222711.GC12908@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Pemberton <wfp5p@viridian.itc.Virginia.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:11:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzRMg-0006ZL-7c
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZD3ILX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZD3ILV
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:11:21 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50359 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbZD3ILT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 04:11:19 -0400
Received: by fxm2 with SMTP id 2so1655275fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 01:11:17 -0700 (PDT)
Received: by 10.86.1.1 with SMTP id 1mr1595191fga.0.1241079077539;
        Thu, 30 Apr 2009 01:11:17 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm6528110fgb.12.2009.04.30.01.11.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 01:11:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090429222711.GC12908@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117998>

Nicolas Sebrecht wrote:
> On Wed, Apr 29, 2009 at 03:48:51PM -0400, Bill Pemberton wrote:
> 
>> Again, it prevents bugs.  People use "and" vs "&&" as the same thing,
>> when they are not.  The have different precedence in perl.
> 
> I agree with you except that the chapter 4.16 from the Perl Best
> Practices book does not apply here. FMPOV, we don't really mix booleans
> because the precedence is explicitly given by the parentheses.
> 
> [ Notice _how_ the author raises the ambiguity to explain his point in
>   the book: he uses parentheses. ]
> 
>> For example, 
>>
>> next if not $finished || $x < 5;
>> next if !$finished || $x < 5;
>>
>> do not mean the same thing.
> 
> True. But the lines we are talking about are different. We have:
> 
> 	next if ($finished or $x < 5);
> 
> If we add a "not"/"!" or append a "&&"/"and" - or whatever -, we do know what will
> be evaluated easily:
> 
> 	next if !($finished or $x < 5);
> 
> looks rather different from
> 
> 	next if (!$finished or $x < 5);
> 

I'm rather clueless when it comes to perl coding, but I know what I
don't know, so I've got enough sense to look these things up whenever
I have to hack some perl. I hope others do the same.

Personally, I've found that never using 'or', 'not' or 'and', and
overparenthesize when I'm uncertain seems to work rather nicely,
even though perl gurus would probably shunt my code as overly explicit.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
