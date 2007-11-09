From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 9 Nov 2007 12:44:53 +1100
Message-ID: <ee77f5c20711081744p5d7b46fo88a582b9f5dbdab8@mail.gmail.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	 <11945685732608-git-send-email-dsymonds@gmail.com>
	 <7vtznwxl59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIvo-0005w9-Vk
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761176AbXKIBo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760872AbXKIBo4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:44:56 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:24855 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760424AbXKIBoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:44:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so333176rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 17:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eVX5pqHcm073YwaY08ddwnEk5gyzLWFcEyHU3A4QI2Y=;
        b=sBL/Hjoz3xX6crjD9BUGJMDhOphzRgY7ZNNUWSwSx0U0arZGDpizOyFI0qfcgmz+xnVo6XzMgLNIycBy2cuouavWH182KWaUYfQZzHNdsH2Yhiy/ilJPMmxPSu0lbTQIPqTHrTmXW06XqlAK8Z0sIdnRxhVY/aoi7hcmaMRvZVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXw7TBkOqheDmYr17pt6aEDWtGA+A09APmIfSlXXdUHCZjt3oJO7gxv0GumJMq+sqmCe8zz+jE1ErCosRreBu0mOCc15gPMzV0X38JqdpbULsB1mB85RUdDGmvm7JhOcG6CuREl6zPgpEmTd7dHABTbgQyEcj9ZZjz1kC2FXu1o=
Received: by 10.141.113.6 with SMTP id q6mr683296rvm.1194572693715;
        Thu, 08 Nov 2007 17:44:53 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Thu, 8 Nov 2007 17:44:53 -0800 (PST)
In-Reply-To: <7vtznwxl59.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64111>

On Nov 9, 2007 12:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Symonds <dsymonds@gmail.com> writes:
>
> > Signed-off-by: David Symonds <dsymonds@gmail.com>
> > ---
> >       Test 5 in this series fails because of a bug in git-ls-files, where
> >               git-ls-files t/../
> >       (with or without --full-name) returns no files.
>
> Heh, you shouldn't do that ;-)
>
> Seriously, that's a long standing limitation in the code, not to
> deal with arbitrary combination of ups and downs, but I do not
> think there is any fundamental reason to disallow something
> like:
>
>         cd Documentation && git ls-files --full-name ../t
>
> Patches welcome.

So you're otherwise happy with my tests, despite one of them
triggering an (unrelated to git-checkout) bug? Or would you prefer I
remove that particular failure from the tests and resend?


Dave.
