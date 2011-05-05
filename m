From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 05 May 2011 09:49:14 +0200
Message-ID: <4DC2567A.1060502@viscovery.net>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com>	<1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>	<4DC2418E.4070006@viscovery.net> <20110505094147.22e3d158@mkiedrowicz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 09:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHtJN-0005UX-LY
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 09:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab1EEHtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 03:49:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30658 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752633Ab1EEHtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 03:49:19 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHtJD-000512-Bq; Thu, 05 May 2011 09:49:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1B3C01660F;
	Thu,  5 May 2011 09:49:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110505094147.22e3d158@mkiedrowicz>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172815>

Am 5/5/2011 9:41, schrieb Michal Kiedrowicz:
> But I can abstract these calls to die_pcre_not_supported() to not
> repeat die() message.

Gah! Don't over-engineer. The compiler will un-duplicate the message texts
for you if you carefully copy-and-paste them.

-- Hannes
