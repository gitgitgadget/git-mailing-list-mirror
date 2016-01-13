From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Wed, 13 Jan 2016 08:56:40 -0800
Message-ID: <xmqq37u1quyf.fsf@gitster.mtv.corp.google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
	<xmqqoacqs6g7.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZO=qLXK=tDt=DT=9og=aNgxk+ukoO4e5qDT=OAJCCS2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:56:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOj1-0006pO-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbcAMQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:56:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752162AbcAMQ4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:56:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00BDA3A272;
	Wed, 13 Jan 2016 11:56:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b6+iyt/atBNF4zUPiTBedKrjPeA=; b=t4bnpe
	0sUImH+Pl1h3+wU8+dB8u3Y+jM2IqNscIb3dF1xYmaMCKSKqJjRdbcFVsCKgwPeB
	Li+McRjgDtv+6jZeq6GnOpSnVSpgopRi6prbRkp2Z5UVdMKVPkAoBpXGAlms84jg
	92CjkwTgfuYx0yQHTpqTcliw9oHlvH6Jn3mI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kja8XJ8K9Q9xWXChtCih9ejNj3sa2Str
	MbxpGQPx/t2CAK8FaXJAIdWr9Co7r7aRqkeN897dz+FSvzOnKGR9jGtw9SnLmdSC
	08un6NGnSQF09scugf3+RJJd49Ih6py4hD6Ix8I4vX0RzYodcadpazgdrGkJJ1X0
	Gc2UCJf87iE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC2CA3A271;
	Wed, 13 Jan 2016 11:56:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 675C03A270;
	Wed, 13 Jan 2016 11:56:41 -0500 (EST)
In-Reply-To: <CAGZ79kZO=qLXK=tDt=DT=9og=aNgxk+ukoO4e5qDT=OAJCCS2A@mail.gmail.com>
	(Stefan Beller's message of "Tue, 12 Jan 2016 15:59:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E6845EC-BA16-11E5-8306-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283933>

Stefan Beller <sbeller@google.com> writes:

> Additionally to that I needed to switch the order of arguments for the
> parallel processing calls, too, to make it compile again.

That sounds as if the previous one that was queued did not compile,
but I didn't recall seeing such breakage.  Also comparison between
corresponding patches did not show such a change, either.

But perhaps ...

> I assume I just did that work twice as the previous version
> ought to compile, too.

... means that you didn't need such a switch after all, and the
re-sent series didn't have it.

I am just making sure that I got the right version in my tree, so
please don't behave as if I am accusing you that you advertised that
you did more work than you actually did and go defensive ;-) If the
reason I didn't see one kind of change in the series I received is
because it didn't have to be done and the description mistakenly
said that such a change is included, that is perfectly fine.

Thanks.
