From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 9 Nov 2007 20:10:17 +1100
Message-ID: <ee77f5c20711090110s5d6c533et5e1e016a95fde943@mail.gmail.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	 <11945685732608-git-send-email-dsymonds@gmail.com>
	 <47340895.6000403@viscovery.net>
	 <ee77f5c20711082324s39a9d441tc05c5a27e6d39f3e@mail.gmail.com>
	 <7v7ikrx2st.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711090014qfed56e7y446c014399e47a82@mail.gmail.com>
	 <7vfxzfvlch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 10:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPsq-0003Tf-HD
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 10:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXKIJKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 04:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXKIJKU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 04:10:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:59262 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbXKIJKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 04:10:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so413286rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 01:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pwyJis1p7Tp8b+gpwlof+Ye4xGMI7zAPFajFZk8vGEA=;
        b=snUE8PV+eW/j2+s4u/Fu7mc3xt41bFnda2Nf16aNberZHv477c1a43WSyrSinz3g+tbWvEQeMp7w8MKHISs0TgeEiTFWjZ4Bi36F1UoZrI6AA/fPfcW3JAbse+5mMh7YzFIuSUKbXGY8NwfBIhAzpmao/BZmxV2cAwkxNgoc9BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D/CaAnAkBVKsBWKJ/6g6wbe631M9xKNGoQHEEItrvvILpOu6bJszMyX1pfivk/2tg/fD/c/3bASncVbcFH3sTWW2irrlfeJDEiTQ3vwdIGKtYonhe+5P+Hxf0Vy4/BE2nbBCq+tXePWIxGK/NQtoRer461caOW3CXdHXfx3zIyc=
Received: by 10.141.113.6 with SMTP id q6mr840639rvm.1194599418030;
        Fri, 09 Nov 2007 01:10:18 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Fri, 9 Nov 2007 01:10:17 -0800 (PST)
In-Reply-To: <7vfxzfvlch.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64147>

On Nov 9, 2007 8:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
>
> > So what would you prefer? Bracketing the whole test in parentheses
> > looks ugly, but I can do that if that's the only option. If I look at
> > t5510-fetch.sh (one of yours, Junio), there is no directory
> > restoration in the case of test failure, as in my original patch.
>
> Yes, that is what I was referring to as "bad examples".  The way
> t4116 goes down to different directory do not look ugly to me.

Okay, thanks -- that's a useful example. I'll resend the patch shortly.


Dave.
