From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Fixed default install location
Date: Sun, 27 Jul 2008 09:21:06 +0100
Message-ID: <b0943d9e0807270121x43b0a454g1042c0cfe650f2c1@mail.gmail.com>
References: <20080724202031.55dec8e8@whitehouse.id.au>
	 <b0943d9e0807251446w1e9ed73erfa7c1638191d88a@mail.gmail.com>
	 <20080727162750.25b7cdf3@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel White" <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Sun Jul 27 10:22:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN1W7-0000IQ-N9
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 10:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbYG0IVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 04:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbYG0IVK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 04:21:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:55324 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYG0IVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 04:21:07 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2617266waf.23
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SdGA6m4uX8i0hWc8eufwoXQkqXvR1Lxq/mT+TFXOIVA=;
        b=vGhj9QFDSU2xuV5lGa36aXMLfuv0TSyd1l1uZcKRY8B8j6UA9+8To3e52DfNaaeNjk
         n81cu1ULhy0MIa2FAz8xBRHSXNQePxHUvY6AvlO9k8vxD8SuiqxoTT6oKW8W7ZX3WO2p
         6iyknh2Wbm+/RdQxSf2yNojt75upEeevpeVO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KdR9YLUe4bo/l6JXgcEo55swsbK/stiUvCF277kexfsTj1NtjcjHRnTLQZPP248J3N
         siufHvB+FdgDA/r0T7wxXFpir5nZSArT4Ym5MTDlPBTEk6EPHPv8WyBcVccC1MWzyvqr
         gh82xfS6m4bmaQDhFFe4WjbJ4ai5XDKJutEaQ=
Received: by 10.114.25.3 with SMTP id 3mr3808039way.22.1217146866913;
        Sun, 27 Jul 2008 01:21:06 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sun, 27 Jul 2008 01:21:06 -0700 (PDT)
In-Reply-To: <20080727162750.25b7cdf3@whitehouse.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90324>

2008/7/27 Daniel White <daniel@whitehouse.id.au>:
> "Catalin Marinas" <catalin.marinas@gmail.com> wrote:
>>
>> I also use "python setup.py bdist_rpm" when releasing, I think it will
>> get confused by a different prefix.
>
> Not being familiar with distutils, I didn't even see that use case.

I use "python setup.py bdist_rpm", though passing --prefix would
probably fix it.

> Regardless, the instructions are incorrect and the behaviour surprising.
> When I installed this in a cygwin environment, it went on to clobber
> my system directories.
>
> Would it be more useful to have the Makefile handle the general case and
> setup.py for more specialised cases, such as generating an rpm?

I agree.

> I've thrown some patches together that does some of this.  I can tidy
> these up and put them in a public repository if this sounds like a
> reasonable plan of attack.

Yes, it is. Please base them on my (or Karl's) latest git tree as I
already merged this patch.

Thanks.

-- 
Catalin
