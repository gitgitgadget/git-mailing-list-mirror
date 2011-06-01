From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2011, #14; Tue, 31)
Date: Wed, 01 Jun 2011 08:52:51 +0200
Message-ID: <4DE5E1C3.8000904@viscovery.net>
References: <7vhb8aij91.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:53:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRfIa-0005YN-4w
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 08:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab1FAGwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 02:52:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6442 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab1FAGwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 02:52:54 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QRfIR-00030f-KZ; Wed, 01 Jun 2011 08:52:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6500B1660F;
	Wed,  1 Jun 2011 08:52:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vhb8aij91.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174850>

Am 6/1/2011 0:43, schrieb Junio C Hamano:
> * ef/maint-win-verify-path (2011-05-27) 3 commits
>  - verify_path: consider dos drive prefix
>  - real_path: do not assume '/' is the path seperator
>  - A Windows path starting with a backslash is absolute
> 
> J6t had a reasonable question in the discussion; has it been resolved?

This particular question is resolved; I consider "verify_path: consider
dos drive prefix" a good change. But I haven't had a chance to review the
effects of the other two changes, yet.

-- Hannes
