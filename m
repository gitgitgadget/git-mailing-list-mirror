From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Sat, 20 Jul 2013 21:01:58 +0100
Message-ID: <51EAECB6.4000807@ramsay1.demon.co.uk>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org> <51E436B5.6000303@ramsay1.demon.co.uk> <7v38ray18w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 15:08:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0tN1-0003fB-8s
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 15:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab3GUNIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 09:08:11 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:48229 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755206Ab3GUNIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 09:08:10 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id DC1ECA643DD;
	Sun, 21 Jul 2013 14:08:09 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 099DEA6462F;
	Sun, 21 Jul 2013 14:08:09 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 21 Jul 2013 14:08:08 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7v38ray18w.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230935>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Junio C Hamano wrote:
>> [ ... ]
>>> * rr/send-email-ssl-verify (2013-07-06) 6 commits
>>>  - SQUASH??? update to support SSL_ca_file as well as SSL_ca_path
>>>  - SQUASH??? send-email: cover both smtps and starttls cases
>>>  - fixup! send-email: squelch warning from Net::SMTP::SSL
>>>  - SQUASH??? send-email giving default value to ssl-cert-path with ||= assignment
>>>  - send-email: introduce sendemail.smtpsslcertpath
>>>  - send-email: squelch warning from Net::SMTP::SSL
>>>
>>>  The issue seems a lot deeper than the initial attempt and needs
>>>  somebody to sit down and sort out to get the version dependencies
>>>  and lazy loading right.
>>
>> This causes test failures for me, since send-email can't load the
>> IO/Socket/SSL.pm module. (on Linux, cygwin and MinGW!)
> 
> Good ;-).
> 
> Can you try the more recent 'pu' with 35035bbf (send-email: be
> explicit with SSL certificate verification, 2013-07-18) that was
> updated with help from Brian Carlson?

Yes, this works fine now. I tested on Linux and cygwin. (I haven't had
time to test on MinGW, but I don't expect any problems.)

Thanks

ATB,
Ramsay Jones
