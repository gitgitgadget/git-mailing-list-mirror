From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Tue, 01 Mar 2016 14:05:19 -0800
Message-ID: <xmqq4mcp7t28.fsf@gitster.mtv.corp.google.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
	<vpqvb56yltc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Sidhant Sharma \[\:tk\]" <tigerkid001@gmail.com>,
	git@vger.kernel.org, sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:05:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aasQ5-0000FQ-6M
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 23:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbcCAWFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 17:05:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751127AbcCAWFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 17:05:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 725F549211;
	Tue,  1 Mar 2016 17:05:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Md+NX+WRv4j4Vm3PnOu2GcFQHLw=; b=THHdjn
	aZ7+DP6ZeLkHTBi8virrIy6L4qEE94yE8Zv1i1m9/F6kZqWNrO6Qvwcu97/EQiyC
	7lsgfZDwGssTwjOMHHmT7BsbiNNUbUoDACWlYmDp6ZQy9Ivh8xHNGmHUg9noXHvr
	+n/SrF3Z48yUVojqjFr+uZkkKLxiag0L4iwLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aKzpK0A+4t+sjY5T6SEfUIKUoRAJRgEK
	CHID0fjOrWknps7UbIqsYCkLJszdPj0fzK0kEhUi8kSor/ncAjCRCjftYta0B+e0
	toLxI39uTfVsEW0LS6dMEm4A9/K7UuB61XmlHhGkSifICgWHe0NE1iB7oAHd2LWt
	YotaD7+t5ys=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69EA449210;
	Tue,  1 Mar 2016 17:05:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D09034920F;
	Tue,  1 Mar 2016 17:05:20 -0500 (EST)
In-Reply-To: <vpqvb56yltc.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	01 Mar 2016 21:39:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0AE1E26-DFF9-11E5-AB04-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288071>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "Sidhant Sharma [:tk]" <tigerkid001@gmail.com> writes:
>
>> Make receive-pack use the parse_options API,
>> bringing it more in line with send-pack and push.
>
> Thanks. This version looks good to me.

I'll queue this with your "Reviewed-by:" to 'pu', just as a
Microproject reward ;-).  Given that the program will never see an
interactive use from a command line, however, I am not sure if it is
worth actually merging it down thru 'next' to 'master'.

Thanks.
