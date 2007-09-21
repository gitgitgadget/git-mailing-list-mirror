From: "Peter Stahlir" <peter.stahlir@googlemail.com>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 13:41:07 +0200
Message-ID: <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
	 <Pine.LNX.4.64.0709211208440.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 13:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYgsn-00011W-4t
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 13:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbXIULlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 07:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbXIULlK
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 07:41:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3230 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXIULlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 07:41:09 -0400
Received: by ug-out-1314.google.com with SMTP id z38so504999ugc
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZvkrHjudNso6jEhR1A2Hx9/6uTqxZZUjeqc0KvvqK9U=;
        b=N+PVWiDkBFnStgbuXFvy+arVJld9EwMJlu1OZyXG31RP2BY0duvkVSGWqccrjQgEHq5yThFeXbJfQQjAqpnURHDfCI425nCvke4179vNEt5KOQfK5PONlNrjaoulDJ1S42J3al6aXHc3G94HEpbVX1dkAGNSP/a4uPMmZ5qirbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fnnTCJJL/lQTM/hEm7vMuLLYLR25SdkMay7KKzOf+xRPDDY2u+ljmHUt/4z9pg9EkEcuAOj6mrB4U1forhuu/goHzluyGNdySeXbuXgqYq1rJoH7zHWR0yvl+Ty503osl3dFtNc//n5QEeHHEXQzaGNNl03YM7L+6oTwB9Xflnk=
Received: by 10.78.171.20 with SMTP id t20mr1916240hue.1190374867653;
        Fri, 21 Sep 2007 04:41:07 -0700 (PDT)
Received: by 10.78.140.12 with HTTP; Fri, 21 Sep 2007 04:41:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709211208440.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58846>

2007/9/21, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 21 Sep 2007, Peter Stahlir wrote:
>
> > Is it possible/feasible to use git as a filesystem?
> > Like having git on top of ext3.
>
> I haven't looked at it closely, but there is a GitFS:
>
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-f354b40618742b976c13700fe1fea28387ad5c89
>
> (I am pointing you to the Git Wiki, so that you can find more pointers
> should you not be happy with this one.)

Thank you.
This is was I was looking for. My motivation is whether it is possible
to run a system, for example Debian on a computer on top of gitfs,
and then have a huge mirror on it, for example a complete 252GB
Debian mirror as space efficient as possible.

I wonder how big a deltified Debian mirror in one pack file would be. :)

Peter
