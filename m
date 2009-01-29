From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: Re: [PATCH] git-cvsserver: run post-update hook *after* update.
Date: Thu, 29 Jan 2009 15:26:28 -0800
Message-ID: <d4bc1a2a0901291526v48e61c1dtde35fa8b77c71560@mail.gmail.com>
References: <7viqo61mfq.fsf@gitster.siamese.dyndns.org>
	 <1233266282-8010-1-git-send-email-stefan.karpinski@gmail.com>
	 <7v3af1enkq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>,
	Michael Witten <mfwitten@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:27:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSgIb-0002BI-2N
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbZA2X0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbZA2X0a
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:26:30 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:8079 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbZA2X03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 18:26:29 -0500
Received: by wa-out-1112.google.com with SMTP id v33so82371wah.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 15:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9oEH6XRXFE6a9CZHDpbqjaOAx/vwOrZUGPPJu2pZMsg=;
        b=NyrcgRnLV0TfsNk/LHETgVIAJSN8/5o88NHSeZFoMTvy+BCTXhDaglnJJaQ/lagIpt
         Q52E+l9E99P6MAij821e/ikkPljyNqnt4KrIh3b+sVCLCEDQ/8EL+nuLwgiUOPNmU/9G
         ftGjSVX7MtKFRfiIMJgrzywlFWK32j9218wCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kfy7jFlqVOGfcvUKT6gCVltF8YNldfN/wkuMr/ShdQy2BNpErAbsKkI+RCnUQcRBUz
         kro4Bo4eJttYHsTbTPW8SHI0olCSsWLKRPNr4M1i4qdaeKzTFbrrSmu/R8VMd7hZCN9N
         mDniSHMPRTasq7Rqx0FtnMSb+zCrn/tHzHZsU=
Received: by 10.115.91.11 with SMTP id t11mr344707wal.112.1233271588214; Thu, 
	29 Jan 2009 15:26:28 -0800 (PST)
In-Reply-To: <7v3af1enkq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107753>

On Thu, Jan 29, 2009 at 2:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think I've seen this one before and I thought it was a sensible thing to
> do (and perhaps I even said so here).

You said it looked sane but that I should resend CCing knowledgable parties.

> Is this a resend?  If so, let's queue it in at least 'next' and see if
> anybody screams ;-).  For a program near the fringe like cvsserver, not
> many people run it but the small number of people who run it gets hurt
> rather quickly if the updated behaviour breaks their existing practice,
> and sometimes breaking things for them would be the only way to extract
> any response.  Yes, it is very unfortunate.

Yes, it is a resend, but I expanded on the commit message, including
my analysis of the potential impact.
