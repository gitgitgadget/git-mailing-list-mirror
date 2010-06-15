From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Amending a merge commit doesn't update the rerere cache
Date: Tue, 15 Jun 2010 08:23:55 +0200
Message-ID: <4C171C7B.3060904@viscovery.net>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 08:24:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOPZ6-0003OP-NE
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 08:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab0FOGX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 02:23:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8800 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab0FOGX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 02:23:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OOPYy-0004XD-Ak; Tue, 15 Jun 2010 08:23:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 150BD1660F;
	Tue, 15 Jun 2010 08:23:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149161>

Am 6/15/2010 1:04, schrieb Jay Soffian:
> Subject says it all, but I'll elaborate.
> 
> During the course of testing a merge, I'll sometimes realize there was
> a mistake and I'll amend the merge commit. Sadly this doesn't update
> the rerere cache.

There is

	git rerere forget that/conflicted/file

It definitely works as long as the conflict is still recorded in the
index; I'm not sure if it works after you have staged the updated resolution.

-- Hannes
