From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Using git for file archival/backup purposes - deletion strategy
Date: Fri, 28 Dec 2007 11:08:20 +1300
Message-ID: <46a038f90712271408k7763d60ai93491f59c75d0e35@mail.gmail.com>
References: <46a038f90712261443t6aa0cd76u46d8ae88fc7c1eba@mail.gmail.com>
	 <4773D498.8040204@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 23:08:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J80uQ-0000wx-9S
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXL0WIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXL0WIW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:08:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:54592 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbXL0WIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:08:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1716760ugc.16
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 14:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A5q6O+Iz3BhU3m/7HsNdYW/4cdtn15GAk9NPNTFnEoo=;
        b=lHFBHe2p00edM9Vx8AU1vFi3MVT80oZQLWWj/ha97ye9EWCXJ/4skpV12Zp3xItkDAwVrb9n6WVQ3uyvYyU2mg04xNQeey1/4dI93hUD8lYr0wbgECjudrMFlLRNA6IgaA2ozzwaxqCjVuX3UwqF+WFUxoSoRKLX3bE4YaZUaL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oIXl5enVnzSnJ1J99Fr6zD8+ucTYzdH8QSBuaX1hXSVhPtmJ2GBLRfWeCz1t+4+ZTFuXybM9gufc02T6FB+ZZCeJ9j8+CUIuKqNpRtDH3cUOvuaFUYCXz6JWck1qejmyTn0mwW0yeITfyGS71NgwRjxRbru44sq2sfC9l8RHlng=
Received: by 10.66.239.16 with SMTP id m16mr7600740ugh.11.1198793300294;
        Thu, 27 Dec 2007 14:08:20 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 27 Dec 2007 14:08:20 -0800 (PST)
In-Reply-To: <4773D498.8040204@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69265>

On Dec 28, 2007 5:36 AM, Charles Bailey <charles@hashpling.org> wrote:
> Martin Langhoff wrote:
> > Ah! Local clones won't honour --depth!. A clone from git.kernel.org
> > does get its .git/shallow file.
>
> This should be fixed in git v1.5.4-rc0 and later.  For reference
> what version of git are you using?

Good point. I was using a 1.5.3xx. I can confirm it's fixed with
1.5.4.rc1.1136.g2794f - I get the shallow clone I expected.

cheers!


m
