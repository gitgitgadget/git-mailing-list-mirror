From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 32/33] refs: change do_for_each_*() functions to take
 ref_cache arguments
Date: Mon, 15 Apr 2013 10:40:04 -0700
Message-ID: <7v38urvgjv.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-33-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnO5-0006nA-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934580Ab3DORkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:40:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab3DORkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:40:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 373D815CF1;
	Mon, 15 Apr 2013 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+1USyLf2QjbePLaOb4rK7My7DVo=; b=yhyGfxYCS4R85uXkFLTG
	XuSo7L7PjOi4p/WdwyEt+4BXy93/nK60Pr3mfOFmVJrMIrgQDmY9H4DbYfARFpJp
	sbJFJ6yUaJTSFErDFKha2EHb6plmgI0GnavVcoa7Ib74KPyX/CsrcbhewgktPcm+
	/+EyJ2DINi8OijmZBUk6WNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ORGFHPRFVM0gWC58dJjVRk22fN/N3GA1+PlUZXn4E7ZZl+
	lOy9OGh/70WtvA28SskcbqMZ/j7K67aheFbJUqzOarugF/elLSazbSBcj0az5a+v
	Kvxi979e/+5ZO5J6m+DNqIZpEnLTIj7bZfDFWkDMlNvJXN5AOoxC5+6guwoHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D55715CF0;
	Mon, 15 Apr 2013 17:40:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A825115CED; Mon, 15 Apr
 2013 17:40:05 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8257DD5C-A5F3-11E2-A8CB-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221267>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change the callers convert submodule names into ref_cache pointers.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

A nice cleanup.
