From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Thu, 14 Apr 2011 12:14:59 -0700
Message-ID: <7vmxjshcgc.fsf@alter.siamese.dyndns.org>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org>
 <m362qg3c5j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:15:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAS0e-00067K-0B
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933995Ab1DNTPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:15:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492Ab1DNTPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:15:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D3614706;
	Thu, 14 Apr 2011 15:17:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s4IkoN4jJWnWQSkqJxn1pgy8tFw=; b=ZmYFEB
	feHjtW14lpr+s1ZMU8JI/YKWzyr/ZBL/yHn9v955Eh4JPlvHNiA+Nl47KmyiY0NT
	DuQ+HVh+G93ReXc//tMUD9qhnjd0zNWQdj2nSAnIDu0J/Y+ilOSvwzWt6FuSJQD0
	K7QF08K8rcbplw67WeyhuHyfEvntsRNsUGGjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XpJpM13gL8+Ba6LK6kSuXp0mNmzxFlpe
	CtDwHzNeKGMzbbcj6awtpQkb8O1ZQ4rameVW1TJ0A8guLIOKDDWYy+PTDPJ7Gk1U
	CpMLcf6q740t27nb6t2u8wUjE2e2hPHN9hGFHPcrIUWaZOJngbTuz5kJ7wi2e70t
	WK9nMO9mbXY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE8494700;
	Thu, 14 Apr 2011 15:17:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 59F3546FB; Thu, 14 Apr 2011
 15:17:00 -0400 (EDT)
In-Reply-To: <m362qg3c5j.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 14 Apr 2011 11:46:07 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7E20406-66CB-11E0-9C21-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171535>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> --------------------------------------------------
>> [Stalled]
>
>> * jh/gitweb-localtime (2011-03-23) 1 commit
>>  - gitweb: javascript ability to adjust time based on timezone
>> 
>> Re-roll posted on the list, but I haven't picked it up.
>
> Should I post v2 of re-roll, or wait for after 1.7.5?

Either way would work for me.

It is unlikely that I'll be reviewing and commenting on the topic very
much either before or after the release, but sending a v2 to the list
would give the stakeholders in gitweb a chance to review and comment on
the more recent version, and that can happen regardless of 1.7.5 schedule.
