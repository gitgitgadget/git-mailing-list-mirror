From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Silence iconv warnings on Leopard
Date: Thu, 6 Dec 2007 15:04:08 -0800
Message-ID: <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com>
References: <1196968023-45284-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 00:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Plh-00034b-V4
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 00:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbXLFXEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 18:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbXLFXEK
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 18:04:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:16732 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbXLFXEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 18:04:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so942001wah
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 15:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yzWV6nWP5WN+bd0IZgme3m1vLmL5LmpLkag500Rc7to=;
        b=FRoRQLAKa3BWO5u2v+3nHrmh6V/MPmF5ZReGtpIW1m3n8DKGKKbUGxZtcMJpYx59nyUo+OlgGXWcISm6I7TozgdDb4MWGi67Ie7avCm9mo6QBDNgP/Edq6BAZD/n52HukjtN4hohIIJ0bRSY9DrpH6a2K/1xi5df34e8uodpDFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BXQxugRJ/b0w53wR0OjKbbumiww56DA3Gd/YxDt/U7pF9WLW7RxZPMmL35qY65yQk4m+OLrUfDlvl0XpWAjMNAYhMlELJLsPlnck2c+7a5TqvgQq8kF2sRyeCjhkcUQTAquMUjHVob/+qvte+e9c0E5bbQ97qxZHPgpnyOfADCI=
Received: by 10.114.53.1 with SMTP id b1mr2227795waa.1196982248343;
        Thu, 06 Dec 2007 15:04:08 -0800 (PST)
Received: by 10.115.110.7 with HTTP; Thu, 6 Dec 2007 15:04:08 -0800 (PST)
In-Reply-To: <1196968023-45284-1-git-send-email-win@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67353>

On Dec 6, 2007 11:07 AM, Wincent Colaiuta <win@wincent.com> wrote:
> Apple ships a newer version of iconv with Leopard (Mac OS X 10.5/Darwin
> 9). Ensure that OLD_ICONV is not set on any version of Darwin in the
> 9.x series; this should be good for at least a couple of years, when
> Darwin 10 comes out and we can invert the sense of the test to
> specifically check for Darwin 7 or 8.

This approach seems fine to me, there was some concern about matching
the OS type / version in the past, but I haven't really seen a better
answer.

> A more sophisticated and robust check is possible for those who use
> autoconf, but not everybody does that.

I did make a patch for configure.ac that does this. If it's
interesting, I'll send it along.

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
