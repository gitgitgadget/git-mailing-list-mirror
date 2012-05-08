From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] clone: fix progress-regression
Date: Tue, 08 May 2012 07:46:50 +0200
Message-ID: <4FA8B34A.2050204@viscovery.net>
References: <1336418593-2792-1-git-send-email-kusmabite@gmail.com> <7vtxzr4vua.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	peff@peff.net, rctay89@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 07:47:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRdGH-0000et-QV
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 07:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab2EHFq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 01:46:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58671 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab2EHFq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 01:46:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SRdGi-0006iu-OM; Tue, 08 May 2012 07:47:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A47F91660F;
	Tue,  8 May 2012 07:46:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vtxzr4vua.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197339>

Am 5/7/2012 21:47, schrieb Junio C Hamano:
> In real life, most of the checkout is fairly quick for even projects like
> the kernel, and the logic is an attempt to avoid cluttering the terminal
> with progress unless it takes unusually long and might make the user feel
> worried.

What is "unusually long"? On Windows, it can take its time to switch a
branch even if only a few dozen files are affected, the disk cache is
cold, and an on-access virus scanner is active. :-)

I appreciate the checkout progress indicator as eye candy every once in a
while.

-- Hannes
