From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Local uncommitted changes, not checked in to index with gitk
Date: Wed, 13 Aug 2008 16:19:44 +0200
Message-ID: <48A2ED80.5000808@viscovery.net>
References: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com>	 <vpqljz1cfkm.fsf@bauges.imag.fr> <ace3f33d0808130553g318ce97gf654c3f998d4047a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHFM-00063j-SW
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbYHMOTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbYHMOTs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:19:48 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24608 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbYHMOTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:19:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KTHCT-00080s-91; Wed, 13 Aug 2008 16:19:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 114664FB; Wed, 13 Aug 2008 16:19:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <ace3f33d0808130553g318ce97gf654c3f998d4047a@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92218>

srinivas naga vutukuri schrieb:
> I just done "git status", Its giving the following output. But i
> have't done around these files anything at all, not opened, etc.
> 
> -------------
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   include/linux/netfilter/xt_connmark.h
...

You are on a case-insensitive file system. The linux kernel source
requires a case-sensitive file system because the sources contain both of
these files:

include/linux/netfilter/xt_connmark.h
include/linux/netfilter/xt_CONNMARK.h

(ditto for the other cases that you observed).

-- Hannes
