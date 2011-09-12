From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 14:53:11 -0700
Message-ID: <7vzki92wdc.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fb3-00075K-CL
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab1ILXHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab1ILXHN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53F804A83;
	Mon, 12 Sep 2011 19:07:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=sqBpM/nq2VxHhCWefSnawajXUwc=; b=rZ1BgYQCdmkX5vTPIDIS
	o9xJl0jq/XM2KcxfTYAA50I8rYTsPeN3inz8IFfXQLmyR7sEHbvRYrIjXpp4W1Ac
	LCmcYyYSqcdojqbj8Tw3GlSIgRewi1E9JAiamUpyNDOFnJHsrQ/y/hKHeUpdK7Ho
	ZVhVs9XhmLz116bbrdxL+A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=NRo78Q651XfuO54PXPw7hDqwHYFE1QeUw7PrF52I4UgBGI
	HezVHJ6EMBpOlvajmpX2EL606Dk8XnyZgZYcZgj2iJxvzntt0sm0vINarK9W9Q81
	5S2WjglGPia2+xv+HZ73Bz0F9uwUbwyIOJb02heFojD+cRF7IocAODDNpM1v0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B7A94A81;
	Mon, 12 Sep 2011 19:07:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D52664A80; Mon, 12 Sep 2011
 19:07:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F30E2E86-DD93-11E0-B037-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181247>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * tr/doc-note-rewrite (2011-09-05) 1 commit
>  - Documentation: "on for all" configuration of notes.rewriteRef
>
> It was questioned if the new text suggests a sane and safe thing to do.

Should we drop this post 1.7.7, or (preferrably) replace it with better
instructions?
