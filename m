From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Wed, 19 Nov 2014 10:51:28 -0800
Message-ID: <xmqqioibrplb.fsf@gitster.dls.corp.google.com>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:51:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrALm-00005K-OF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506AbaKSSvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:51:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755958AbaKSSva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:51:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1F4E1DBA5;
	Wed, 19 Nov 2014 13:51:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65vx5YoUvrJSNCd6Cg0LUnzv+bc=; b=cOxkNc
	372iZ9s+EAX4uJEf+5yIfYFF8xbWQ4CILFwycrk8n2f3beluOEODmDay/6VrZe06
	0HMl/8LPdS6sXxUeFAoWGMs7IlWkg8EyJDMhqZQxOGb40au/ybLFxD7Dub6X0FH4
	6Rp8exyVo3pQZ7K9V5JzIghDINEcHtTL1xVUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o8ULgtNob+WkVPBJI+AuV6GOyqbK0mFv
	BqtacwtVII5mNpdnuceuSOqwlGA1l5fbVxYBajw8KE8C5oHJOxENNMt0j9dfBzD2
	PucjDZGIVJHl4iInHO9/ucaLFuCL9QRm1nxtngNjk540ewF+qskZGWD8cDVqWYUL
	FcKZsAQazfc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7E4D1DBA4;
	Wed, 19 Nov 2014 13:51:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51F2F1DBA3;
	Wed, 19 Nov 2014 13:51:29 -0500 (EST)
In-Reply-To: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Wed, 19 Nov 2014 15:52:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 126D074C-701D-11E4-863A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ... and most would
> expect "git add --ignore-errors" to ignore the "file is ignored" error
> as well and continue adding the remaining files.

Yeah, I think that makes sense (but please don't take it as the final
decision yet---I'd like to hear from others).
