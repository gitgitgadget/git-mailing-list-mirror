From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 19 Mar 2012 22:47:49 -0700
Message-ID: <7v8viv962i.fsf@alter.siamese.dyndns.org>
References: <20120320043133.GA2755@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:48:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9rvK-0001Mu-RA
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 06:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab2CTFrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 01:47:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab2CTFrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 01:47:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAA814F36;
	Tue, 20 Mar 2012 01:47:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r233vHt6VFHC4QYlH4qFO40EhWQ=; b=Idke02
	q6aDoFnneH5z1Y8oKwl6pA9rJyWrVu3u2NygKJJwKQNLwAyB2DawIWo2DHpjDO8E
	Fpr2rXsqOCBxQjYSsAzQpu9Y2H/3QrKBwWxYlCHNulEnpUoQ9+b6Y3SEDmJvzhc6
	ubuhe6vHMTCPkVnye2EzjN+ZeKMiHC4hRRcUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c5S7pGqki/bQQUmz33FlNw05jEOumcTS
	5Ak7dScMWlHjrZycvLgE8QixK+Fjdz0s7mjN7Z7EYgXywmkEWS7bkm3EcHY89i3J
	ypdT2s2a1W2BX12iPdjlp/lqK0TIsaa+u2EVRsBT8ahv8LBjLrxWQAhVGwUuz5Y9
	H7j9GSVGc4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E16424F35;
	Tue, 20 Mar 2012 01:47:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D9854F33; Tue, 20 Mar 2012
 01:47:51 -0400 (EDT)
In-Reply-To: <20120320043133.GA2755@gmail.com> (Christopher Tiwald's message
 of "Tue, 20 Mar 2012 00:31:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B32A1A0-7250-11E1-AE1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193484>

Christopher Tiwald <christiwald@gmail.com> writes:

>  Changes since v2:
> 	- Cleaned up commit message language, specifically in scenario
> 	  one.
> 	- Created one config variable per piece of non-ff push advice.
> 	  Additionally, preserved 'pushNonFastForward' as a means of
> 	  disabling all non-ff push advice. Users who set this
> 	  config option should see no change to 'git push'.

This one looks very sensible.  Thanks.
