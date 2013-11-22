From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] glossary-content.txt: remove an obsolete paragrah
Date: Thu, 21 Nov 2013 21:40:24 -0800
Message-ID: <xmqqpppt0zav.fsf@gitster.dls.corp.google.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
	<1385016260-9718-1-git-send-email-pclouds@gmail.com>
	<xmqqtxf54o83.fsf@gitster.dls.corp.google.com>
	<xmqqy54h1f9q.fsf@gitster.dls.corp.google.com>
	<CACsJy8C38PUCYMSdEJ1-S5HSNdJO7S24mhkEryFrSGfwKuaU0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 06:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjjU1-0004Un-MK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 06:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764Ab3KVFk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 00:40:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab3KVFk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 00:40:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA964988C;
	Fri, 22 Nov 2013 00:40:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CcxAHOUOY+VDg4bo8upihceX8+I=; b=O+7jSs
	Plpj5QVH8Yxid48fjCz4daat+Wpt6GkbFo+vpAWspeNtDsoxL9vSAKa2LWIdkXXe
	qLx8nQ1CcMmxRrouO5iiP2mOaxXX4AJMaCa+LD/O9sewIZp1FhgZUORGvyIBdj3c
	WV9aauy2S3UOq3iQvRi+i9gWeHsRCc2VneTkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hwwwwRrGJOqtE4u0EwJtLihkWREFlB9H
	OR9fNtCElPD5H+dTGwJnr/yg6hxrbdj0rM6aFpKcKNHjlxW9yML3+qbtyjHLOyI7
	IyaZRCJPRCIIfbZ/UHMghwS/CIIqkWGD18LqQ7NZ4GYMOYmEXMVXsTmBiRhrcS/P
	egs2D5M7SSc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AA34988B;
	Fri, 22 Nov 2013 00:40:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6B3C49889;
	Fri, 22 Nov 2013 00:40:27 -0500 (EST)
In-Reply-To: <CACsJy8C38PUCYMSdEJ1-S5HSNdJO7S24mhkEryFrSGfwKuaU0A@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 22 Nov 2013 08:36:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9789D43A-5338-11E3-B4A6-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238172>

Duy Nguyen <pclouds@gmail.com> writes:

> Current version does force that.
>
> $ git log -- ':/#aa'
> fatal: Unimplemented pathspec magic '#' in ':/#aa'
>
> Not sure if there are tests for it though. I'll add an advice to do ":/:#aa".

It is good that we already do the right thing, but actually I was
not questioning the implementation. I was talking about the fact
that the documentation is open to misinterpretation that contradicts
the correct behaviour, as if it were buggy.
