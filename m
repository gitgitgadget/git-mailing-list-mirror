From: Andreas Ericsson <ae@op5.se>
Subject: Re: Tilde spec - befuzzled
Date: Wed, 29 Feb 2012 10:30:23 +0100
Message-ID: <4F4DF02F.5050609@op5.se>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se> <87zkc38a3v.fsf@thomas.inf.ethz.ch> <7vaa42zrw8.fsf@alter.siamese.dyndns.org> <CAH5451m=6XhRj1osN_Dw7zKvAW-jtru+EbCkRvo8aNRMbJS6bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2fro-0007wp-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab2B2Jaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:30:30 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59966 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932108Ab2B2Ja0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 04:30:26 -0500
Received: by lahj13 with SMTP id j13so3328532lah.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 01:30:24 -0800 (PST)
Received-SPF: pass (google.com: domain of exon@op5.com designates 10.112.101.10 as permitted sender) client-ip=10.112.101.10;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of exon@op5.com designates 10.112.101.10 as permitted sender) smtp.mail=exon@op5.com
Received: from mr.google.com ([10.112.101.10])
        by 10.112.101.10 with SMTP id fc10mr9228381lbb.63.1330507824712 (num_hops = 1);
        Wed, 29 Feb 2012 01:30:24 -0800 (PST)
Received: by 10.112.101.10 with SMTP id fc10mr7708606lbb.63.1330507824607;
        Wed, 29 Feb 2012 01:30:24 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id f2sm25234049lbw.5.2012.02.29.01.30.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 01:30:23 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <CAH5451m=6XhRj1osN_Dw7zKvAW-jtru+EbCkRvo8aNRMbJS6bA@mail.gmail.com>
X-Gm-Message-State: ALoCoQnaiBelx/OsvmufBGVP45QR2ZKsKsBfo1EY6mTop5EcwQBhO6S+Wls5FefbOWdlOKyXDfNq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191826>

On 02/29/2012 02:18 AM, Andrew Ardill wrote:
> On 29 February 2012 06:20, Junio C Hamano<gitster@pobox.com>  wrote:
>> Thomas Rast<trast@inf.ethz.ch>  writes:
>>
>>>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>>>>> A suffix '{tilde}<n>' to a revision parameter means the commit
>>>>> object that is the<n>th generation grand-parent of the named
>>>>> commit object, following only the first parents.
>>>>>
>>>>> Hang on, *grand*-parents?
>>>>> ...
>>>
>>> Perhaps we should reword it as "n-th first-parent ancestor"?  Barring
>>> confusion about the position of the dashes, that leaves little room for
>>> error.
>>
>> I think we could either go "easier to read but not precise"
>>
>>         ... that is the<n>th generation (grand-)parent of ...
>>
>> or "may sound scary but correct"
>>
>>         the ancestor reached by walking the first-parent chain<n>  times
>>
>> I am not sure which bucket "n-th first-parent ancestor" falls into.
> 
> The terms might be too technical, however my understanding was that
> HEAD^n takes<n>  steps along a breadth-first traversal of the commit
> tree rooted at HEAD, while HEAD~n uses a depth-first traversal.
> 
> A better form for the description might come from that formulation of
> the process, rather than the 'generational' formulation.
> 

I doubt it. Most non-programmers have no notion of the difference
between breadth-first and depth-first. You have to work with trees 
or graphs in some form before breadth and depth become intuitive
to read in tech docs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
