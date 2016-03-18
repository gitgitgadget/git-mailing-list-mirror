From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 15:45:07 -0700
Message-ID: <xmqq8u1fpfrg.fsf@gitster.mtv.corp.google.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
	<1458339836.9385.29.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah38s-0006Pp-NK
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 23:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbcCRWpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 18:45:12 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752883AbcCRWpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 18:45:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA3C24D912;
	Fri, 18 Mar 2016 18:45:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iYiiKInd7ffYkHBjHLlMAAA7Zu8=; b=ZbVULv
	dAEnE9wC7Iw34LFhGyFFdunX3ZWdPcHjM0KzVBKj8m7jkXnYwTFPK6iTZg+agz6/
	ELYVkSg3JfZA0iAGyk/qz6MInrooqH9G32muepXfmdUh0tzjdzxTl+SLoS0AGaxU
	i0AUhXMIt5za0yh2yLCLg0GlQkN+cbGh46cZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfAZ3VtXOsBhgcKTHwpBIOWNX36KgpI5
	sVfvLtMEX1sX4QoRgKS1mU25Knv1EYxWbTRPr9qhPpIU9Mf6HzsB61KJI4JTno6l
	SVnxidjbe9JCHo+m4z5yMd5egZp5aXokAi03UdGzbL98Ywf43Rex4IweeZrs2zZX
	MMRPGUb5n3c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D18574D911;
	Fri, 18 Mar 2016 18:45:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4DAB74D910;
	Fri, 18 Mar 2016 18:45:08 -0400 (EDT)
In-Reply-To: <1458339836.9385.29.camel@twopensource.com> (David Turner's
	message of "Fri, 18 Mar 2016 18:23:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10BD3144-ED5B-11E5-A967-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289263>

David Turner <dturner@twopensource.com> writes:

> Also, I didn't notice a test that shows that "cool" merges without
> allow-unrelated-histories are forbidden.

Yeah, because I didn't write one in the version that was sent out,
which has been corrected in the one that will be on 'pu'.

Thanks.
