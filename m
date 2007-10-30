From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 07/10] push: use same rules as git-rev-parse to resolve refspecs
Date: Tue, 30 Oct 2007 09:49:23 +0100
Message-ID: <13414001-D708-41E2-A35B-FDBB1103F1AC@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <7v3avtngzc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Immoi-0005yY-Gt
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbXJ3IvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbXJ3IvF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:51:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:39381 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbXJ3IvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:51:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9U8lv9s028868;
	Tue, 30 Oct 2007 09:49:42 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9U8luVU016749
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 30 Oct 2007 09:47:57 +0100 (MET)
In-Reply-To: <7v3avtngzc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 30, 2007, at 9:28 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> This commit changes the rules for resolving refspecs to match the
>> rules for resolving refs in rev-parse. git-rev-parse uses clear rules
>> to resolve a short ref to its full name, which are well documented.
>> The rules for resolving refspecs documented in git-send-pack were
>> less strict and harder to understand. This commit replaces them by
>> the rules of git-rev-parse.
>>
>> The unified rules are easier to understand and better resolve  
>> ambiguous
>> cases. You can now push from a repository containing several branches
>> ending on the same short name.
>
> As you introduced long names around 5/10 to have two different
> ones for clarity with the goal of unifying them, so once you
> unified the rules, it probably is a good idea to rename the long
> "do_this_with_X_rule()" and "do_this_with_Y_rule()" functions
> back to "do_this()", isn't it?

Absolutely.

But I'm not sure if I'm the one who unifies them.

	Steffen
