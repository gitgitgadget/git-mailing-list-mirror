From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] rebase -i: fix squashing corner case
Date: Fri, 24 Aug 2007 09:18:45 +0200
Organization: eudaptics software gmbh
Message-ID: <46CE8655.1DD79C48@eudaptics.com>
References: <46CB004C.AC39D562@eudaptics.com> <Pine.LNX.4.64.0708222334510.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTRX-0003v9-5O
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbXHXHSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 03:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXHXHSv
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:18:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35125 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbXHXHSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 03:18:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IOTRM-0001Hq-Ko; Fri, 24 Aug 2007 09:18:44 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 29F0F29AB; Fri, 24 Aug 2007 09:18:44 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.371, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56555>

Johannes Schindelin wrote:
> 
> When squashing, rebase -i did not prevent fast forwards.  This could
> happen when picking some other commit than the first one, and then
> squashing the first commit.  So do not allow fast forwards when
> squashing.

This indeed fixes the problem. Hence:

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

Junio, please apply.

-- Hannes
