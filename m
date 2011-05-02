From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] grep: add known breakage of coloring when using extended
 patterns
Date: Mon, 02 May 2011 13:41:13 +0200
Message-ID: <4DBE9859.8030408@viscovery.net>
References: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 13:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrVE-0001po-Ru
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322Ab1EBLlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:41:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42596 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214Ab1EBLlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:41:19 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QGrV3-00085S-Su; Mon, 02 May 2011 13:41:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 981A31660F;
	Mon,  2 May 2011 13:41:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172575>

Am 5/2/2011 13:35, schrieb Bert Wesarg:
> +test_expect_failure 'grep coloring does not honor boolean algebra' '

I'm sure you meant to say 'grep coloring honors boolean algebra', no?

-- Hannes
