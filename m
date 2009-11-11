From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Wed, 11 Nov 2009 09:58:43 +0100
Message-ID: <4AFA7CC3.6020500@viscovery.net>
References: <4AE945D0.5030403@viscovery.net> <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch> <4AFA7624.5040400@viscovery.net> <4AFA7B9A.4090005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:58:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N892X-0005ok-W2
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZKKI6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbZKKI6r
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:58:47 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3954 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750991AbZKKI6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:58:47 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N892K-0007VX-6d; Wed, 11 Nov 2009 09:58:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 072116D9; Wed, 11 Nov 2009 09:58:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AFA7B9A.4090005@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132626>

Johannes Sixt schrieb:
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -266,7 +266,7 @@
> 
>  # we need "--" only if there are no path arguments in $@
>  nonrevs=$(git rev-parse --no-revs "$@") || exit
> -dashdash=${nonrevs+"--"}
> +test -z "$nonrevs" && dashdash=-- || dashdash=
>  rev_args=$(git rev-parse --revs-only "$@")
> 
>  case "$filter_subdir" in

Arrgh! I should have indented these lines so that they
do not count as patch text.

Sorry.

-- Hannes
