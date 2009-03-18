From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: minor spelling fix and string factorisation.
Date: Wed, 18 Mar 2009 15:31:16 -0700
Message-ID: <7vvdq6bgzv.fsf@gitster.siamese.dyndns.org>
References: <20090318212230.GA2511@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4Jh-0003H8-Ky
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZCRWbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZCRWbX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:31:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbZCRWbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:31:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 443AAA3145;
	Wed, 18 Mar 2009 18:31:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3FD55A3143; Wed,
 18 Mar 2009 18:31:17 -0400 (EDT)
In-Reply-To: <20090318212230.GA2511@zoy.org> (Sam Hocevar's message of "Wed,
 18 Mar 2009 22:22:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 817F7D7C-140C-11DE-8E07-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113693>

Sam Hocevar <sam@zoy.org> writes:

> Properly spell "successful" and slightly rewrite a couple of strings
> that actually say the same thing in order to reduce translation work.
>
> Signed-off-by: Sam Hocevar <sam@zoy.org>
> ---
>  lib/branch_delete.tcl        |    4 ++--
>  lib/remote_branch_delete.tcl |    4 +---
>  lib/tools.tcl                |    2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
> index ef1930b..20d5e42 100644
> --- a/lib/branch_delete.tcl
> +++ b/lib/branch_delete.tcl
> @@ -51,7 +51,7 @@ constructor dialog {} {
>  		$w.check \
>  		[mc "Delete Only If Merged Into"] \
>  		]
> -	$w_check none [mc "Always (Do not perform merge test.)"]
> +	$w_check none [mc "Always (Do not perform merge checks)"]

Don't you also need to adjust the existing translations if you are
changing the key strings used by mc?
