From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reflog --date
Date: Tue, 21 Oct 2014 11:06:47 -0700
Message-ID: <xmqq8uk91emg.fsf@gitster.dls.corp.google.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
	<xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
	<CAHQ6N+rb6eNC0_uzCAdH-HNb_SmdG4-W9DgmVKjfNpRcKKxk=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 20:06:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgdpe-0007P1-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 20:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbaJUSGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 14:06:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751597AbaJUSGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 14:06:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F25BD16FEC;
	Tue, 21 Oct 2014 14:06:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XdB41QBUFGGmLECiIyCxLmq3aSQ=; b=RaEmW5
	370AaHy12DKvGL/UP55wQ/TSmmk4g1MEWVg03oGvTBMc1PE/XJyHAWpC6q5ImRZo
	DLzuIhrZIIz5HmPK+mPM1W5YYjw2I4uYwiVCGTkIk3bbMYhLCD4Tun+mwG4qjVVO
	9tv9PSzMPBKOXpElB77snegX/l6Yt9V1LE5Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cayabi6MMMtyO7bmLho+s7RVLo/IewhX
	4WKJHsOXucRxKCbo9Cw2BD4aS45f7zd2cuw6Tio+11t/OrXKLil94FwYpR7sLE7Z
	FxA6+nN2IhzeqmhGgpEHkd1AtFzd9+6hzh3VTZADLs4SZVHkbfE/Gpl6q37i+6eZ
	2TT+jGcJwoA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8E0116FEB;
	Tue, 21 Oct 2014 14:06:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AFF716FE7;
	Tue, 21 Oct 2014 14:06:48 -0400 (EDT)
In-Reply-To: <CAHQ6N+rb6eNC0_uzCAdH-HNb_SmdG4-W9DgmVKjfNpRcKKxk=w@mail.gmail.com>
	(John Tapsell's message of "Tue, 21 Oct 2014 18:31:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0682622E-594D-11E4-9527-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Tapsell <johnflux@gmail.com> writes:

> For me, writing "git reflog @{now}"  is a lot less intuitive than "git
> reflog --date"
>
> Currently the top google search for this question is here:
>
> http://stackoverflow.com/questions/17369254/is-there-a-way-to-cause-git-reflog-to-show-a-date-alongside-each-entry
>
> Which doesn't mention "@{now}"   at all.

I would say that a site where cluelesses attempt to lead other
cluelesses is not the best source of information ;-), but that tells
us that either our docs are not read by people or they do not give
necessary information to them clearly enough.

> My opinion:
>
> 1. Add --date   as an option to reflog.  Perhaps using the log.date
> format as the default.
> 2. Document --date in the man page for "git reflog"
> 3. Document @{now}  in the man page for "git reflog"
>
> Sound good?

The order of changes is questionable, but other than that, I think
that would be a good way forward.
