From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I delete a remote branch with a period in the name?
Date: Tue, 03 Jul 2012 12:39:45 -0700
Message-ID: <7vehosvdku.fsf@alter.siamese.dyndns.org>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <m23959e0qp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "jonsmirl\@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm8wz-0000EF-JC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032Ab2GCTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:39:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49122 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212Ab2GCTjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:39:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2911D8AE3;
	Tue,  3 Jul 2012 15:39:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fqreR5JF2V0Mnq77lhLRIV1XJCI=; b=Sdk5uF
	Knzgzxq0L90udYbdurSVYGpH9haTrvAja+d9DzWGVTGmbQ6dTDxGogdqZIVD2mQc
	WJjhuRb19XAyEhVdwjTgwL3Vf0eNqNuoWR4pvRkC5Cn2n5MDOM13flf9/FXubiZY
	B9E+57vzGpvroee7XY213dfaenxazufUh9UUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IebaTKOmldiE0B2xNktCpb0A9kl7Nea2
	Xk2OFIVxSug6sny6CZRd2rDmk0jr7tNFHowyWRN04z7dRzyGXRNoRsLfh8Zn0RnS
	ATe4Ndb9WiZcK4q0M5elqtl5A7OK/LKDyJs/s081H8HM7X3FMLps68Fk9VEfauJJ
	e/6HyxQfxIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F2E28AE2;
	Tue,  3 Jul 2012 15:39:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F0458AD0; Tue,  3 Jul 2012
 15:39:46 -0400 (EDT)
In-Reply-To: <m23959e0qp.fsf@igel.home> (Andreas Schwab's message of "Tue, 03
 Jul 2012 09:56:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8599D0A-C546-11E1-9B3B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200938>

Andreas Schwab <schwab@linux-m68k.org> writes:

> "jonsmirl@gmail.com" <jonsmirl@gmail.com> writes:
>
>> jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git push origin :fl.stg
>> error: unable to push to unqualified destination: fl.stg
>> The destination refspec neither matches an existing ref on the remote nor
>> begins with refs/, and we are unable to guess a prefix based on the source ref.
>> error: failed to push some refs to 'git@github.com:jonsmirl/lpc31xx.git'
>> jonsmirl@smirl2:/home/apps/florida/lpc31xx$
>>
>> jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git branch -r
>>   linus/master
>>   origin/HEAD -> origin/master
>>   origin/bar.stgit
>>   origin/dt-test
>>   origin/fl.stgit
>>   origin/foo.stgit
>>   origin/lpc313x-stg
>>   origin/lpc313x-stg.stgit
>>   origin/master
>>   origin/master.stgit
>>   origin/temp.stgit
>>   origin/v3.4-stg
>>   origin/v3.4-stg.stgit
>>   origin/v3.5-stg
>>   origin/v3.5-stg.stgit
>
> There doesn't appear to be a remote branch with that name.

More importantly, there was nothing in Jon's message to convince us
that "branch -r" outputis telling us the current state of the
remote.  Showing "ls-remote" output would have been better.
