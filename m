From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Problems Fetching from HTTP?
Date: Thu, 1 Apr 2010 18:29:07 +0200
Message-ID: <20100401162907.GA3783@inner.home.ulmdo.de>
References: <v2xc115fd3c1004010803g98a279e8mf395a0d14be4f6bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 18:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxNGj-0006QL-2q
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 18:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550Ab0DAQ3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 12:29:14 -0400
Received: from continuum.iocl.org ([213.146.114.200]:62347 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534Ab0DAQ3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 12:29:13 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o31GT7805417;
	Thu, 1 Apr 2010 18:29:07 +0200
Content-Disposition: inline
In-Reply-To: <v2xc115fd3c1004010803g98a279e8mf395a0d14be4f6bd@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143734>

On Thu, 01 Apr 2010 11:03:20 +0000, Tim Visher wrote:
...
>     error: Failed connect to git.kernel.org:80; Connection refused
> while accessing http://git.kernel.org/pub/scm/git/git.git/info/refs
> 
>     fatal: HTTP request failed
> 
> What could be going on here?  I can't pull from `git://` as I'm behind
> a firewall.

It pretty much looks like the firewall doesn't let you directly access
HTTP as well. You may need to use your proxy, and you (seem to) need to
set the environment variable 'http_proxy="http://10.0.0.1:3128"' to
point to your proxy. Google will take you from there, like
http://rip747.wordpress.com/2008/09/12/git-clone-over-http-who-knew/

Andreas
