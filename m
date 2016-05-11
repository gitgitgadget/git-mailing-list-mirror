From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Tue, 10 May 2016 19:08:33 -0700
Message-ID: <xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 04:08:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Ja5-0004xV-G3
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 04:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbcEKCIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 22:08:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751436AbcEKCIh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 22:08:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27C0B1BF0A;
	Tue, 10 May 2016 22:08:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9RI/T1c0zCu7fyaMhuNmyWJh5LU=; b=yceIfe
	13YlmOB7PlO+NPlA2qnfy5kc6fi0HzxftA/2gafUaj4GD1w5BCNhcdUGJM85TYrC
	1NfaHzx6nRf2Pcr/uPzxIbi3L4L5nCv+XgWjt1VWYtVNDzzLP8C97U03IM8CplK0
	jrEhFNAy8TVp62Sw0RTv6ymg0Zsw1j0Y/A8P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c54AyDBPXVjyuiY1rdFZnGEd9EQn2Lp7
	EiGW6YsYeIN2An33s31KOwGi5FF25lTKneojJbiUVG5C1MR9UbDWWc3m0XaovMeL
	zf+LOuoTbXEUGJfIcmnfXqEoXIHrqmaDeooYkS9rwZQKokAEx8OgILzLH5+OOJ4P
	jwD+uwDZdMk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FA271BF09;
	Tue, 10 May 2016 22:08:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 993211BF08;
	Tue, 10 May 2016 22:08:35 -0400 (EDT)
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44C1E098-171D-11E6-98D5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294223>

Stefan Beller <sbeller@google.com> writes:

> I started from scratch as I think there were some sharp edges in the design.
> My thinking shifted from "submodule groups" towards "actually it's just an
> enhanced pathspec, called submodulespec".

Except for minor things I mentioned separately, overall, this seems
quite cleanly done.

Looks very promising.

Thanks.
