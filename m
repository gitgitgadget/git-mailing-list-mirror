From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git_getpass: fix ssh-askpass behaviour
Date: Mon, 13 Dec 2010 10:48:17 +0100
Message-ID: <4D05EBE1.1020602@viscovery.net>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com> <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 10:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS517-0004Xi-GB
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab0LMJsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 04:48:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61780 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751819Ab0LMJsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:48:22 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PS510-0000D0-9v; Mon, 13 Dec 2010 10:48:18 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0F32A1660F;
	Mon, 13 Dec 2010 10:48:18 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163534>

Am 12/12/2010 13:32, schrieb Alexander Sulfrian:
> call ssh-askpass only if the display environment variable is also set

Not good: On Windows, we want to call out to SSH_ASKPASS even if DISPLAY
is not set (it almost never is).

-- Hannes
