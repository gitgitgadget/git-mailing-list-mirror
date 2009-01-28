From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Emacs git-mode feature request: support fill-paragraph correctly
Date: Wed, 28 Jan 2009 13:32:33 -0800
Message-ID: <7vk58fktfy.fsf@gitster.siamese.dyndns.org>
References: <87tz7mth3g.fsf@write-only.cryp.to>
 <873af59fkm.fsf@wine.dyndns.org> <878wow7sgx.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:34:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSI30-000427-6t
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbZA1Vcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbZA1Vcl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:32:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZA1Vck (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:32:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 90C751D80A;
	Wed, 28 Jan 2009 16:32:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A78921D801; Wed,
 28 Jan 2009 16:32:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 302DFD22-ED83-11DD-8DE3-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107582>

Peter Simons <simons@cryp.to> writes:

> Hi Alexandre,
>
>  > diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
>  > index 3c37d0d..e314c44 100644
>  > --- a/contrib/emacs/git.el
>  > +++ b/contrib/emacs/git.el
>  > @@ -1331,6 +1331,7 @@ Return the list of files that haven't been handled."
>  >  					 (log-edit-diff-function . git-log-edit-diff)) buffer)
>  >  	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
>  >        (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
>  > +      (setq paragraph-separate (concat (regexp-quote git-log-msg-separator) "$\\|Author: \\|Date: \\|Merge: \\|Signed-off-by: \\|\f\\|[ 	]*$"))
>  >        (setq buffer-file-coding-system coding-system)
>  >        (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
>
> that patch has the desired effect (tested with GNU Emacs 22.3.1 and
> GIT 1.6.1). Thank you very much.
>
> Now, I'd be hugely in favor of applying that change to the repository
> so that future versions of GIT have it.

Alexandre?
