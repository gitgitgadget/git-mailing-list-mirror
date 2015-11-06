From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Fri, 06 Nov 2015 09:28:10 -0800
Message-ID: <xmqq611f3umt.fsf@gitster.mtv.corp.google.com>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
	<3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>
	<1446670884.4131.42.camel@twopensource.com>
	<563AD452.2030301@alum.mit.edu>
	<1446740535.4131.50.camel@twopensource.com>
	<563CAC58.3070907@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZukoE-0000Hx-MH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 18:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbbKFR2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 12:28:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365AbbKFR2N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 12:28:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11823279AE;
	Fri,  6 Nov 2015 12:28:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37DZh1329ztdQHjBTe6+XPoX5r4=; b=p8U1JR
	DqWxw5rHT5eHhWwq/Tsplyvmkt7IsiudS0HscPmaZwk8VLOAMwxFJiXzniFPmgbD
	WKme601O+iimYmZD9jN/48HFJF5o6QyTU3f7O13aIP3BXZrs/6AOUhPZT5nxjTnW
	Znci/QU5EfLWnzYV11fooJ0QGgNMvPdlkjoLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fYsGCmF3rjXAd/EAYtMZBGi3ZrGibISy
	ByxqXFtq20KxcTPKA5yf0cuDFaTSxHypzfKtyMuM3AH5C02ycDhwLD+NphA1HpYK
	zgOOI3dh74juZAZTMjNrpveqj50BmoYjMy285V3ck0XIG+ThTYJ1L4UWc4rX6buK
	TSdfdyrwovQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 088F8279AD;
	Fri,  6 Nov 2015 12:28:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 84056279AC;
	Fri,  6 Nov 2015 12:28:11 -0500 (EST)
In-Reply-To: <563CAC58.3070907@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 06 Nov 2015 14:34:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C0EA4BE2-84AB-11E5-BC2C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280989>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, if there are no more comments, would you mind
>
>     s/verify_no_descendants/find_descendant_ref/
>
> in the log message of this commit? And then, if you are also OK with the
> new subdirectory introduced in this patch series, David and I seem to be
> in agreement that it is ready to go. It would be great if this patch
> series could be merged in a timely manner, as it will conflict with
> nearly any other changes that people might want to undertake in the refs
> code.

Thanks for working well together.  Let me see what I can do today...
