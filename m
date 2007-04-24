From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: bug with gitweb on kernel.org
Date: Mon, 23 Apr 2007 18:06:48 -0700
Message-ID: <1177376808.5357.13.camel@localhost.localdomain>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
	 <1177286943.24896.14.camel@localhost.localdomain>
	 <alpine.LFD.0.98.0704222112040.28339@xanadu.home>
	 <1177294925.24896.48.camel@localhost.localdomain>
	 <f0jkvm$31p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 03:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9Uu-0007KV-IZ
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 03:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031017AbXDXBHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 21:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031022AbXDXBHF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 21:07:05 -0400
Received: from shards.monkeyblade.net ([192.83.249.58]:34033 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031017AbXDXBHE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 21:07:04 -0400
Received: from [10.255.255.198] (65-115-68-194.dia.static.qwest.net [65.115.68.194])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.13.8/8.13.8) with ESMTP id l3O16vL6030528
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 23 Apr 2007 18:06:57 -0700
In-Reply-To: <f0jkvm$31p$1@sea.gmane.org>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: ClamAV 0.88.7/3152/Mon Apr 23 15:34:59 2007 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45399>

On Tue, 2007-04-24 at 03:06 +0200, Jakub Narebski wrote:
> J.H. wrote:
> 
> > Well the only difference in the pages being served is the mime type
> > application/html vs. application/xhtml+xml.  Does anyone know the
> > original impetus to using application/xhtml+xml (despite the fact that
> > it's technically the correct choice) vs. just using application/html for
> > everything?  I'm sure there was a good reason behind it and I'd rather
> > know what that reason was before I got changing things
> 
> The idea was to serve application/xhtml+xml to browsers which _explicitely_
> support it. But coupled with the fact that gitweb on kernel.org is modified
> gitweb with caching, and it looks like it caches also HTTP headers...
> I think simplest solution would be to remove complication, and always serve
> text/html (at least for kernel.org gitweb with caching modifications).
> 

It's either that or store only the data not the headers and deal with
the headers on each request - but that might have other unintended
consequences I haven't thought of yet.  Anyway I think your right -
short term solution if nothing else is serve out text/html and look more
closely at the problem when I rebase.

- John 'Warthog9' Hawley
