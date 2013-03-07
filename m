From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What I want rebase to do
Date: Thu, 07 Mar 2013 09:38:36 -0800
Message-ID: <7vwqtjm7oj.fsf@alter.siamese.dyndns.org>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com>
 <7vtxoqx3s1.fsf@alter.siamese.dyndns.org>
 <87sj4aoo3s.fsf@pctrast.inf.ethz.ch>
 <7vppzex2pq.fsf@alter.siamese.dyndns.org>
 <201303061855.r26ItKtM018797@freeze.ariadne.com>
 <87r4jra942.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 07 18:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDemX-0004TN-PA
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 18:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab3CGRik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 12:38:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374Ab3CGRij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 12:38:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA02AAFE3;
	Thu,  7 Mar 2013 12:38:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9m4UY2tGyQFmL4hfA1/X2flNn9c=; b=DWFHSO
	wggFw4qO2yFEiRwMHmcI3UWFWdP1y/KBKIfh9iz2cX3dMJcWHxTf6EMsCX3SeYZH
	RK3KTx3kkfNjIjg2IVI57zE1Wpls85+f5VQelYQIxAEIBzCbcCUeUrH2X2vB1y9F
	+uPq0xydfNU4AW1OA1LiI6VVzXSZ6A/SLap6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lla1TA2xLm/VV+qtFXm5nGuZJkMAUWrg
	Xufpu0QFUPyayjRCGer1deJ2jr5y+FceP29iYKT1WNUQcVDToL/DbFhZpwkdjPKc
	tOXQdKqOlbG2XP+G8y/4bN3AsRB5f55L6w1PMbo4u9qQ3zebGT8aiP8l2f0qxVMd
	zUnGL7bw5v0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE7CFAFE2;
	Thu,  7 Mar 2013 12:38:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33285AFE0; Thu,  7 Mar 2013
 12:38:38 -0500 (EST)
In-Reply-To: <87r4jra942.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 7 Mar 2013 09:48:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8176CB8-874D-11E2-AA0A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217602>

Thomas Rast <trast@student.ethz.ch> writes:

> I still think that the _right_ solution is first redoing the merge on
> its original parents and then seeing how the actual merge differs from
> that.

I think that is what was suggested in

    http://article.gmane.org/gmane.comp.version-control.git/198316

> Perhaps a new option to git-rebase could trigger the above behavior for
> merges, who knows.  (It could be called --first-parent.)

Yeah, I think that is what the old thread concluded to be the way to
move forward:

    http://thread.gmane.org/gmane.comp.version-control.git/198125

I'll throw it in to the "leftover bits".

    http://git-blame.blogspot.com/2013/02/more-leftover-bits.html
