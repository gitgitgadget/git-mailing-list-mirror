From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: SLES 9 git packages [WAS: SLES 10 git packages]
Date: Fri, 1 Feb 2008 06:37:41 +0100
Message-ID: <200802010637.42874.robin.rosenberg@dewire.com>
References: <20071016072742.GA11450@cip.informatik.uni-erlangen.de> <20071017135202.GK18279@machine.or.cz> <20080201051619.GE8266@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 06:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKobG-00026U-SH
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 06:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYBAFhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 00:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYBAFhf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 00:37:35 -0500
Received: from [83.140.172.130] ([83.140.172.130]:8663 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbYBAFhe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 00:37:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D715180266C;
	Fri,  1 Feb 2008 06:37:29 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HFtVWYX20ZZT; Fri,  1 Feb 2008 06:37:29 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1C879802641;
	Fri,  1 Feb 2008 06:37:27 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20080201051619.GE8266@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72150>

fredagen den 1 februari 2008 skrev Thomas Glanzmann:
> Petr,
> 
> > > is there someone out there who maintains up2date git packages for SuSE
> > > Linux Enterprise Server 10?
> 
> >   there seem to be some in the build service:
> 
> > 	http://download.opensuse.org/repositories/devel:tools:scm/SLE_10
> 
> now I am looking for packages for SLES 9. Anyone?

I think you can grab the src rpm in the SLE10/src directory and rpmbuild --rebuild it.
As git's dependencies are quite simple, that should work. 

-- robin
