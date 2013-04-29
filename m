From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.3-rc0
Date: Sun, 28 Apr 2013 20:31:52 -0700
Message-ID: <7vzjwinhav.fsf@alter.siamese.dyndns.org>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<20130427091833.GB472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 05:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWep1-0003ij-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 05:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab3D2Dbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 23:31:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727Ab3D2Dby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 23:31:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BEB71204D;
	Mon, 29 Apr 2013 03:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9NJ6T20j2itp18/z4xkiI+R5n80=; b=od594f
	Btnis3d+q98hZkIEvId2cMIEg2mMfWAOzz045uOe66opnbSVlVVWTK6Waui2268a
	r0pPXAftxS9LK+L4VJaQ/RUdCpYrYysWrCXBpdtvuWwtXALvXyagi/GzUPVVVn8O
	AH17bENm/U2WtBsPoCwEy/fh+5/lrCvB73VhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycdlLIxV40FAog7t5i64pE8A+CYI+1PJ
	8xryXQd13KBk7d6GNtDfnQa1xMILq+daMCdOxku69/vZzwY4UstI43g9tQvnV6Ei
	si0sPdq/9wwtmGhaHkJtUMp7Hd6QJZqjAig8EwHWjDHx794Bfl6ZFfa6Tmu1vB5r
	hac2pFjntgU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 510621204C;
	Mon, 29 Apr 2013 03:31:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF28D12048;
	Mon, 29 Apr 2013 03:31:53 +0000 (UTC)
In-Reply-To: <20130427091833.GB472@serenity.lan> (John Keeping's message of
	"Sat, 27 Apr 2013 10:18:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 563021E6-B07D-11E2-A2FB-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222762>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Apr 26, 2013 at 05:22:22PM -0700, Junio C Hamano wrote:
>>  * "git difftool" allows the user to write into the temporary files
>>    being shown; if the user makes changes to the working tree at the
>>    same time, one of the changes has to be lost in such a case, but it
>>    tells the user what happened and refrains from overwriting the copy
>>    in the working tree.
>
> This feels slightly misleading to me, perhaps something like this would
> be clearer?
>
>    "git difftool" allows the user to write into the temporary files
>    being shown; if the user makes changes to the working tree at the
>    same time, it now refrains from overwriting the copy in the working
>    tree and leaves the temporary file so that changes can be merged
>    manually.

Probably.  I'll keep the above in my stash and roll it in by -rc1.

Thanks.
