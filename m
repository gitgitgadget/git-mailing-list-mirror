From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 14:51:48 -0700
Message-ID: <7vty8h2wda.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fb3-00075K-SX
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622Ab1ILXHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334Ab1ILXHP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 373654A89;
	Mon, 12 Sep 2011 19:07:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=UFkj+l1Lc//T380Z6NYnY3t3eSU=; b=mCpvBTwUEaoxW0GHAtsj
	uNi8+lamo7mfAk0XLjMOMSUuM+PkeI7dVej+yZ4+xknGzpgFlX4i6uw+h153QoqH
	P9jgnpsvPp/efim+mWKfXUyXHcG+t/fV5LxAQ5reJwGvb5yF46Eqyr1i3wrz1Ua/
	iJ6CvYSdi9ro8ULN7i3E5kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=avhMXv0NLa+h9oM7XoPszcXtkIFB+4KGBmtB/tUqhx8ylq
	pEak6ieM9iHTwJyWNxM+CZeIdS7TJc0L3xyY5LNkzhqYbtjJJ/xIpa1MidZDrJRi
	tWVs1VEOB6c9UaExWtuKVbSZyWIyyYKm7ADqyEGA3LlDPJUavxM1B7sKqnMiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F00F4A88;
	Mon, 12 Sep 2011 19:07:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B84064A86; Mon, 12 Sep 2011
 19:07:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F42D229A-DD93-11E0-8C55-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181246>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * jk/add-i-hunk-filter (2011-07-27) 5 commits
>   (merged to 'next' on 2011-08-11 at 8ff9a56)
>  + add--interactive: add option to autosplit hunks
>  + add--interactive: allow negatation of hunk filters
>  + add--interactive: allow hunk filtering on command line
>  + add--interactive: factor out regex error handling
>  + add--interactive: refactor patch mode argument processing

Could you start thinking about completing this series, or posting a "where
to go next" summary to guide others with lessor git clout to finish with
help from people who know "add -i" codepath better (I could help), once
1.7.7 ships?

Thanks.
