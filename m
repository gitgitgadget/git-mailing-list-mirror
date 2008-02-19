From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Wed, 20 Feb 2008 00:31:27 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0802200030390.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com>  <alpine.LSU.1.00.0802192220440.7826@racer.site> <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRbwS-0007Sv-Fb
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYBSXba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYBSXba
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:31:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:40235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751121AbYBSXb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 18:31:29 -0500
Received: (qmail invoked by alias); 19 Feb 2008 23:31:27 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 20 Feb 2008 00:31:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WPYJzOtwWseO6oYIDntTw8ig+8HsKLCSFoIf6GY
	gu/hEMoOiBH5Sd
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74475>

Hi,

On Tue, 19 Feb 2008, Whit Armstrong wrote:

> Yes, it's git-1.5.4.2.  Sorry for the omission.
> 
> output from  $ sh t1300-repo-config.sh -i -v (had to use bash instead
> of sh, hope that's ok):
> 
> *   ok 60: invalid bool (--get)
> 
> * expecting failure:
> 
>         git config --bool bool.nobool foobar
> t1300-repo-config.sh: line -176: 18181 Segmentation Fault      (core
> dumped) git config --bool bool.nobool foobar
> * FAIL 61: invalid bool (set)

And?  Did you actually start that command line with a debugger in 
t/trash/?

Hth,
Dscho
