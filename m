From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 14:30:27 -0700
Message-ID: <xmqqiowhdqx8.fsf@gitster.dls.corp.google.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
	<1382951633-6456-1-git-send-email-bdwalton@gmail.com>
	<526EA7C8.2020607@kdbg.org> <20131028182718.GA4242@google.com>
	<xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
	<CAP30j179XPZqTGiZuvyZEL94Q14ocas+r8mP_R4gLetWwikkwA@mail.gmail.com>
	<CAP30j17Qv7DrrbgZTsCQB8gxsfQTfVy35s9sDkW0=pHz9F+W3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VauOS-0004na-AM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab3J1Vac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757233Ab3J1Vab (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:30:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D86B4E8DA;
	Mon, 28 Oct 2013 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DQCcDrgMKSDwFDup7d6G2N7Qo0U=; b=w0UxC9
	keSaNmFsaxkhjRT+uXs3810JcLUY0Dcavgz9ly52KEItOqzylqJvNtqzfVle3hBT
	jTqyXpmO8N0i2wU+L5NWsPN7HYJGR5eQgivIsAe70mk1tHQuzKxlfFfBt7tcVoav
	E/rna9ImuUt6Dzp5GTgs0XNuqg45Zy5by0VxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfjKSTR+8Ldf+V0GvENQfXoPaQjIVfWU
	2GKf/2XSTDIjX9oE8iQXl4eK3t70ZRL22pt3ELGfOoZEzgWzNGtmlQ2sHHTJV/y8
	IyT5y+EZ3Oh4Jrdzs4SkIjPpx/HKFQZXsctw+EPCdfzvPtZvOiOOFTas21seFbIb
	5KD8432Tnsk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F230B4E8D9;
	Mon, 28 Oct 2013 21:30:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 638804E8D7;
	Mon, 28 Oct 2013 21:30:30 +0000 (UTC)
In-Reply-To: <CAP30j17Qv7DrrbgZTsCQB8gxsfQTfVy35s9sDkW0=pHz9F+W3Q@mail.gmail.com>
	(Ben Walton's message of "Mon, 28 Oct 2013 21:12:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B7BF300-4018-11E3-8332-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236864>

Ben Walton <bdwalton@gmail.com> writes:

> Per the other discussion about replacing all PERL_PATH with a shell
> function named perl, should I update this patch to use $PERL_PATH in
> the meantime so that it can be batch updated when the function is
> added in a separate patch?

Yeah, sounds like a good plan, and very much appreciated.

Thanks.
