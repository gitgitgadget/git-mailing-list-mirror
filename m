From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Fri, 18 Dec 2009 14:22:27 +0100
Message-ID: <4B2B8213.1090104@viscovery.net>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de> <4B29106C.1040501@viscovery.net> <7vaaxhfcfe.fsf@alter.siamese.dyndns.org> <20091218130603.GA6193@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 14:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLcn2-0004va-CN
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 14:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbZLRNWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 08:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZLRNWd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 08:22:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55081 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbZLRNWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 08:22:32 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NLcmq-0000H3-Er; Fri, 18 Dec 2009 14:22:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 317BE1660F;
	Fri, 18 Dec 2009 14:22:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091218130603.GA6193@pcpool00.mathematik.uni-freiburg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please do not cull Cc list.

Bernhard R. Link schrieb:
> format-patch has to choose a parent. Choosing the first one make the
> most sense for me (as the first is the only real 'special' one).
> In the workflows I envision the first parent would also be the one with
> the clean history.

Then use

   git format-patch --first-parent upstream..

-- Hannes
