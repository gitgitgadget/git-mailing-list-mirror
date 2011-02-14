From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Mon, 14 Feb 2011 09:02:04 +0100
Message-ID: <4D58E17C.9090001@viscovery.net>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 09:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PotNx-0007KQ-6S
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 09:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190Ab1BNICL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 03:02:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62246 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1BNICK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 03:02:10 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PotNk-0005lY-Ot; Mon, 14 Feb 2011 09:02:05 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7AA561660F;
	Mon, 14 Feb 2011 09:02:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166696>

Am 2/6/2011 19:43, schrieb Martin von Zweigbergk:
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> new file mode 100644
> index 0000000..c04ce8a
> --- /dev/null
> +++ b/git-rebase--merge.sh

This should be mode 100755. (Ditto for git-rebase--am.sh in 19/31)

-- Hannes
