From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Fri, 18 Sep 2015 09:10:08 +0200
Message-ID: <vpqoah0kxtb.fsf@anie.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
	<20150917213619.GI17201@serenity.lan>
	<xmqq37ycitps.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 09:10:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcpos-0005Da-L5
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 09:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbIRHKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 03:10:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52952 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbbIRHKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 03:10:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8I7A8pq019959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 09:10:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8I7A8Xl004922;
	Fri, 18 Sep 2015 09:10:08 +0200
In-Reply-To: <xmqq37ycitps.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 17 Sep 2015 15:09:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 09:10:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8I7A8pq019959
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443165010.06409@WgjKNqaS3IXFYbXfGrbQ9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278180>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>>> +--[no-]merged [<commit>]::
>>
>> We prefer to write --[no-]* as:
>>
>> 	--option::
>> 	--no-option::
>>
>> although this may be the first instance that we see this combination
>> with an argument.
>>
>> I also found the "[<commit>]" syntax confusing and had to go and figure
>> out what PARSE_OPT_LASTARG_DEFAULT does; I wonder if it's worth
>> appending something like the following to the help for this option:
>>
>> 	The `commit` may be omitted if this is the final argument.
>
> "may be omitted" must be followed by a description of what happens
> when omitted (i.e. "defaults to ...").

Then:

The `commit` may be omitted and defaults to HEAD if this is the final
argument.

Sounds good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
