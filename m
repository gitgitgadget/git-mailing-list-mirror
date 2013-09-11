From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix MSVC compile errors and cleanup stat definitions
Date: Wed, 11 Sep 2013 09:09:48 -0700
Message-ID: <xmqqa9jjuypf.fsf@gitster.dls.corp.google.com>
References: <522FA959.80108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJmzh-0004ol-AI
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab3IKQJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:09:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756462Ab3IKQJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:09:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43D4241533;
	Wed, 11 Sep 2013 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UIYGpXm0TzaKjH8UBs9QtmhJKzc=; b=FX+haF
	XXnfwWfB6NOj8g2JNoOgcBwFOXUBo+vBzEynyi2djRuDrTHlfOVtrjYo7l03O5b3
	cjcdEU0NVd8Mn5xZIlmmirDGFZJBugCgpEV5KesTxls9lx1lRAGR/jj8xqvxchn9
	zk32QRvFFNVdt3Fc2Sz+g3yvsVSs8ZCQyZyCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVkVL9GJXaqR4tjd0/HChpTRjqQBowh3
	QrdcIwwgTGoCx8LW8osKgT7DbTVcpO/UeKlqtXbAKwg7XTl3jSffTG5Iwp+xRpc9
	Ez81qSCEQgYoVqmS3H6iebiq+lHPdVcMT1hHmU4PE4r402ZNjRMiqKSXxR+AVpTE
	C8NznyrLZ7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E89A4152D;
	Wed, 11 Sep 2013 16:09:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2246141525;
	Wed, 11 Sep 2013 16:09:52 +0000 (UTC)
In-Reply-To: <522FA959.80108@gmail.com> (Karsten Blees's message of "Wed, 11
	Sep 2013 01:20:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9791CB28-1AFC-11E3-BFFA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234573>

Karsten Blees <karsten.blees@gmail.com> writes:

> A few minor fixes for the MSVC build.
>
> Also here: https://github.com/kblees/git/tree/kb/fix-msvc-stat-definitions
>
> Karsten Blees (3):
>   MSVC: fix compile errors due to missing libintl.h
>   MSVC: fix compile errors due to macro redefinitions
>   MSVC: fix stat definition hell
>
>  compat/mingw.h   | 21 +++++++++++++++++----
>  compat/msvc.h    | 15 ---------------
>  config.mak.uname |  1 +
>  3 files changed, 18 insertions(+), 19 deletions(-)

I won't be a good person to review, suggest improvements on, and/or
judge these patches.  I'm Cc'ing regulars who work on mingw port for
their help and Ack.

Thanks.
