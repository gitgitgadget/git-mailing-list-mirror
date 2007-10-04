From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths at all.
Date: Wed, 3 Oct 2007 21:10:44 -0400
Message-ID: <3620711B-6F47-4F84-83A0-78F5BF9CBE88@silverinsanity.com>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org> <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr> <7vejgbdbyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 03:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdFEe-0006b9-46
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 03:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbXJDBKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 21:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbXJDBKb
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 21:10:31 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52525 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbXJDBKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 21:10:30 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 982451FFC013;
	Thu,  4 Oct 2007 01:10:29 +0000 (UTC)
In-Reply-To: <7vejgbdbyn.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59914>


On Oct 3, 2007, at 7:18 PM, Junio C Hamano wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>
>> @@ -507,6 +510,7 @@ ifeq ($(uname_S),Darwin)
>>  			BASIC_LDFLAGS += -L/opt/local/lib
>>  		endif
>>  	endif
>> +        NO_RPATH = YesPlease
>>  endif
>
> I'll let Darwin users to fight the defaults for this part out.

It makes sense, since Apple's gcc/ld/dyld doesn't use rpath.

~~ Brian
