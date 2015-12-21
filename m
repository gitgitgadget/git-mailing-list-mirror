From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFPR] updates for 2.7?
Date: Mon, 21 Dec 2015 08:57:44 -0800
Message-ID: <xmqqvb7rhh87.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwnjcnrb.fsf@gitster.mtv.corp.google.com>
	<20151219033542.GF422@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@ozlabs.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 17:57:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB3mQ-0004K1-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 17:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbbLUQ5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 11:57:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751291AbbLUQ5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 11:57:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C895431D11;
	Mon, 21 Dec 2015 11:57:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9RiX6ToUTwQsdKeLi0X3nTo54tM=; b=A96ilZ
	bfEFwB4Ls0QXeuKxMeHOJMfRX2K9a+Fk1m5vKnQEmDpywHoPUHE5BAqrDzCd2fTQ
	bthjcSp4qAB1SHz86UWocIC4TvH/4nkggKm+6ZxvwvzdZJydJHVVVZf7QBDzKGSX
	a4PVNuBKjmyJox3lQR0C8JYQ6EdmWeuK5Tk+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gMBFMkiEelsAsdXw9sEbfA/zhtYoTFSc
	rBXS7qTvv0kPcHedSeJRNgI3QfHYXk6/X2jysKgYHEC1oYGAZ3kvpdeqE1wYLiiL
	xb3sTEZTJ6WK3Pz/+rnMlrnvdYY/zGm42AozYw8IA5t1amstwcuZvXjnp0hMwQgH
	zRl+V+99Jfk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0C5231D10;
	Mon, 21 Dec 2015 11:57:45 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 43B2F31D0F;
	Mon, 21 Dec 2015 11:57:45 -0500 (EST)
In-Reply-To: <20151219033542.GF422@fergus.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 19 Dec 2015 14:35:42 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4F7DD98-A803-11E5-852C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282797>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Dec 15, 2015 at 03:09:44PM -0800, Junio C Hamano wrote:
>> Git 2.7-rc1 has just been tagged, and the remainder of the year will
>> be for the stabilization, fixes to brown-paper-bag bugs, reverts of
>> regressions, etc., but I haven't seen updates to the various
>> subsystems you guys maintain for some time.  Please throw me "this
>> is a good time to pull and here are the updates" message in the
>> coming few weeks.
>
> Please do a pull from git://ozlabs.org/~paulus/gitk.git to get:
>
> * Some improvements to gitk appearance, particularly on high DPI monitors
> * Translation updates for Japanese and Swedish.
>
> Thanks,
> Paul.

Thanks, will do.
