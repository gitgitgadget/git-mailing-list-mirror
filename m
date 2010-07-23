From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Thu, 22 Jul 2010 23:04:23 -0500
Message-ID: <AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 06:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc9VB-0006s6-S6
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 06:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab0GWEEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 00:04:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41143 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0GWEEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 00:04:44 -0400
Received: by gyg10 with SMTP id 10so1172114gyg.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 21:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=g1Tl4PrOuvz9eg+GPxDaZ0PGLbwnV3ijlY1umYGSof4=;
        b=dKvujaDp8RIlo8KMedXeHhNbPoIwYxP+n9D43XrtWMJeZCjyOWTY41WT9pohDR4292
         fZXvNw1zCL2ix78D2D23vpV+5EPkHqFd352Ju4n34NCwUXybcngVm0jtYXV2my7p2i6n
         UGi4sYnXzsPtwUoaBWzqAqeRAPtw8tk0Z2X0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ub5PKk6ni2MaiEbeYpgASGEcv+I1IeJaCDGJaJ3xw24kiYjtWrai4x7Sgq05LYZM8y
         1zIKyGAQ8m4mEYZcg2Evm/pX1UDpZvi4wAyu46MxKBlblMt3IgzFnqh3PKlZMJqYdRZW
         C6SkI+S4M6/GOjqZrCOrp70/5wHLbVtutPNgs=
Received: by 10.150.179.20 with SMTP id b20mr4958295ybf.312.1279857883173; 
	Thu, 22 Jul 2010 21:04:43 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Thu, 22 Jul 2010 21:04:23 -0700 (PDT)
In-Reply-To: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151503>

Heya,

On Thu, Jul 22, 2010 at 21:39, Junio C Hamano <gitster@pobox.com> wrote:
> Somebody off-list suggested removing gitk and git-gui directories from my
> repository and I've been playing with the idea and kind of like the end
> result.

The neighboring thread [0] about git subtree seems highly relevant to
this decision. Avery, do you perhaps any additional insights wrt this
particular use case?

I on one hand like that we're going to (finally) start dogfooding
submodules, but after reading Avery's emails I feel unsure whether
that really is the right course of action...

[0] http://thread.gmane.org/gmane.comp.version-control.git/151408

-- 
Cheers,

Sverre Rabbelier
