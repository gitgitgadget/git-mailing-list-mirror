From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 15:23:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171522510.4991@intel-tinevez-2-302>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>  <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>  <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>  <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
  <4A8932BB.7030002@viscovery.net>  <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>  <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302> <eaa105840908170552m3eaf0f92j523ddad98dd67a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 15:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md2Bc-0004yl-JA
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 15:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZHQNXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZHQNXd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 09:23:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:56710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752282AbZHQNXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 09:23:33 -0400
Received: (qmail invoked by alias); 17 Aug 2009 13:23:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 17 Aug 2009 15:23:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aGYRZeBcald+UfnqGMPIN0SXFFBFoAzgfq60FkV
	WXh4QsYMqY7C1Y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <eaa105840908170552m3eaf0f92j523ddad98dd67a3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126179>

Hi,

On Mon, 17 Aug 2009, Peter Harris wrote:

> On Mon, Aug 17, 2009 at 8:29 AM, Johannes Schindelin wrote:
> > If I want to have a sparse checkout, I know which files I _want_.
> 
> That's funny. I have a git tree that would benefit from sparse checkout. 
> I know which path I _don't_ want. Specifying all the paths I want would 
> be a rather longer (and more error-prone) list. I suspect it would be 
> best to support both.

Yes, I agree, but the common case is for people to know what they are 
working on, right?

> Does sparse use the same parser as .gitignore? (I guess not, if it
> handles trailing slashes differently?) If so, it would be trivial to
> turn "exclude path" into "exclude all but path" (or vice-versa) with:
> 
> *
> !path

That was the idea behind my suggestion to allow .gitignore syntax.  And 
indeed, that is what happened.

Ciao,
Dscho
