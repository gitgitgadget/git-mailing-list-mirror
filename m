From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Disable filemode rebase tests in t3400-rebase.sh if no
    filesystem mode support
Date: Wed, 11 Feb 2009 11:09:35 +0100
Message-ID: <4992A3DF.4010707@viscovery.net>
References: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXC3p-0000Sv-OG
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZBKKJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbZBKKJv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:09:51 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15132 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZBKKJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:09:50 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXC2B-0007QY-Oo; Wed, 11 Feb 2009 11:09:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 228E16EF; Wed, 11 Feb 2009 11:09:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109397>

Alex Riesen schrieb:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> I'm honestly sorry for my contributions. They seem to be exclusively
> in the "make Git work in Windows" area.  Depressing.
> 
>  t/t3400-rebase.sh |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Very interesting. This test works unmodified here. On the other hand, I
have to skip the entire t4129-apply-samemode.sh.

-- Hannes
