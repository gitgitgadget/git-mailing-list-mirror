From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: How to rebase after upstream was merged?
Date: Wed, 04 Jul 2007 15:45:14 +0200
Organization: eudaptics software gmbh
Message-ID: <468BA46A.C66E85CA@eudaptics.com>
References: <468B918E.FBCADCB9@eudaptics.com> <Pine.LNX.4.64.0707041426570.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:44:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I659x-00076z-OA
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759379AbXGDNom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759786AbXGDNom
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:44:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29500 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759057AbXGDNol (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:44:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I659s-000843-3d; Wed, 04 Jul 2007 15:44:40 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 246146EF; Wed,  4 Jul 2007 15:44:40 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.9 (+)
X-Spam-Report: AWL=-1.708, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51614>

Johannes Schindelin wrote:
> [...how to check for linear history...]
> I usually to
> 
>         test -z "$(git rev-list --parents origin..HEAD | grep " .* ")"

Ah, that's much better.

Thanks,
-- Hannes
