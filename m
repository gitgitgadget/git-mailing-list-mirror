From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 15:31:52 -0800 (PST)
Message-ID: <m3pr78bywe.fsf@localhost.localdomain>
References: <4B0ABA42.1060103@syntevo.com>
	<200911231845.04325.trast@student.ethz.ch>
	<4B0AD02E.1040408@syntevo.com>
	<alpine.DEB.1.00.0911231916510.4897@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Singer <thomas.singer@syntevo.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 00:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCiO7-0006yu-N2
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 00:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328AbZKWXbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 18:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757116AbZKWXbu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 18:31:50 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:45049 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756978AbZKWXbs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 18:31:48 -0500
Received: by bwz23 with SMTP id 23so5823740bwz.29
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 15:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=fjA8jAa3AbfUlPMY62oixT98miAVCXY/6efyX/wyKLo=;
        b=MSGvADR4t7EbOjuwdo6xQ/wUOhhgl1kfdRMO0ocKPrQJThhd88m0dMPMcyCQG0S4sU
         gGjZhg5mlMgSYB95ha2dAYpt9l+D+vUffJ1e6qnf5UvZfJXSZreeATMPgp8l8GPfZzBZ
         bUSvrkxBeSJ9oQudT66jinuR0FU3LsbRgXkek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Aj+R2xUELdbtEV0pU623222CFmldS1d2IxnYbUhmy2Y9oNytJq8qDNncOX7ywIW0Uq
         013UxZH8h+P8+k6uqry+bJGn9DzAdLDfPlOOVr4iD7fi+rg+mJR9bic6javF1wwoPGZk
         4FJi5gWOJNPCoIIXqTOQ/4yOc6noz6XOOMWag=
Received: by 10.204.13.215 with SMTP id d23mr5613486bka.18.1259019113700;
        Mon, 23 Nov 2009 15:31:53 -0800 (PST)
Received: from localhost.localdomain (abvk170.neoplus.adsl.tpnet.pl [83.8.208.170])
        by mx.google.com with ESMTPS id 16sm1265975bwz.7.2009.11.23.15.31.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 15:31:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nANNWgPX014913;
	Tue, 24 Nov 2009 00:32:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nANNWdTQ014909;
	Tue, 24 Nov 2009 00:32:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0911231916510.4897@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133543>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 23 Nov 2009, Thomas Singer wrote:
> 
> > Basically, getting it "somehow" to work on OS X is just one minor step. 
> > IMHO Git should standardize on file names in the repository and do the 
> > platform-specific conversion independent of any locale setting, if 
> > needed.
> 
> That is contrary to the design of Git which honors content (byte-wise!) as 
> much as possible, and treats file names very much as content.
> 
> There were beginnings of supporting OSX' brain-damaged filename mangling, 
> but an obnoxious OSX fan worked very hard on trying to defend the OSX 
> design and to decry Git's respect for the raw bytes on this list, so hard 
> that even the nicest developers had no fun working on this issue anymore.
> 
> This little background may help you understand why there is no solution 
> implemented in Git yet.  And maybe quite a few developers are reluctant to 
> discuss the issue and possible solutions due to said sad story, too.

To be more exact the problem is not that MacOS X uses denormalized
form (does file mangling).  This would be the problem only in
cross-platform development (where some developers would work from
different operating system).

The problem is that the name under which Git creates file is different
from the name MacOS X lists file (in readdir etc.).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
