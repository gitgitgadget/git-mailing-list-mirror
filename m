From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9] pathspec: allow querying for attributes
Date: Fri, 20 May 2016 12:38:46 -0700
Message-ID: <xmqqshxccyex.fsf@gitster.mtv.corp.google.com>
References: <20160520190034.12681-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 21:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3qGR-0002xX-0D
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 21:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbcETTiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 15:38:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750792AbcETTiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 15:38:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21C0D1B367;
	Fri, 20 May 2016 15:38:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=vUqJb/
	XxoAZGXjBUn17rTdpaxmvk9CPlHvXqknGBjxXl/wHv82ZJw6ac/DRTKvkBxp6uBY
	2xOlzFAuhe8+Pikd3B89HOt5xM7IqIKa29T9W5BwPnPP2P5eDm5Lu6zdzO3AwnuO
	D6UJn5L1KumxdN9JUmsXWH8iTc1mHnIbbHl48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uy1riBaVOkPOoodPCmnNJ0itAvZcbhX8
	mf9d0chW0r0pJPJQDQ6fYQsQod6tPqrVrr2c2Szahx5Z6XQIRWpT0tapGdf8rcwF
	e0kBDtHZ9izrZiE7IU8ePSX+7wdoi4sqtn6e/rhaP3YHd/rpWUJbyr4FXiB5CKfD
	LTrG72DzxYs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A8061B366;
	Fri, 20 May 2016 15:38:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E31C1B365;
	Fri, 20 May 2016 15:38:48 -0400 (EDT)
In-Reply-To: <20160520190034.12681-1-sbeller@google.com> (Stefan Beller's
	message of "Fri, 20 May 2016 12:00:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7928ED84-1EC2-11E6-A687-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295206>

Thanks.
