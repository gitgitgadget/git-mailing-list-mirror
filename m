From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-am failed, what's next ?
Date: Thu, 22 Feb 2007 11:09:18 +0100
Message-ID: <38b2ab8a0702220209t33d78681gb260930069aa699b@mail.gmail.com>
References: <38b2ab8a0702220022wab25519hbb57629934e7f104@mail.gmail.com>
	 <200702220848.06637.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 11:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKAtI-0001LV-5S
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 11:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbXBVKJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 05:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbXBVKJ2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 05:09:28 -0500
Received: from qb-out-0506.google.com ([72.14.204.237]:30706 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbXBVKJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 05:09:27 -0500
Received: by qb-out-0506.google.com with SMTP id z8so58631qbc
        for <git@vger.kernel.org>; Thu, 22 Feb 2007 02:09:27 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+BcS/jEwdFCRcNVfcDuKOBL58HslAuNcYryeCuO/L0BVxiEF/yjtnlMGuLT92iwN4TgLw3/AZI8LXaZInYHrkWrlPp8QIJutjT5xZpZbePMKUpiTEtgVzx0MXTxh87/CuMcvDDbF3GSrPSuxC3u4NBCmXGly5wQYeXVSlyTrwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XHqPJbl6ksvPq1YPVwEKtJ+O9Nt7gBzK83v4rk6nm0/d/YNzC+rZnzo4wCrwOytWJl084zdF9fhZgWm37OCUV8e+h0VzKfZeFWBLGYHnrxKARmwcuPhhkfPIW0pmzYl/wVCMoVbQhzlEHWilwlWc/+dRIaEcemmKqQS1p5udonc=
Received: by 10.115.78.1 with SMTP id f1mr188266wal.1172138963395;
        Thu, 22 Feb 2007 02:09:23 -0800 (PST)
Received: by 10.115.47.14 with HTTP; Thu, 22 Feb 2007 02:09:18 -0800 (PST)
In-Reply-To: <200702220848.06637.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40344>

Hi,

On 2/22/07, Andy Parkins <andyparkins@gmail.com> wrote:
> I've often wished for more information from git-am (or more correctly,
> git-apply).  However, you can sometimes get what you need to know another
> way.
>

it seems pretty the same flow that I'm used to doing except that I
used 'patch' instead of 'git-apply'...

>  * First, make sure that your current tree is checked in so you can get back
>    to it easily.  Maybe switch to a new temporary branch to make it easy to
>    return to your current point.
>  * Then run git-am to get the number of the failing patch, in your example
>    it's "0001"
>  * Now, try and apply the patch manually, but turn on verbose and reject in
>    git-apply
>     $ git-apply --verbose --reject .dotest/0001
>    This is the only way I've found to get git to tell you which hunk of the
>    patch is being rejected.  Unfortunately, it will also leave you with that
>    patch partially applied.

hm, I actually used 'patch' instead because I wasn't aware of
'--reject' option. The default behaviour is different, and I'm not
sure to know why...

Obviously I really should play with it.

> Hope that helps.

thanks
-- 
Francis
