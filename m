From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 10:06:56 -0700
Message-ID: <7vsj3gn55b.fsf@alter.siamese.dyndns.org>
References: <51531059.8000407@atechmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Thomas Rast <trast@inf.ethz.ch>
To: Charlie Smurthwaite <charlie@atechmedia.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtot-0006fj-NX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab3C0RG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:06:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab3C0RG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9F74AAB9;
	Wed, 27 Mar 2013 13:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MckrnGW9hUueG+NiiVvHJohktmk=; b=iF4Gxv
	1eexQ4fcjkR2OrE8oDhWu+fQv4Vh1nGztB3CXUT6y7W5Zdxof+9si9CgIUuctXWR
	gSihIg1mZELNEvUCgIkFoMusqb0YQHGi5bxB/Rz9Q7tEAuDMEXXQvV4nlbB3dujx
	5yGd+2Rol9Y285TBf79iNvPTddcJkly6eMgO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2p+hzic55/DXBdh1mV8R5lcyMm7scib
	FoDqEIR5+edDMzt4SqSLf/ALJLb74CwXOAN2ci0+gpgeRsohx4sCX1GDMksd3CME
	NXoYn3kwelqQ62ollaDR3bmN3kvMaotMZ0plIYgJQuJCMRdDWB6VHNI8s2ugbZwE
	pkZClHr7FkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD7A5AAB7;
	Wed, 27 Mar 2013 13:06:58 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31E53AAB4; Wed, 27 Mar 2013
 13:06:58 -0400 (EDT)
In-Reply-To: <51531059.8000407@atechmedia.com> (Charlie Smurthwaite's message
 of "Wed, 27 Mar 2013 15:29:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBDCD6EC-9700-11E2-9CF1-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219280>

Charlie Smurthwaite <charlie@atechmedia.com> writes:

> I am experiencing a segmentation fault in various versions of Git using
> different repositories.
> ...
> Test Command
> git merge-tree 26bb22a052fef9f74063afd4fc6fc11fe200b19f
> 8d6bdf012941d876b2279994e02f1bb0d5c26e7d
> d5ef97ac407d945f231cd7c8fb1cfe48b3a12083

Thanks for a report (and thanks to John and Thomas for finding the
typo).

Nobody I know uses merge-tree; the last real change we did was back
from July 2010, and the only reason I was looking at it recently was
because I was planning to write a new merge strategy using it.

Mind if I ask what you are using it for?
