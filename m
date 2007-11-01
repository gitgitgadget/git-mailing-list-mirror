From: "Simon Sasburg" <simon.sasburg@gmail.com>
Subject: Re: [PATCH] Make git-mailinfo strip whitespace from the start of the mail file.
Date: Thu, 1 Nov 2007 22:41:01 +0100
Message-ID: <981e6de60711011441n5bef772cuda381c539c0a2603@mail.gmail.com>
References: <1193951139-2312-1-git-send-email-Simon.Sasburg@gmail.com>
	 <7vd4utabx0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhn4-0004RA-IG
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbXKAVlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbXKAVlE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:41:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:44623 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbXKAVlC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:41:02 -0400
Received: by wa-out-1112.google.com with SMTP id v27so718370wah
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aKroAGysy09/YHVKGC7s41XEqbzgueas5geynE8PA6A=;
        b=i4mPU6WojDMg1RVYDaEdrFXskzqJgdSPTah4KdtGZhN91VAZW1f1zB+Ql7APdG4qlDIMBGVoLWCkSDw8sW2IOmo6BgTE6aUiVqESO5PtE0B1fHfyn1gen019ZdnKH3UHefsztWZDvHGXy4zvj1VhbvQ2hmfYWGyZm4rRT11Kplk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=doZ248p0jKvlm+may6s0FSV9EKCoYtACvSFkLnv/3dCOTuBLbeC2eOO/b4R6PxdtbWx25NPHfDlxNq1VOnL2DrIcDJxjXXCSERH1mhFo6jMmzf9O+jolg1A0d7viLK3KX01n/iHxxDcMlMGfzUh2kq0l9dDvK6yv+Njhb6k5flk=
Received: by 10.114.199.1 with SMTP id w1mr1115557waf.1193953261083;
        Thu, 01 Nov 2007 14:41:01 -0700 (PDT)
Received: by 10.114.124.16 with HTTP; Thu, 1 Nov 2007 14:41:01 -0700 (PDT)
In-Reply-To: <7vd4utabx0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Just to help me understand why this change is needed...
>
> Are you using mailinfo directly without splitting with mailsplit
> first?

Well, when using gmail's web interface, when reading a mail, there is
this option to show the raw mail text (headers+body) with the 'show
original' option.

If you do 'save as..' in your browser to save what you get with that,
and try to do git-am on that file, it fails because it starts with
some whitespace.

With this patch git-am works on these files.

So, i'm not using mailsplit or any other mail tools at all, just my
browser and git.
