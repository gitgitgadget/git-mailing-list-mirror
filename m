From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add MAINTAINERS file and clarify gui workflows
Date: Sun, 30 Dec 2012 12:26:39 -0800
Message-ID: <7va9svffr4.fsf@alter.siamese.dyndns.org>
References: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org,
	patthoyts@users.sourceforge.net
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 21:27:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpPTK-0006IV-Gs
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 21:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab2L3U0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 15:26:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859Ab2L3U0n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 15:26:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 010AEAE0D;
	Sun, 30 Dec 2012 15:26:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEGu7Stt3ZCudVzl4vv5bBqorH4=; b=i82+JS
	/oqeeRcGzZgcQZ/JWwoFeRuRC+pSxXotWLWRrMyYa+8loCm+LGKnaxmvtQmuKXT2
	0HEc4QCc7N9MlFTeXvWUDPSO9AWdBQFEoT4ZL9TZY5TTT0aSiy7jArQbotiJxapU
	XUOUIobcYVmRzyAxnBtLu7b6pAur+2RKkKS7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aFNICAKYujGRJZrcVKTyJaZIFqgVA2LZ
	wWlYhuAf0HM+toqCbT5HxjTBWrJv967ORhZ9udZto6lGznMa0tZm6jJWBJtF/O9d
	tpm/6iJ0ZXcFROygzQubyzuok2srmcCJ5P4IT+7nXJUJdfgdyBEXoRLgcmIv70iP
	aDWk4gjdqYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E35F7AE0C;
	Sun, 30 Dec 2012 15:26:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5451CAE0B; Sun, 30 Dec 2012
 15:26:41 -0500 (EST)
In-Reply-To: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com> (Jason
 Holden's message of "Sun, 30 Dec 2012 13:18:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 386E8A10-52BF-11E2-AEDE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212341>

Jason Holden <jason.k.holden.swdev@gmail.com> writes:

> I spent a good amount of time yesterday figuring out the correct workflow
> to submit a change to gitk.

Thanks; I just realized that nothing in Documentation/ hierarchy
mentions these; they are only mentioned in "A Note from the
Maintainer" I send out every once in a while (kept in MaintNotes of
'todo' branch):

    * Other people's trees, trusted lieutenants and credits.

    Documentation/SubmittingPatches outlines to whom your proposed changes
    should be sent.  As described in contrib/README, I would delegate fixes
    and enhancements in contrib/ area to the primary contributors of them.

    Although the following are included in git.git repository, they have their
    own authoritative repository and maintainers:

     - git-gui/ comes from git-gui project, maintained by Pat Thoyts:

            git://repo.or.cz/git-gui.git

     - gitk-git/ comes from Paul Mackerras's gitk project:

            git://ozlabs.org/~paulus/gitk

     - po/ comes from the localization coordinator, Jiang Xin:

            https://github.com/git-l10n/git-po/

Perhaps the update should mention po/ as well?
