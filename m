From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #04; Tue, 11)
Date: Tue, 11 Jun 2013 16:40:47 -0700
Message-ID: <7vli6g5i80.fsf@alter.siamese.dyndns.org>
References: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
	<CAMP44s0MmiyWX95HGh52FiQ46n2BB_Onzt-71dYYJCyYZHoHFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 01:41:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYBL-0001Q7-5R
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 01:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab3FKXkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 19:40:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642Ab3FKXku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 19:40:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7540E279C0;
	Tue, 11 Jun 2013 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6atzct94RsCTtU4/1k15QheaYQI=; b=SgMHFK
	+Y7Rpf+pPrlHdU0ftMVEur/bi3JvdSrJh86tyF6mwdS2Q+rYtgOBL4Yex5jWIPLr
	HR4IlOGCnFaZFeZoJ8N4k1+G2b8pXwUaZFLb2pNQwVUsZMfkE0oEAETiQPOos2Ew
	UYYtciNWBmOAUIgoXW/QcL2cD5UtKbXxlZjIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BbP9ZY8bytfS5lzEUsvjdKUwePcM588e
	yufdH2knPXPrksN+UHN7Q+AgCzqODa8HcmE8DMhND0fOL8jerzjpaOEs24GVXGyX
	IsmMBN4TecjrTR4rBb0eESSf7doIfvWp4kRL6g4gpp8BBZLDC4gN3KVd69AyIlBS
	TkicmpgZE8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CD9D279BF;
	Tue, 11 Jun 2013 23:40:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA653279BE;
	Tue, 11 Jun 2013 23:40:48 +0000 (UTC)
In-Reply-To: <CAMP44s0MmiyWX95HGh52FiQ46n2BB_Onzt-71dYYJCyYZHoHFQ@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 11 Jun 2013 18:24:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5839215A-D2F0-11E2-B0B9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227577>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Jun 11, 2013 at 5:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
>>  - remote-helpers: add exec-path links
>>  - remote-helpers: allow direct test execution
>>  - remote-helpers: rename tests
>>  - remote-helpers: generate scripts
>>
>>  I do not particularly think the second from the bottom is a good
>>  change, but it takes the remainder of the series hostage.
>>
>>  Waiting for a reroll.
>
> Waiting for a reroll? This is the first time I hear you are not going
> to merge these.
>
> You say actions have consequences... well, you are right, you can stop
> waiting for a reroll.

It has been listed in that state in the previous issue #03 as well.
And if you do not want to reroll, that is fine.  We can discard it
for now and the next person who finds the need to can redo the
change.

Will discard the topic, then.
