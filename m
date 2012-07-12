From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mini bug report origin/pu: t1512 failed on Mac OS X (commit 
 957d74062c1f0e ?)
Date: Thu, 12 Jul 2012 09:58:55 -0700
Message-ID: <7vy5moc3w0.fsf@alter.siamese.dyndns.org>
References: <4FFDDD5E.3080309@web.de>
 <7vipdtdhla.fsf@alter.siamese.dyndns.org>
 <7va9z5dgff.fsf@alter.siamese.dyndns.org> <4FFE7AEA.6060001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:59:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpMjL-0000IQ-NK
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 18:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934127Ab2GLQ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 12:58:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934096Ab2GLQ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 12:58:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83BE6795F;
	Thu, 12 Jul 2012 12:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+nYtrW0cYdycdKP6NH057bEycWo=; b=pmOnTH
	YRkWYrW3nEcI39bfUbA1wzrxoSrBTF7J2bKTLoKV6pNncAKwUEUrg7D1Vezvtg3Q
	8xqgqlsuW2e7iHpfmLGlPjgqiC6k+d8+strut4XpnB7rSQGOpezin/J2H0WR2nAc
	blNaid6KXcOERCaYCWh+S4bDeqfR0ljtkOnFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FkyVe1ZWyMWPxlATrsGZ3X0dprb7Jrpl
	VDJ9TMb+5apfut8jUcx+L4cvEmVd5Tq558nR9lWhMFCI3w9isuN3I9JuFEPiQWa7
	6uORiyyRVFVrLLEgQinsoUuCDzQtaSAuzONY4WHnsWxNmdTSZKgzWhlqkEWXBGQd
	4hVujMzySA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79CD2795E;
	Thu, 12 Jul 2012 12:58:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12CF4795C; Thu, 12 Jul 2012
 12:58:56 -0400 (EDT)
In-Reply-To: <4FFE7AEA.6060001@viscovery.net> (Johannes Sixt's message of
 "Thu, 12 Jul 2012 09:21:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE834976-CC42-11E1-8FCE-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201365>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/12/2012 1:30, schrieb Junio C Hamano:
>> -	test "$(wc -l <actual)" = 16 &&
>> +	test $(wc -l <actual) = 16 &&
>
> We have a helper function for this:
>
> 	test_line_count = 16 actual &&

OK.
