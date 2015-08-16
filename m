From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 0/1] handling mistranslation reports
Date: Sun, 16 Aug 2015 19:54:27 +0100
Organization: OPDS
Message-ID: <134837D8A3EE41ECBE65D228CC57818B@PhilipOakley>
References: <1438640973-1452-1-git-send-email-philipoakley@iee.org> <CANYiYbEKoF6GhezPmR1fGxRqTvZAE4L2xguvvwFEWqWBkOp9tw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Jiang Xin" <worldhello.net@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jiang Xin" <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 20:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR33q-00079A-OK
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 20:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbbHPSxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 14:53:18 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:16842 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864AbbHPSxR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2015 14:53:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BhFQCa29BVPKizYwJdGQGDAVRpgySEG7gjhW8EBAKBI00BAQEBAQEHAQEBAUEkG4QeBgEBBAgBARkVHgEBIQsCAwUCAQMOBwUCBSECAhQBBAgSBgcDFAYTCAIBAgMBiAgDFgm4e4ZYiQoNhVcBCxwEgSKKMIEjgSyBVxEBUYJwL4EUBZUdAYESg3GFe4M3h0WJYoNPg2eEJD0zgQ6BPgEBAQ
X-IPAS-Result: A2BhFQCa29BVPKizYwJdGQGDAVRpgySEG7gjhW8EBAKBI00BAQEBAQEHAQEBAUEkG4QeBgEBBAgBARkVHgEBIQsCAwUCAQMOBwUCBSECAhQBBAgSBgcDFAYTCAIBAgMBiAgDFgm4e4ZYiQoNhVcBCxwEgSKKMIEjgSyBVxEBUYJwL4EUBZUdAYESg3GFe4M3h0WJYoNPg2eEJD0zgQ6BPgEBAQ
X-IronPort-AV: E=Sophos;i="5.15,690,1432594800"; 
   d="scan'208";a="797284068"
Received: from host-2-99-179-168.as13285.net (HELO PhilipOakley) ([2.99.179.168])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Aug 2015 19:53:14 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276021>

From: "Jiang Xin" <worldhello.net@gmail.com>
> 2015-08-04 6:29 GMT+08:00 Philip Oakley <philipoakley@iee.org>:
>> Hi Jiang,
>>
>> This is my updated patch based on your feedback at $gmane/275141
>> and $gmane/275142.
>>
>> I've used most of your wording, though have retained a comment on
>> considering if the translation could be held here.
>>
>> My original commentary is below, along with the inter-diff between 
>> versions.
>>
>> -
>> Recently, on the 'Git for human beings' list, a user reported a
>> mistranslation and asked if/what could be done, with a suggested
>> alternate text [1].
>>
>> I pointed the user at the po/README for general guidance.
>> Unfortunately the user was noting a Spanish (es) translation error 
>> which
>> is not held in your tree, but the README does include how to start a 
>> new
>> translation. This led to a misunderstanding with regard to which 
>> aspect
>> of the README was being referred to (private discussion with Junio).
>>
>> This patch separates out the three different aspects that caused 
>> confusion
>> and explicitly brings out what to do for translations not currently 
>> held here.
>>
>> I hope my suggested patch will fit with your approach and ask for 
>> comments
>> (or Ack / Nack).
>>
>> regards
>>
>> Philip
>>
>> [1] https://groups.google.com/forum/#!topic/git-users/rK5oU6k8Tzw
>>
>> Interdiff:
>
> The subject is "[PATCH v2 0/1]" and I wonder where is the real patch
> file ("v2 1/1")
> aside of this  cover letter.

Yes 0/1 was the cover letter and 1/1 was the actual patch.

I have not found a way of sending, via my 'git send-email' (*), a single 
patch with its  integrated cover-letter at the beginning. I can easily 
add short notes after a 3-dashes in the commit, but it is not the same 
as a cover-letter ...

Hopefully, you got the 1/1. Unfortunately, the Git list is rejecting my 
patches (and just my patches), as sent via send-email, and at the moment 
I have no way of debugging and diagnosing that issue.

>But today I have time to read it
> carefully, and I know
> this is a fixup commit.
>
> I squash this reroll to last commit for this series, and simplify both
> the commit
> and the commit log.  See patch v3 in the next email.

Thanks. Will review.

>
> -- 
> Jiang Xin
> --
(*) https://groups.google.com/forum/#!topic/msysgit/U85cSXd-Uv0 
