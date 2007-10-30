From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Tue, 30 Oct 2007 11:26:35 +0100
Message-ID: <472706DB.1040106@op5.se>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:26:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImoJD-0002sB-EG
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbXJ3K0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXJ3K0k
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:26:40 -0400
Received: from mail.op5.se ([193.201.96.20]:34914 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbXJ3K0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 06:26:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AECC31730577;
	Tue, 30 Oct 2007 11:26:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n2yneUX+BEdV; Tue, 30 Oct 2007 11:26:33 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 4962A1730575;
	Tue, 30 Oct 2007 11:26:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska wrote:
> 
> My strange rule 10/10 adds a check that verifies if the local
> side has something interesting to push. Only in this case a
> pull make sense. If you do not have something new, a pull will
> be a fast-forward, and just a waste of time.
> 

Err... fast-forward pulls are not a waste of time. What a strange
notion. Perhaps I misunderstood, but this sentence jumped out at
me and immediately got filed under "decidedly odd".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
