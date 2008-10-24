From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Only update the cygwin-related configuration during state auto-setup
Date: Fri, 24 Oct 2008 09:47:03 +0200
Message-ID: <81b0412b0810240047h4a9b1d04m44a1a76df722d075@mail.gmail.com>
References: <81b0412b0810230607sfea05ddm62bd03f837fc922e@mail.gmail.com>
	 <7viqri35dq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mlevedahl@gmail.com>, spearce@spearce.org,
	dpotapov@gmail.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 09:48:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtHPG-0002AQ-2N
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 09:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYJXHrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 03:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYJXHrI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 03:47:08 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:59019 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYJXHrF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 03:47:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so251359ywe.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hPvN02/0HpSprS9TUOBubdWpSRwoW5xmMk70E/X2DJU=;
        b=CE33Ws9xfusk7zsKDNrr7Srz9MDukovD+yYhbm88K30GKOFMrOBqO0BkkhPpEMxXfM
         D/9RRPc2fI/NjC3stBiUUHbCIF0FjNXgsNmxY/nXnx9CcUK8Y/tfILeg2R2qLJFSkWEw
         gEBK7s30zbB0u1+gGkNZG1tp31qgjCzAflprg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VpamhyOcPzqcrxM8H2zOQVGw9U2lxedYAcuayvrkhqgmw4czqUAVq6evVwCrmomYFN
         4UC9MPsZDnL7feDbmtmw+zdWH7JuyiCW+jIEAtuS8dZq5m4Ooy50myJLWmZGHQXNA/BG
         5/YHg7PN0ExAohrlDa+ex4RRBskarpEL4tY1s=
Received: by 10.100.137.12 with SMTP id k12mr2083270and.55.1224834424088;
        Fri, 24 Oct 2008 00:47:04 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Fri, 24 Oct 2008 00:47:03 -0700 (PDT)
In-Reply-To: <7viqri35dq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99017>

2008/10/24 Junio C Hamano <gitster@pobox.com>:
> Perhaps we should use a separate variable as the original patch did, in:
>
>  http://article.gmane.org/gmane.comp.version-control.git/97987
>
> How about doing it like this instead?

I like this. Will start testing it over next european night, as soon as
the current test run finishes. In about 6 hours, that is :-/
