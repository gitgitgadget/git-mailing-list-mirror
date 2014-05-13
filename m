From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 1/2] git-show: fix 'git show -s' to not add extra terminator
 after merge commit
Date: Tue, 13 May 2014 07:57:08 +0200
Message-ID: <5371B434.7010506@viscovery.net>
References: <20140512230943.GC32316@wheezy.local> <20140512231029.GD32316@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue May 13 07:57:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk5iK-0002oy-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 07:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbaEMF5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 01:57:17 -0400
Received: from so.liwest.at ([212.33.55.19]:52931 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbaEMF5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 01:57:16 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Wk5i9-0002NV-Og; Tue, 13 May 2014 07:57:10 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5993816613;
	Tue, 13 May 2014 07:57:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140512231029.GD32316@wheezy.local>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248746>

Am 5/13/2014 1:10, schrieb Max Kirillov:
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -25,6 +25,7 @@ test_expect_success 'set up a bit of history' '
>  	git checkout -b side HEAD^^ &&
>  	test_commit side2 &&
>  	test_commit side3
> +	test_merge merge main3
>  '

Broken &&-chain.

-- Hannes
