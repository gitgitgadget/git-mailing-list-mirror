From: "Wu, Bryan" <bryan.wu@analog.com>
Subject: Re: Help: git-quiltimport error
Date: Wed, 28 Mar 2007 12:04:28 +0800
Organization: Analog Devices, Inc.
Message-ID: <1175054668.15391.9.camel@roc-desktop>
References: <1175014867.15767.13.camel@roc-laptop>
	 <euc6ra$qqu$1@sea.gmane.org>  <1175053761.15391.7.camel@roc-desktop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Biederman <ebiederm@lnxi.com>, git@vger.kernel.org
To: bryan.wu@analog.com
X-From: git-owner@vger.kernel.org Wed Mar 28 06:04:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWPOF-0004RD-Ag
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 06:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbXC1EDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 00:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbXC1EDp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 00:03:45 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:26549 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXC1EDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 00:03:44 -0400
Received: from nwd2mhb2.analog.com ([137.71.6.12])
  by nwd2mail10.analog.com with ESMTP; 28 Mar 2007 00:03:43 -0400
X-IronPort-AV: i="4.14,336,1170651600"; 
   d="scan'208"; a="32833804:sNHT30373756"
Received: from nwd2exm4.ad.analog.com (nwd2exm4.ad.analog.com [10.64.53.123])
	by nwd2mhb2.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id AAA20708;
	Wed, 28 Mar 2007 00:03:44 -0400 (EDT)
Received: from 10.99.22.84 ([10.99.22.84]) by nwd2exm4.ad.analog.com ([10.64.53.123]) via Exchange Front-End Server owa.analog.com ([10.64.25.43]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 28 Mar 2007 04:03:42 +0000
Received: from roc-desktop by owa.analog.com; 28 Mar 2007 12:04:28 +0800
In-Reply-To: <1175053761.15391.7.camel@roc-desktop>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43352>

On Wed, 2007-03-28 at 11:49 +0800, Wu, Bryan wrote:
> On Wed, 2007-03-28 at 00:49 +0200, Jakub Narebski wrote:
> > Bryan Wu wrote:
> > 
> > > When I am using latest git-quiltimport, I met following errors. 
> > > 
> > > $git-quiltimport --dry-run --author "Bryan Wu <bryan.wu@analog.com>" \
> > >                  --patches "/home/roc/mm-tree/patches"  
> > > /usr/local/bin/git-quiltimport: 114: Syntax error: Missing '))'
> > > 
> > > Could you please help me on this?
> > 
> > While at it, would it be hard to add --fast option which would make
> > git-quiltimport to use git-fast-import mechanism?
> > 
> 
> oh, can this fix the bug?
> I am trying to import -mm series patch set to a git tree. Is there any
> git command similar with quilt push/pop? I am trying StGit, but it can't
> recognize the commits from git-quiltimport. Could you give me some
> hints?
> 

Oh, maybe guilt is a good choice.

Thanks
-Bryan Wu
