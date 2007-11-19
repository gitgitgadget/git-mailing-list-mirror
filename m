From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Mon, 19 Nov 2007 13:15:37 +0000
Message-ID: <b0943d9e0711190515x3f58748bm224366ddb292755d@mail.gmail.com>
References: <200711190005.49990.jnareb@gmail.com>
	 <b0943d9e0711190320r28224763t5a6c9ed7758a12b3@mail.gmail.com>
	 <200711191257.09158.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 14:16:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6Tj-0006b1-JP
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbXKSNPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbXKSNPi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:15:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:53569 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXKSNPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:15:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1414969rvb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 05:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aLHJ4g5/IVfOApBkTBdMu+cUlm+9sqCY7broBV6LPTs=;
        b=sbqjSTphBYhkzLCY+n/SLAjfd4H4Mt7g771PYdsb/h5dQS8BBGuGg2X3QcrfIqWypTGoC3qKaJ/lt6xUvAM1yNiFRU9omhvhE1NmOXV6HY2ujNT9Jv1sAtM5ZBKphZ5zDoNGg5FMnRNmPWlN1zj20EdKkm29fowDgTzjCayvjPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iAQiDxl3jNwrdhuIzjfqHxvfVPkyMTwWZITuhsYhYeAAT/TJi5Ee0GRIMm16Lq4weWqVbXDhCPndHpp+OJOG9jYsWBiIVB0pKaokAoGu+ko3Aa/2VgWLHaiJ95ajPR+smPuRESYrWy50DtNAW3lGnA7/FQ4yatvUzJxMgVn5uzA=
Received: by 10.141.132.8 with SMTP id j8mr2009625rvn.1195478137040;
        Mon, 19 Nov 2007 05:15:37 -0800 (PST)
Received: by 10.141.170.11 with HTTP; Mon, 19 Nov 2007 05:15:37 -0800 (PST)
In-Reply-To: <200711191257.09158.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65436>

On 19/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> Catalin Marinas wrote:
> > On 18/11/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > > I use Stacked GIT 0.13 with git 1.5.3.5 (and Python 2.4.3).
> > > StGIT does recognize old StGIT branches (and converts them),
> > > but "stg branch -l" list only one branch. I guess that is
> > > cause by the fact that all the rest of branches are packed.
> >
> > Have you tried the latest StGIT snapshot? We added support for this
> > and it will be available in 0.14 (to be released pretty soon).
>
> Would it work with Python 2.4.3? Yes, I know I should upgrade my
> Linux distribution (I use now Aurox 11.1, which is based on Fedora
> Core 4)...

Yes, it works with Python 2.4. We deprecated the Python 2.3 support.

-- 
Catalin
