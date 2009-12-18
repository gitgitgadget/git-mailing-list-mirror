From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 13:24:32 -0600
Message-ID: <fabb9a1e0912181124nef40a2dxac1b93f9dcc19bb8@mail.gmail.com>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net> 
	<7v4onoywws.fsf@alter.siamese.dyndns.org> <200912182004.25520.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 20:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLiS4-0006Qw-Hc
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 20:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbZLRTY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 14:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbZLRTYz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 14:24:55 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:40697 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbZLRTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 14:24:54 -0500
Received: by vws30 with SMTP id 30so1102409vws.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 11:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=pWv8IWe93X9yzIGM/Iz5piW3L6O96fPf7W2hOKCbr4M=;
        b=wk330VvA7h/5S7JzZGqsqGYjowqBlToRpPFIpybMn1ULgMUUmFQZ40v7jPP7dreGTk
         ufkzeGnZ1nsIulTBkHbGGFmOK+R0Twz/yxo1vrZhlOzLfT7S/J3mmXzNWaEcSPhzKpFa
         S5qRZphdQ9DTz7uqrFfFpJnefxWHNH8NSuQWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mgVsJYO0rEInaRjD3+FQQqc7wsMVvgpNMp0Qn2MaW6Vuc4CzHVCmr9RxJLi6gKvUgU
         ibn2f6PBTykGPExZonuTfRsa7uaQdh8TFye3ol7T4fUcWETDCPSPM4JVTiwyjD3kQIxu
         WFZtpPisyBYo8cBKf3/CohsfLBGJ0eyhBGaEM=
Received: by 10.220.126.224 with SMTP id d32mr3107151vcs.117.1261164292113; 
	Fri, 18 Dec 2009 11:24:52 -0800 (PST)
In-Reply-To: <200912182004.25520.j.sixt@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135430>

Heya,

On Fri, Dec 18, 2009 at 13:04, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Sorry to drag you into this discussion, but I felt this change is maint-worthy
> (because the behavior is not only risky, but dangerous).

I agree, shouldn't such a dangerous function at least require a flag?
'git read-tree --empty' or something?

-- 
Cheers,

Sverre Rabbelier
