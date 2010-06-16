From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] am: gather GIT_AUTHOR_* from original commit when
 rebasing
Date: Wed, 16 Jun 2010 08:30:53 +0200
Message-ID: <4C186F9D.1060608@viscovery.net>
References: <1276641564-2074-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 08:31:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOm9S-0002J9-4u
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 08:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab0FPGa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 02:30:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22686 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab0FPGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 02:30:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OOm9F-0005eG-Tb; Wed, 16 Jun 2010 08:30:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A605B1660F;
	Wed, 16 Jun 2010 08:30:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1276641564-2074-1-git-send-email-jaysoffian@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149252>

Am 6/16/2010 0:39, schrieb Jay Soffian:
> +	if test -f "$dotest/original-commit"
> +	then
> +		original_commit="$(cat "$dotest/original-commit")"
> +		GIT_AUTHOR_NAME="$(GIT_PAGER='' git log --format=%an -1 "$original_commit")"
> +		GIT_AUTHOR_EMAIL="$(GIT_PAGER='' git log --format=%ae -1 "$original_commit")"
> +		GIT_AUTHOR_DATE="$(GIT_PAGER='' git log --format=%aD -1 "$original_commit")"

I think you can use the function get_author_ident_from_commit() for this.
See git-sh-setup.

-- Hannes
