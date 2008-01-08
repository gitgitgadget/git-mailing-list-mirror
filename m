From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: config: add 'help.*' and 'instaweb.*' variables.
Date: Mon, 07 Jan 2008 22:27:02 -0800
Message-ID: <7vmyrgx26h.fsf@gitster.siamese.dyndns.org>
References: <20080108045514.1a506761.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 07:27:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC7wK-0003YP-G0
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 07:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYAHG1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 01:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYAHG1T
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 01:27:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbYAHG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 01:27:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 79721A89B;
	Tue,  8 Jan 2008 01:27:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03350A89A;
	Tue,  8 Jan 2008 01:27:13 -0500 (EST)
In-Reply-To: <20080108045514.1a506761.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 8 Jan 2008 04:55:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69842>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Thanks.  I already had Dan's s/gitlink/linkgit/ patch in my tree
to work aroudn AscciDoc issues but adjusting the patch was
trivial.

> @@ -843,4 +871,8 @@ receive.denyNonFastForwards::
>  transfer.unpackLimit::
>  	When `fetch.unpackLimit` or `receive.unpackLimit` are
>  	not set, the value of this variable is used instead.
> +
> +web.browser::
> +	Specify a web browser that may be used by some commands.
> +	Currently only gitlink:git-instaweb[1] and gitlink:git-help[1]
> +	may use it.
> -- 
> 1.5.4.rc2.38.gd6da3

Somebody seems to have recounted the patch lines incorrectly
here.  The hunk header should have read "@@ -843,3 +871,8 @@".
