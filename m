From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH/RFC (take 3)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Fri, 7 Dec 2007 00:29:42 -0800
Message-ID: <985966520712070029y2a3402caia81524f8dc0c608e@mail.gmail.com>
References: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
	 <1196990840-1168-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Pascal Obry" <pascal@obry.net>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Arjen Laarhoven" <arjen@yaph.org>,
	"Brian Gernhardt" <benji@silverinsanity.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 09:30:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Yaz-0000aw-BB
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 09:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbXLGI3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 03:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXLGI3o
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 03:29:44 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:29394 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbXLGI3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 03:29:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1307491wah
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NTm1RDOcNu7xCGNIFIDuVyxwMS7gX6/4m+1iw7zdiaA=;
        b=KpeAgpUvC1HVIqvCcDrBiKKxCiVjTWf2IH884SfFVd6rj6jlAr+kKyo0LDeYJ182Xzv4LmahpY3g24gxGP+EiNq8qSKOg3kcYI/1Mftr3E+zvn6rtyHK1YQ7EUmZ+xaX1wIg8p1qdsS/T1u1W9rffg+oSHqObHqfcVxyr/2vY0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5CWIpK33GHhTMw6CIyQUamrPuCP61PP3YRBnmGdeM+odtoRLWRAR96aVj4x+R2oTYyUnfrc/FEJeQjdr67uZSKbONTaUIZid27m2FUac6o6rP7KypjisjgYj6sTP1xH66N3aMclZPi/PQT7at7FPk47jDubWtj6+eGo5LwhUl4=
Received: by 10.114.169.2 with SMTP id r2mr2826698wae.1197016183031;
        Fri, 07 Dec 2007 00:29:43 -0800 (PST)
Received: by 10.115.110.7 with HTTP; Fri, 7 Dec 2007 00:29:42 -0800 (PST)
In-Reply-To: <1196990840-1168-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67399>

On Dec 6, 2007 5:27 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Is something like the patch below what you wanted to try?

Yes. Not sure if main() is required, so it might be shorter if that's
removed, but not really relevant as long as it works.

And CHECKS for header files might be considered chatty.

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
