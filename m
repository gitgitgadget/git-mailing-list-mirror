From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Silence iconv warnings on Leopard
Date: Thu, 6 Dec 2007 16:12:49 -0800
Message-ID: <985966520712061612r3dd167dax3adf433313a40a0d@mail.gmail.com>
References: <1196968023-45284-1-git-send-email-win@wincent.com>
	 <985966520712061504s686395d6jf680363c7b3b9de7@mail.gmail.com>
	 <200712070111.23283.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 01:13:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Qq9-0000lP-VF
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 01:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbXLGAMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 19:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbXLGAMv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 19:12:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:5530 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbXLGAMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 19:12:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so987468wah
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 16:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ztyOeAOIbH+UFnlUohMhcyLJut+K45Qz74MhmnuxHRM=;
        b=s2+xEFDUGHefbbXKLRUrlJYyu3WJJ89SKdaqBI8yK4F0HzmlPBuhb6EIZYiMY93QOUsRpR51sJdP3iiZCm9N7hDmfdo/Pt3cfn1YBCeiXUVYQYV5CzQM16FYleCtvGCYKSRDfK3guY64o3efXRx0D5Z5TepPqV9TGdWc3dYe11w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MY7TDaGmUsFIN6SaGnKJejU4j5OTQG48FErZPtmML3o7ML0ya5aYDZCKsa7RMDGfzYYxRC/8i1xXlg656PYpr+DsBPLWExPVY9O87vsCGzl8uidCENNGjmMK/vH2bNr21oCRM7EBqwPHbS0cWSjgKamdBmDmQJDrGzIeT01o6Io=
Received: by 10.114.199.1 with SMTP id w1mr2057994waf.1196986369707;
        Thu, 06 Dec 2007 16:12:49 -0800 (PST)
Received: by 10.115.110.7 with HTTP; Thu, 6 Dec 2007 16:12:49 -0800 (PST)
In-Reply-To: <200712070111.23283.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67358>

On Dec 6, 2007 4:11 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> I would be interested, as I tried to make a patch to configure.ac which
> does that. The problem is that it should be check that tests for compile
> time _warnings_; my solution was to use '-Werror' flag to make warning
> into error, and AC_COMPILE_IFELSE, but this might be gcc only solution.

That's precisely what I did. If this isn't suitable, then bummer --
impossible ;).

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
