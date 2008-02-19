From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Tue, 19 Feb 2008 22:21:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802192220440.7826@racer.site>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:22:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRar3-000064-At
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbYBSWVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 17:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbYBSWVu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 17:21:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:33134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754503AbYBSWVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 17:21:49 -0500
Received: (qmail invoked by alias); 19 Feb 2008 22:21:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 19 Feb 2008 23:21:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HxFBwi12HLGxzBBIQ2MX+Kg20TmncSOLHKw3FXh
	2o0URjYWzRWdn4
X-X-Sender: gene099@racer.site
In-Reply-To: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74469>

Hi,

On Tue, 19 Feb 2008, Whit Armstrong wrote:

> Does anyone have experience with this test failure in t1300-repo-config.sh:
> 
> * FAIL 61: invalid bool (set)
> 
> 
>                 git config --bool bool.nobool foobar
> *   ok 62: set --bool
> 
> * failed 1 among 70 test(s)

That is not very instructive.  Can you call the test with

	$ sh t1300-repo-config.sh -i -v

?

> make[1]: Leaving directory `/home/warmstro/download/git-1.5.4.2/t'

Ah, I guess it is 1.5.4.2.

Ciao,
Dscho
