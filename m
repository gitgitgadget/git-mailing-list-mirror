From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 08 Jun 2007 20:33:19 -0300
Message-ID: <4669E73F.2040702@xs4all.nl>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>	 <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>	 <4669CAB4.5080507@slamb.org> <4669CB75.7060009@slamb.org> <1621f9fa0706081504l6106c639oe57c9fd74ebd097a@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Scott Lamb <slamb@slamb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 01:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwo0e-0006rj-MF
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbXFHXgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbXFHXgp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 19:36:45 -0400
Received: from main.gmane.org ([80.91.229.2]:57825 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbXFHXgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 19:36:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hwo0D-0001s8-E9
	for git@vger.kernel.org; Sat, 09 Jun 2007 01:36:22 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 01:36:21 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 01:36:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <1621f9fa0706081504l6106c639oe57c9fd74ebd097a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49520>

Benjamin Sergeant escreveu:

> So are you saying that in the old days, git-p4 was importing the p4
> depo in small slices to not overkill the process memory (in case the
> depo is big) ?

no, in the "old days" git-p4 used a separate p4 invocation for each file.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
