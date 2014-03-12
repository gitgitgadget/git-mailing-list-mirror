From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status merge: guarentee space between msg and path
Date: Wed, 12 Mar 2014 13:43:11 -0700
Message-ID: <xmqqsiqnjggw.fsf@gitster.dls.corp.google.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<1394580211-13383-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<xmqqmwgvkyig.fsf@gitster.dls.corp.google.com>
	<5320BED8.3040108@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:43:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpzl-0001ST-Os
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaCLUnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:43:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbaCLUnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:43:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F8C474B1A;
	Wed, 12 Mar 2014 16:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nU9amhCrzkWpLfCrX+D+0c7ko1o=; b=mXvCBh
	2WPGZZZSEqA+2352ZogD6cC3UxeeLHwlP8gxXnQaxprWzyuadLLwyfhlal2ijkkm
	ewDMIs7cMyQs5yn/sj/nxwt6wxJ9+4TtkdPctQdTT2awSPhGtlbpNxS9WldVNF7C
	yIWam39ybBGgS5SpZQZiLSZCnIUYOGy4JJl1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KvvbCxs2i+z0l4dfrDTZI8y2JFD1ZPlX
	djsYUH6SbThFfqCYtcmhXbDJ8iLtWaGabjwQU3RqZ6h9Hwof34fmczdcqi7YPznq
	PGtjclRQYFL7IZ4lidpLGZy0NNUWM9viX6Py3vRwNmdsNgb5k2jfYpdamjxmtgbU
	sOGxG1TaEOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EF1074B19;
	Wed, 12 Mar 2014 16:43:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B95C74B0F;
	Wed, 12 Mar 2014 16:43:14 -0400 (EDT)
In-Reply-To: <5320BED8.3040108@savoirfairelinux.com> (Sandy Carter's message
	of "Wed, 12 Mar 2014 16:08:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EEEB83D2-AA26-11E3-B993-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243988>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> Seems fine except for the bit about returning _("bug"), which I brought up.
>
> Seems to do the same thing as my proposal without changing the
> alignment of paths in of regular status output. No changes to tests
> necessary, less noisy.
>
> It works for me.

Thanks.  I'll work on a better split, then, and resend them later.
