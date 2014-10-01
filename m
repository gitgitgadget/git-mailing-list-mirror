From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] daemon: handle gethostbyname() error
Date: Wed, 01 Oct 2014 13:35:48 -0700
Message-ID: <xmqqlhozply3.fsf@gitster.dls.corp.google.com>
References: <542BD471.3000308@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:36:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZQcx-0004ED-Pf
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 22:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbaJAUfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 16:35:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60193 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbaJAUfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 16:35:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58F883EED9;
	Wed,  1 Oct 2014 16:35:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xKeQwGv9RJ3ChT03eppjmwueIIs=; b=kCCkza
	sJEM3GfwADREV7ZKk8GQxBw22qWQbFZ5y4092uCuckukDCP0SQY7yL4CWN+NUFDB
	YIHBJ07XForGiXfYCm5GPWm6DbbdYabWMMaKlG+t02maj+N9uaJ35TFIcPkj+WMT
	0qkAknfe4dtPT1aRiTo6iUtpG2qTqkaIyeJ1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TfZV1gwVzbwJuRFWuhc7HB8Ttz5/15NK
	J1O5fdeMBDvLqY3QP6Pozzk/4Wj4960YVJ/RsrS1My67/KKge9913akzZZHn9gdu
	FNSb+Fj6HqNe/ADkDBF0AiVvbwRrnXx2cPOXzP+0UIeS99h7lsS0mEsLbQem4Obo
	doyed4fD+YA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FA283EED8;
	Wed,  1 Oct 2014 16:35:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 706473EED7;
	Wed,  1 Oct 2014 16:35:50 -0400 (EDT)
In-Reply-To: <542BD471.3000308@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 01
	Oct 2014 12:16:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 881AEF16-49AA-11E4-8FCC-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257762>

All three look trivially correct.  Thanks.
