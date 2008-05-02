From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: reflog/show question
Date: Fri, 2 May 2008 11:51:44 +0930
Message-ID: <93c3eada0805011921j4c1c7f8co864e7366e2ab8ed5@mail.gmail.com>
References: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
	 <20080428092410.GD16153@sigill.intra.peff.net>
	 <93c3eada0804281847q267611aeke51b482cfbe100d6@mail.gmail.com>
	 <20080429201214.GB20509@sigill.intra.peff.net>
	 <93c3eada0804291506n7432b348p2b726926b5fc8f80@mail.gmail.com>
	 <20080429230715.GB22598@sigill.intra.peff.net>
	 <93c3eada0804291712u19c1047bl6d44df4ca025bb4d@mail.gmail.com>
	 <93c3eada0804291726l454ccbbv96217d6657d79ded@mail.gmail.com>
	 <93c3eada0804301715r724e8b8xf0ed64ebe016beea@mail.gmail.com>
	 <20080501135354.GB10135@sigill.intra.peff.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 04:22:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrkux-0006Fs-3e
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 04:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727AbYEBCVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 22:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbYEBCVq
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 22:21:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:10946 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbYEBCVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 22:21:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so767496fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=L2p8go3J2MsZUbBdrnUfhHdCxQUU1qCpZoDpF0/Bzmc=;
        b=FJ9kRr77UaFU8YMy85/Rsaq+HrzUm8CXAyCvqL4ODF3PCRuVPaxYykJs3LOc+TkIW4jNoEzjuQ3DrxflfhsOJYa4xZUGM3JduaOprHEyZCnO+/PnMezIMg2jN2s4tpIahCRueb7PXe3GzHedVaeriAKWX1MDmpusibTsISlBCEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=suEs7WntWCeMmIfj9sMzTdFO8Nl9TvzxdxEEDvYtOswfwqT5pxMAPPOB/IHkO0jq1q19cw3fUG1Z5iKUsYCMGDiv5VZpZ4VmmO+Bg0SmBIbkCfoLnJm4fu1hH2uJ6hZsGC0We0Kq6H4A/O3xY9tX8g1NP+6MYWefSpuMCQpFmIM=
Received: by 10.82.170.2 with SMTP id s2mr290309bue.59.1209694904367;
        Thu, 01 May 2008 19:21:44 -0700 (PDT)
Received: by 10.82.105.8 with HTTP; Thu, 1 May 2008 19:21:44 -0700 (PDT)
In-Reply-To: <20080501135354.GB10135@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80949>

On 5/1/08, Jeff King <peff@peff.net> wrote:
> On Thu, May 01, 2008 at 09:45:40AM +0930, Geoff Russell wrote:
>
>  > N.B. This problem has vanished -- which means its probably something I
>  > messed up. I haven't worked out what yet, but I will.  Apologies for
>  > any time wasted.
>
>
> Vanished randomly, or after you upgraded to the latest master? Did you
>  miss the "fix reflog approxidate parsing bug" patch I posted?

I did a "git pull origin" and used both 1.5.5.1 and my original
1.5.4-rc4 and couldn't
reproduce the problem. I have just looked at the patch and
it certainly sounds like it is attacking the problem that I was
seeing, but it shouldn't
have affected the 1.5.4-rc4 code.

Thanks
Geoff.

>
>  -Peff
>


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
