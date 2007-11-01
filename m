From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Thu, 1 Nov 2007 09:36:24 +0100
Message-ID: <0A8A6A99-4C8B-4056-9068-DA54B69B08B5@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>	<11935935812741-git-send-email-prohaska@zib.de>	<1193593581114-git-send-email-prohaska@zib.de>	<1193593581486-git-send-email-prohaska@zib.de>	<11935935812185-git-send-email-prohaska@zib.de>	<11935935822846-git-send-email-prohaska@zib.de>	<11935935821136-git-send-email-prohaska@zib.de>	<11935935823045-git-send-email-prohaska@zib.de>	<11935935821800-git-send-email-prohaska@zib.de>	<11935935823496-git-send-email-prohaska@zib.de>	<11935935821192-git-send-email-prohaska@zib.de>	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>	<B3C76DB8-076D-4C43-AC28-99119A05325C@z
  ib.de>	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <47298BD7.2000902@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 01 09:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InVXA-0005pq-4l
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 09:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbXKAIf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 04:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXKAIf6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 04:35:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:41660 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500AbXKAIf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 04:35:57 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA18Z1pX012378;
	Thu, 1 Nov 2007 09:35:01 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA18Z092016589
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 1 Nov 2007 09:35:00 +0100 (MET)
In-Reply-To: <47298BD7.2000902@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62928>


On Nov 1, 2007, at 9:18 AM, Andreas Ericsson wrote:

> Junio C Hamano wrote:
>
>> (actually, shared repository people seem to
>> prefer "fetch + rebase" over "pull" which is "fetch + merge").
>
> That's definitely true. The number of useless merge-commits we
> have in our repos is annoying, and has twice made bisect a bit
> troublesome for no good reason.

Can you describe a bit more what's "annoying" about them?
Is it the visualization? Or are there more problems; like
the trouble with bisect?

I'm trying to estimate if it's worth teaching _all_
developers rebase or if we should just live with the "useless"
merge-commits.

	Steffen
