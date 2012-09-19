From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] Make 'not ok $count - $message' consistent with
 'ok $count - $message'
Date: Wed, 19 Sep 2012 16:39:17 -0700
Message-ID: <7vmx0leg62.fsf@alter.siamese.dyndns.org>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
 <1348074915-19985-3-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETrd-0005eO-9H
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab2ISXjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:39:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab2ISXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:39:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 638299A2D;
	Wed, 19 Sep 2012 19:39:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c8cVhDAdMpZOoKVjw06NSnbhBw4=; b=MTVzJG
	2QScayxtbI4LrxwVQ5OBiJcTfJsH2uZkRyO/jcJ4/Hsxep5oUgVdyr9xG01F43S1
	LbZ+t4eak2UY2mHmTwogw6E9YX0Em1ICO0bVDS0uQSd7k3nkLejEqRHYrygXgp+5
	UNFNh7vkHa6yb4XVT3uuGt7VgAsBWwESDx8lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wu7t8/neqxgK+GSWiwv4I4WhNf2aqi4F
	9ZbCCCjy9//ywCE0PAy2CWOXKSWnADGlhJYNC3gFr1rbh8kWqQPiZAXotaCecvpL
	KRRX+Ew/FX2YmMx4uCbYUCTmxfazhEBvGKVBHFIXevdAtY1T37BeK5n2XNSiWnDF
	npO0m2Ikohk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 513529A2C;
	Wed, 19 Sep 2012 19:39:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C76DF9A2A; Wed, 19 Sep 2012
 19:39:18 -0400 (EDT)
In-Reply-To: <1348074915-19985-3-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Wed, 19 Sep 2012 18:15:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B160902-02B3-11E2-8329-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206012>

Adam Spiers <git@adamspiers.org> writes:

> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  t/t0000-basic.sh | 4 ++--
>  t/test-lib.sh    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

>  mode change 100644 => 100755 t/test-lib.sh

Peff might have already pointed out, but this is wrong.  Will queue
with an obvious tweak.

Thanks.
