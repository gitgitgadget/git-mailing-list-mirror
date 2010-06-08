From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] merge-recursive: demonstrate an incorrect conflict with
 submodule
Date: Tue, 08 Jun 2010 13:58:29 +0200
Message-ID: <4C0E3065.5070401@viscovery.net>
References: <4C1009EE-3A67-4DF9-9F45-493CD463AEF9@dazjorz.com> <4C0DDBC8.9030909@viscovery.net> <4C0E2AB4.2010008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Diederik van der Boor <vdboor@codindomain.com>
To: Sjors Gielen <dazjorz@dazjorz.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 13:58:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLxSD-0005fX-Sh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 13:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab0FHL6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 07:58:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56063 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754839Ab0FHL6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 07:58:31 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OLxRu-0007D9-4g; Tue, 08 Jun 2010 13:58:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D131D1660F;
	Tue,  8 Jun 2010 13:58:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4C0E2AB4.2010008@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148664>

Am 6/8/2010 13:34, schrieb Johannes Sixt:
> +test_expect_failure 'merge-recursive simple w/submodule result' '
> +
> +	git ls-files -s >actual &&
> +	(
> +		echo "100644 $o5 0	a"
> +		echo "100644 $o0 0	c"
> +		echo "100644 $c1 0	d"

Make this line
		echo "160000 $c1 0	d"
Sorry!

> +	) >expected &&
> +	test_cmp expected actual

-- Hannes
