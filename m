From: "Greg Lee" <glee@casabyte.com>
Subject: RE: Problem with git bisect between 2.6.15 and 2.6.16
Date: Wed, 29 Mar 2006 14:28:07 -0500
Message-ID: <117a01c65366$e952dfd0$a100a8c0@casabyte.com>
References: <12c511ca0603271622n6e4614b2s6f936469863efd9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'sean'" <seanlkml@sympatico.ca>,
	"'Tony Luck'" <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Wed Mar 29 21:30:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOgND-0006h2-GV
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 21:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWC2TaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 14:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWC2TaU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 14:30:20 -0500
Received: from mail.vtacs.com ([207.42.84.219]:17630 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S1750811AbWC2TaS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 14:30:18 -0500
Received: from GregDesktop (e242.vtacs.com [207.42.84.242])
	by mail.vtacs.com (8.13.6/8.13.3) with ESMTP id k2TJU2jQ005594;
	Wed, 29 Mar 2006 14:30:07 -0500
To: <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <12c511ca0603271622n6e4614b2s6f936469863efd9d@mail.gmail.com>
Thread-Index: AcZR/bastIYtt6KrS1+Kc8O6HAm+fQBZffRA
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18178>

> You'll need to invert "good" and bad" for this.  I.e. mark 2.6.15 as good, 2.6.16 as
bad, and
> then as you test mark kernels with the bug as good, and ones without as bad.  Try not to
go
> insane while working in this inverted parallel universe :-)
> 
> -Tony

This was progressing fine until I ran into an issue that makes the kernel unstable causing
it to crash at semi-random times.  I'm down to about 350 commits left in the bisect.  I've
tried:

git reset --hard HEAD~3

no luck, same problem, unstable

then I tried --hard HEAD~50

no luck, same problem, unstable

I'm concerned about moving too much further in the "~" direction, will this cause me other
problems?

Greg
