From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Mon, 17 Dec 2007 17:21:08 -0800 (PST)
Message-ID: <m3tzmgpzlu.fsf@roke.D-201>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Dougherty <doughera@lafayette.edu>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4R9M-0004za-H5
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbXLRBVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXLRBVM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:21:12 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:37434 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXLRBVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:21:11 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1755166fkz.5
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 17:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=0XXHupTaqahRq9AsY/abFjU/56Jmze5Crru71WK9+Yc=;
        b=fnntQniMJ5/kPRdn7tAbbCvhEyQNC2YmyEHtLCfrn53/gKRUxCOvRIcWvfKwkqhK98U+eQ0kKYhdqa8sS5DNYsR7SUhfl4owGNfxAlvwH5mqNuYX4YVpN1ulYoGgEa6BBHWlba0cdwqkwj1InppNPU89AtWNqS634epvlIBVeic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=sG0f1PrPIc1BZyOtREIWmg5bdmkfV+ZdTziUZc3duhGCiVSK+neJ1OWDcgL1wsAAtD2qWdHRWHa7eb58NAF0togCcbEJKxX4iUzc1y5iPgws/msVgZPvotwK7xX2piwqSmA0Wm+G2kUDOKzUKdxJspJPSvA7KoAT20QurUCjq3s=
Received: by 10.82.161.19 with SMTP id j19mr1701532bue.20.1197940869507;
        Mon, 17 Dec 2007 17:21:09 -0800 (PST)
Received: from roke.D-201 ( [83.8.196.52])
        by mx.google.com with ESMTPS id d27sm17083162nfh.2007.12.17.17.21.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2007 17:21:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBI1L3am006760;
	Tue, 18 Dec 2007 02:21:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBI1L1np006757;
	Tue, 18 Dec 2007 02:21:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68682>

Andy Dougherty <doughera@lafayette.edu> writes:

> [...].  Perhaps configure
> should just go looking for a suitable install program instead of
> assuming everyone has one.

First, configure is, and (I think) consensus is that it should remain
optional.  This means that Makefile "guess" section should have good
defaults for your operating system.

Second, the default autoconf macro AC_PROG_INSTALL *requires* that
there is BSD-compatible `install' program (as 'install-sh' or
'install.sh') in the sources.  Adding such script is (I think) not a
problem; finding minimal portable[*1*] script is.  So if you know
one...


Footnotes:
----------
[*1*] By "portable" I mean here 'git portable', i.e. requiring only
those shell constructs/features that git require, not necessary
insanelt portable the way ./configure script is.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
