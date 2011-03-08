From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Tue, 08 Mar 2011 16:25:18 -0500
Message-ID: <4D769EBE.40008@cfl.rr.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>	<AANLkTimp8B5Lv15qhGOwOzh+kqOS0g3Xwvgib8vyk+m+@mail.gmail.com>	<AANLkTinwHMULqPZSguYtJztuA4Oy6-s6Ah3_tcVVO7D9@mail.gmail.com>	<m2zkp9wwqe.fsf@igel.home> <AANLkTinJZFGVNSQVfCipo33h5uPpK0pFY10E203oTfhU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	git@vger.kernel.org
To: Ruben Laguna <ruben.laguna@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 22:25:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px4PO-0008U0-Af
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab1CHVZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:25:27 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63065 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab1CHVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:25:26 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=tLsyj04/L/SH/N6p42ldY6jXDYWe4pX5hAm6uRA1LKo= c=1 sm=0 a=tlzYqRVFg4UA:10 a=IkcTkHD0fZMA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=gyrN6ww6PLysaRx-40UA:9 a=AqeqPzW5goqkv_o__V5RSgTE_2sA:4 a=QEXdDO2ut3YA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:3889] helo=[10.1.1.235])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id F5/80-05134-0CE967D4; Tue, 08 Mar 2011 21:25:22 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTinJZFGVNSQVfCipo33h5uPpK0pFY10E203oTfhU@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168700>

On 3/7/2011 4:59 AM, Ruben Laguna wrote:
> Cloning it that way didn't help either,
> 
> But I have more info
> 
> If I set a bare repo and push my four branches to it (master, develop,
> gh-pages and experimental) the total size of the repo is 2.4MB
> (instead of 87MB)

Then there are other branches using that space.  Run git branch -a and
see what else is there.
