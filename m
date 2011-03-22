From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] Documentation/git-submodule.txt: Document the new
 'U' prefix of git submodule status on submodules with merge conflicts
Date: Tue, 22 Mar 2011 20:23:34 +0100
Message-ID: <4D88F736.209@web.de>
References: <51d033dc2978d62164dcb76b679bb7ebd9bc1802.1300784018.git.nmorey@kalray.eu> <4D886432.6060007@kalray.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:23:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q27BM-0005YB-3V
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab1CVTXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 15:23:52 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35250 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab1CVTXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:23:50 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id E491218B3791C;
	Tue, 22 Mar 2011 20:23:34 +0100 (CET)
Received: from [93.240.123.209] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q27B0-0006Oc-00; Tue, 22 Mar 2011 20:23:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D886432.6060007@kalray.eu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/aFAaedjVjoBBkNL5IasThmLk5uR/h9eCXOYyf
	9Dj4/tFpTMEZm2RIHYwFpaMxOv5hN4YQ3N2AJQ60j5uCRvj+na
	q3VOmVYdeKjVQAVD9eJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169768>

Am 22.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  Documentation/git-submodule.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 3a5aa01..1a16ff6 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -101,9 +101,10 @@ status::
>  	currently checked out commit for each submodule, along with the
>  	submodule path and the output of 'git describe' for the
>  	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
> -	initialized and `+` if the currently checked out submodule commit
> +	initialized, `+` if the currently checked out submodule commit
>  	does not match the SHA-1 found in the index of the containing
> -	repository. This command is the default command for 'git submodule'.
> +	repository and `U` if the submodule has merge conflicts.

Nit: The submodule doesn't have merge conflicts, the superproject does.
Maybe something like this (but I suspect a native speaker can come up
with something better ;-):

+	repository and `U` if a merge of the submodule commits produced
+	a conflict.

> +	This command is the default command for 'git submodule'.
>  +
>  If '--recursive' is specified, this command will recurse into nested
>  submodules, and show their status as well.

And I'd propose to squash this one into the first patch, as it documents
the behavior change done there.
