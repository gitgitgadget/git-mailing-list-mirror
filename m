From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 2/2] Change the description of '-M' and '-C' option.
Date: Thu, 8 Apr 2010 22:15:50 -0700
Message-ID: <q2y41f08ee11004082215y3cf6c581i3673b1dcc8bb3f37@mail.gmail.com>
References: <20100408100719.7fc89300@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ydirson@free.fr
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06ZQ-0004lf-8F
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab0DIFPv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 01:15:51 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:5946 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0DIFPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 01:15:51 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1080723qwh.37
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PVAK/J9sZLedQ3KkKPxhfv3pEqOEW3sJBb9eqj60FOk=;
        b=g/atsUTDcYrvCbFIRfYczSb0zpcbEipGm9D+/UMT1oZH1emEf0A87Ke3ruS5tsPr0C
         H+x/tMT0BA0SmqOpb6cSlze/mXwOrpuz0q4cTxhNO6Kq3BRdP+wVUJ6En0w8SEkJPe09
         YgGxFr4LwU9Yc5iU9qgIH23YLMzu4UFKPnucY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J0svKb3W6z6z2+dud+cg77o1Ohyn4x2hpqob+9C1ySTgHhPuE1MIVyu/WKr7R4jxMJ
         h36vWKDaqzwWNQTKnnXu6ozrcj9gmtJAy65+PLG7fK7hjZ9utawanqAmyphoTy1LRpNZ
         HlVzwXOkgT27kEkNSc2G/AkHAsdNaLLgdY1pY=
Received: by 10.229.95.147 with HTTP; Thu, 8 Apr 2010 22:15:50 -0700 (PDT)
In-Reply-To: <20100408100719.7fc89300@chalon.bertin.fr>
Received: by 10.229.190.21 with SMTP id dg21mr1699617qcb.69.1270790150284; 
	Thu, 08 Apr 2010 22:15:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144403>

Hi Yann,
On Thu, Apr 8, 2010 at 1:07 AM, Yann Dirson <dirson@bertin.fr> wrote:
> Very interesting addition, indeed - thanks much.
>
> Some information may still be missing, though:
>
> - the default value of the numeric argument to -M/-C
> - the meaning of numeric arguments to the various flags when several
> =A0are given (eg. what does "blame -M10 -C5 -C15" mean ?)
> - the numeric arguments are not visible in the summary

Ah, thanks a lot for these advice, I will add them on next version of
this patch.

> On another aspect, given the nature of repetitive -C we may want to w=
arn
> the user of bomb out if more than 3 occurences of the flag happen ?

En, sound rationale, I think. I will try another patch to add this. Tha=
nks!

Regards!
Bo
