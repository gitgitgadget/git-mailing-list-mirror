From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 05 Dec 2010 12:06:39 -0800
Message-ID: <7v4oasvvao.fsf@alter.siamese.dyndns.org>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <4CFBA912.2080905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Dec 05 21:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPKrG-00072b-72
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 21:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0LEUGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 15:06:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab0LEUGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 15:06:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE8D73560;
	Sun,  5 Dec 2010 15:07:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nt1yhAfr4YGZtb+8SK3F1Slg3as=; b=Qvnswu
	fDMJgwsDIE36cet+yzjzX7TkJGolMNO0oodyZBdig4Y3YyKBN12woriDBMlsanfL
	IimpiUqwemwUN59gp33i02SrEIgLTsEe+vUD6fK8sbMTlSz4tqpPp0+WMfNpf/K6
	cCoZi91ojmnNQbGwkF532f1eB+GKoBX/70Sgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jVMmQqNyKkssII55dZMh9AOaXBYKGtYE
	9qJPbsTvVaAOWYIpn2eAav/aQBv8B3bs06uYEHYGZ0uOXdZuHDIiu9zytJlskClY
	kpDaYiskolEXeu9WqjmrXeEkbD5KkeTgSHN4ehsp/fch1KSilVM7AfU5ZXcRRUY3
	slcliQTGUOA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A8F0355D;
	Sun,  5 Dec 2010 15:07:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2045355B; Sun,  5 Dec 2010
 15:07:02 -0500 (EST)
In-Reply-To: <4CFBA912.2080905@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sun\, 05 Dec 2010 16\:00\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B4ACED2-00AB-11E0-9E77-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162958>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 05.12.2010 07:30:
> ...
>> 
>> * mg/cvsimport (2010-11-28) 3 commits
>>  - cvsimport.txt: document the mapping between config and options
>>  - cvsimport: fix the parsing of uppercase config options
>>  - cvsimport: partial whitespace cleanup
>> 
>> I was being lazy and said "Ok" to "cvsimport.capital-r" but luckily other
>> people injected sanity to the discussion.  Weatherbaloon patch sent, but
>
> I assume I should try and not read too much into this...

No, you shouldn't.  I wasn't questioning _your_ sanity, and if you took it
that way, I apologize.

I as the maintainer have different priority from contributors.  The
contributed patches want to "get the job done" first, and their solution
only need to be "correct and not too ugly".

I however in addition need to make sure that the changes make sense in the
longer term, and my saying "Ok" to "capital-r" instead of rejecting the
patch totally went against that obligation of mine.  I'll have a hard time
justifying why users need to type that long string that does not convey
much information in three months.  It was _my_ temporary insanity that
came from fatigue.

So an weatherbaloon patch was sent as a counterproposal, which I think it
shows the best course of action given the existing constraints, but there
may be better ones.  If you agree, and if you have time and inclination, a
reroll in that direction would be appreciated.  And it does not have to be
you but others on the list.
