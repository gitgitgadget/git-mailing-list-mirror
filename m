From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jan 2010, #06 draft)
Date: Wed, 20 Jan 2010 13:37:42 +0100
Message-ID: <4B56F916.7090503@viscovery.net>
References: <7veill3wgc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 13:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXZoz-0002yC-CR
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 13:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0ATMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 07:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332Ab0ATMhv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 07:37:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22093 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0ATMhs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 07:37:48 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXZod-0008C5-Br; Wed, 20 Jan 2010 13:37:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1A41C1660F;
	Wed, 20 Jan 2010 13:37:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7veill3wgc.fsf@alter.siamese.dyndns.org>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137547>

Junio C Hamano schrieb:
> * jc/symbol-static (2010-01-18) 17 commits
>   (merged to 'next' on 2010-01-18 at d063267)

Now that compat/mingw.c does not call tm_to_time_t anymore, you could dig
up the patch that touches date.c from your reflog and put it back in this
series. I think that nobody minds that the topic alone will not build on
Windows, as long as it builds when it is merged to master.

> * jc/cache-unmerge (2009-12-25) 9 commits
>   (merged to 'next' on 2010-01-13 at 2290c44)
>  + rerere forget path: forget recorded resolution

Heads up: there is something fishy with the pathspec on Windows (foo\bar
is not recognized as foo/bar, but it should be). Will investigate.

-- Hannes
