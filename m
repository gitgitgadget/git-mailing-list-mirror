From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: point to "History Simplification" from --
 <path>
Date: Mon, 29 Aug 2011 16:50:10 -0700
Message-ID: <7vbov74w25.fsf@alter.siamese.dyndns.org>
References: <307fe311ad448ecd3d0643040008954a217d7ddb.1314659821.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 01:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyBas-0003Q8-Ob
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 01:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab1H2XuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 19:50:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab1H2XuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 19:50:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 170F358F5;
	Mon, 29 Aug 2011 19:50:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJS5H/wU/fjWH8XJo4A6UYQbxsc=; b=EDWid6
	EuNhvcRGaPassFmL7mZjNhcwcqqQWXkL3JcI9I0XIjv7kCTi3Ig6yuIcDFMtivpg
	AidWXpQC2BZQ9U6FnMpLCR+T9pWlWujPzS4w4PEV2y5Fr69HE70dTR6WREmvhHj5
	tUJGrLr6C3V08Uq67UD8LXv/rzQJ7zV3+mZMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ISWfd9r0sErF6V5+SFrVifGjEAaXUbcM
	eih7k3cqlBcujU6GUU8L7klaYcvI3Vw6HrjfuqVcLpUIrm/iQsA8J8xW6COa/pUC
	WvlnhcTpF6jCkP9wq4yppy2ZlPWqjon3pospJbTlU2jr4ty7TtmbfahGU12Qddr0
	BlQFg/XJqEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D49E58F4;
	Mon, 29 Aug 2011 19:50:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93F9658F3; Mon, 29 Aug 2011
 19:50:11 -0400 (EDT)
In-Reply-To: <307fe311ad448ecd3d0643040008954a217d7ddb.1314659821.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 30 Aug 2011 01:18:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A25110E4-D299-11E0-A156-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180378>

Thomas Rast <trast@student.ethz.ch> writes:

> 'git log -- <path>' does not "show commits that affect the specified
> paths" in a literal sense unless --full-history is given (for example,
> a file that only existed on a side branch will turn up no commits at
> all!).
>
> Point the user to the "History Simplification" section to avoid
> surprises.

Hmm, or perhaps replace it with a brief explanation instead of redirecting
the readers to a separate section without telling them anything here?

    Show only commits that are enough to explain how the files that match
    the specified paths came to be.

(this is my attempt to paraphrase $gmane/90659)

>  [\--] <path>...::
> +	Show only commits that affect any of the specified paths.
> +	See "History Simplification" below for a precise definition of
> +	the filtering applied.
