From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-clean won't read global ignore
Date: Wed, 14 Nov 2007 09:42:48 +0100
Message-ID: <473AB508.4090109@op5.se>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>	<20071113225057.GB22836@artemis.corp> <7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 09:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsDqG-0006fd-0G
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 09:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbXKNImw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 03:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbXKNImw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 03:42:52 -0500
Received: from mail.op5.se ([193.201.96.20]:51594 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbXKNImv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 03:42:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 05D9E1F0870D;
	Wed, 14 Nov 2007 09:42:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRkWP26SFv5T; Wed, 14 Nov 2007 09:42:49 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 04D091F0870C;
	Wed, 14 Nov 2007 09:42:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64960>

Junio C Hamano wrote:
> (this is against 'maint', as I was in the middle of
> something else that is based on 'maint' when I started reading
> this thread).
> 

That's probably not a bad idea, as it really is a bug, and one
that can cause data-loss at that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
