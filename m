From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/SubmittingPatches: emacs whitespace
 tip
Date: Tue, 13 Jan 2009 00:28:39 -0800
Message-ID: <7v8wpfd2yw.fsf@gitster.siamese.dyndns.org>
References: <87k58zopg5.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 13 09:30:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMef5-0000RU-5R
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 09:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbZAMI2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 03:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbZAMI2r
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 03:28:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbZAMI2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 03:28:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D2A1A1C5F2;
	Tue, 13 Jan 2009 03:28:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B09111C5F1; Tue,
 13 Jan 2009 03:28:41 -0500 (EST)
In-Reply-To: <87k58zopg5.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Tue, 13 Jan 2009 11:27:38 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31B2267A-E14C-11DD-8C51-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105474>

jidanni@jidanni.org writes:

> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---
>  Documentation/SubmittingPatches |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index ba07c8c..7b64343 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -442,6 +442,8 @@ whitespaces (fatal in patches).  Running 'C-u g' to display the
>  message in raw form before using '|' to run the pipe can work
>  this problem around.
>  
> +Inside gnus or not, a (setq-default show-trailing-whitespace t) in
> +one's ~/.emacs file will reduce whitespace embarrassment incidents.

What bothered me a lot more is that this part (and only this part) talks
about patch acceptance tip, not patch submission tip.  The Gnus/Emacs
section needs a total rewrite, I think.

Having a separate patch acceptance tip is fine, but I do not think it
belongs to SubmittingPatches document, and the current text certainly does
not mesh well with its neighbours.
