From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 11:12:16 -0800
Message-ID: <7vbodsmr1r.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
 <7vhanlnnz7.fsf@alter.siamese.dyndns.org> <50CED5D4.5040705@viscovery.net>
 <7vk3shm5d5.fsf@alter.siamese.dyndns.org> <50CEDF0A.7040603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:12:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkg7D-0001I2-8m
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 20:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab2LQTMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 14:12:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766Ab2LQTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 14:12:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1466A92B2;
	Mon, 17 Dec 2012 14:12:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pNTRhlMG1qKN2JtEaz0bms7bMPg=; b=XO4xCR
	sluqNpKgUbtyM1ziQHx4MlJE1hX3YUuaSKRoeCywqvyflRhY6IoGWhqzjMSeR2B9
	59KGXp73whSirlFH2lSu8ADDBMfR/JDP5h6w3D8Rm4ilcKxvbd8SptLKxJ4j74bA
	y3LGjmKOEhE49eLxvXzEHKbI3Au5SZ2X6+Uk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMAKm19mk7LnyiO8xT/bZ3wdAIItJ4G6
	JEDba4mFALiDgLtIjkTQtgZr8XzGgDgKH5gz4WriqapjjuKRGBMAD0nDP35MdMcO
	GNL2P6ZZcIspKESjnuyLzQ/Y9w6KAnoxS7sg4Pb1jFcmY7SU04cs3d9GDo3/ioxX
	cP4XpXIXaIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01E4992B1;
	Mon, 17 Dec 2012 14:12:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5015F92AD; Mon, 17 Dec 2012
 14:12:18 -0500 (EST)
In-Reply-To: <50CEDF0A.7040603@viscovery.net> (Johannes Sixt's message of
 "Mon, 17 Dec 2012 09:59:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACEA9614-487D-11E2-BC62-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211691>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 12/17/2012 9:48, schrieb Junio C Hamano:
>> Here is what I tentatively have ...
>
> Thanks!
>
>> -'git checkout' [--detach] [<commit>]::
>> +'git checkout' --detach [<commit>]::
>> +'git checkout' <commit>::
>>  
>> -	Update the index and working tree to reflect the specified
>> -	commit and set HEAD to point directly to <commit> (see
>> -	"DETACHED HEAD" section.)  Passing `--detach` forces this
>> -	behavior even if <commit> is a branch.
>> +	Prepare to work on building new history on top of <commit>,
>> +	by detaching HEAD at the commit (see "DETACHED HEAD"
>> +	section), and updating the index and the files in the
>> +	working tree.  Local modifications to the files in the
>> +	working tree are kept, so that they can be committed on the
>> +	<branch>.
>
> The last half-sentence should better be removed.

True; we do not have a particular "on the <branch>" in this state.
At least, "on the <branch>" needs to be removed.  But I think we may
want a more different wording here, including the earlier "work on
building new history on top of" part.

The detached HEAD state primarily is a sightseeing mode, where the
user is expected to view but not touch.  Even for experienced users,
commits on a detached HEAD are for keeping snapshots of interim
states during a throw-away experiment, so the purpose of detaching
is not exactly "to work on *building* new history" in the first
place.

Carefree experimentation is encouraged by not forbidding commmits
from this state, with the expectation that:

 (1) if it does not lead to interesting result, another "git
     checkout <branch>" will wipe the throw-away experiment without
     affecting any of your more important branches; and

 (2) an experiment that yielded something useful can be further
     polished on a concrete branch by "git checkout -b <newbranch>".

I think the above discussion on detached HEAD can be added to its
own section.

	Prepare to work on top of <commit>, by detaching HEAD at it
	(see "DETACHED HEAD" section), and updating te index and the
	files in the working tree.  Local modifications to the files
	in the working tree are kept, so that the resulting working
	tree will be the state recorded in the commit plus the local
	modifications.

Or something, perhaps?
