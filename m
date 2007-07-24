From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 15:33:47 +0200
Organization: eudaptics software gmbh
Message-ID: <46A5FFBB.2F3B12CF@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site> 
	 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
	 <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKWF-0005Uk-DZ
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757729AbXGXNdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbXGXNdk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:33:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64274 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757590AbXGXNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:33:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IDKW9-0008Qw-Hq; Tue, 24 Jul 2007 15:33:37 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6F5E555DD; Tue, 24 Jul 2007 15:33:37 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.338, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53589>

Johannes Schindelin wrote:
> negatives="$(git rev-parse "$@" | while read line
>         do
>                 case "$line" in
>                 $_x40) ;;
>                 *) echo "$line";;
>                 esac
>         done)"

Ah, and you must move the definition of _x40 up a couple of lines.

-- Hannes
