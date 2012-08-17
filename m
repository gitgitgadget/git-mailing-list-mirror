From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cleanup precompose_utf8
Date: Fri, 17 Aug 2012 10:30:33 -0700
Message-ID: <7vobm9v32e.fsf@alter.siamese.dyndns.org>
References: <7v393mxkpk.fsf@alter.siamese.dyndns.org>
 <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tboegi@web.de, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2QNg-0002uA-En
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599Ab2HQRak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 13:30:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758588Ab2HQRah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 13:30:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7682D75E0;
	Fri, 17 Aug 2012 13:30:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQQqqUjzFZWRlYrXzbDpvrdXyeI=; b=RteQeO
	xT+GVcsczzcPAZmV5BSHu+sV0WyVeZbkPY6wJvyfo19VsP6ZfR6t8DxASVmykXj0
	2zAWwDvZWQcOeVOObunDvBc/02Wlsh93rmdBTZw8DH4IDV6D1W3tODFEAbQnObZx
	50Mov/kQHjMBlof2E9U3rLHY6PydNONyASoKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eIM4Eh3IeCCqW/5499uFR8YMqtPQAP3y
	MktJwwBcDJX6geJy/KdtMAWhP05uLiJbjJW6rW2L06EEc8XcGGJxYPX/xAgqYAj0
	j9v3414scddX7m+ykI1jGxYIlmBGRcbCPcnKYh9fDY/SZ0gY8BOczki5YSfnrooz
	+33Urk8u2mM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6243175DF;
	Fri, 17 Aug 2012 13:30:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CFC575DE; Fri, 17 Aug 2012
 13:30:34 -0400 (EDT)
In-Reply-To: <1345215190-95976-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Fri, 17 Aug 2012 16:53:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40AA1336-E891-11E1-9DF0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203629>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Remove extraneous parentheses and braces
> Remove redundant NUL-termination
> Check result of unlink when probing for decomposed file names
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---

Thanks.  I've found and fixed a bit more style violations while we
are at it.
